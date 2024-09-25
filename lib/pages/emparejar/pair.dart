import 'dart:math';

import 'package:aula_abierta/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PairingGame extends StatefulWidget {
  @override
  _PairingGameState createState() => _PairingGameState();
}

class _PairingGameState extends State<PairingGame> {
  late List<Map<String, dynamic>> notes;
  late List<String> imageOrder;
  late List<int> valueOrder;
  final formatter = NumberFormat('#,###');
  String _message = "Empareja las imágenes de monedas y billetes con sus respectivos valores";

  @override
  void initState() {
    super.initState();
    _loadDataFromHive();
    _fillRandomArrays();
  }

  void _loadDataFromHive() {
    Box<Map<String, dynamic>> noteBox = Hive.box('noteBox');

    Iterable keys = noteBox.keys;

    notes = [];
    for (String key in keys) {
      var note = noteBox.get(key);
      if (note is Map<String, dynamic>) {
        notes.add(note);
      }
    }
  }

  List<int> _generateRandomArray(int size) {
    Random random = Random();
    List<int> arr = [];
    arr.add(random.nextInt(size));

    for (int i = 1; i < size; i++) {
      int rand = random.nextInt(size);
      while (arr.contains(rand)) {
        rand = random.nextInt(size);
      }
      arr.add(rand);
    }

    return arr;
  }

  void _fillRandomArrays() {
    imageOrder = _generateRandomArray(notes.length)
        .map((value) => notes[value]['route'] as String)
        .toList();
    valueOrder = _generateRandomArray(notes.length)
        .map((value) => notes[value]['value'] as int)
        .toList();
  }

  String? selectedImage;
  int? selectedValue;

  void _checkPair() {
    if (selectedImage != null && selectedValue != null) {
      int index = notes.indexWhere(
              (pair) => pair['route'] == selectedImage && pair['value'] == selectedValue);
      if (index != -1) {
        imageOrder.removeWhere((i) => i == selectedImage);
        valueOrder.removeWhere((i) => i == selectedValue);
        setState(() {
          notes.removeAt(index);
          selectedImage = null;
          selectedValue = null;
          _message = "¡Bien hecho! Combinaste correctamente una moneda o billete con su valor";
        });

        if (notes.isEmpty) {
          _showWinDialog();
        }
      } else {
        setState(() {
          selectedImage = null;
          selectedValue = null;
          _message = "Esa moneda o billete y ese valor no corresponden, intentalo de nuevo";
        });
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¡Ganaste!"),
          content: const Text("Has logrado emparejar todos los billetes y monedas con sus valores."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close popup
                Navigator.of(context).pop(); // Go back to last page
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade600,
              ),
              child: const Text(
                'Ok',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Emparejar'),
      body: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Text(
                _message,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              _buildImageGrid(),
              const SizedBox(
                height: 32,
              ),
              _buildValueGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        notes.length,
            (index) {
          String image = notes.firstWhere((element) => element['route'] == imageOrder[index])['route'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedImage = image;
              });
              _checkPair();},
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedImage == image
                    ? Colors.grey.shade400
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Image.asset(image),
            ),
          );},
      ),
    );
  }

  Widget _buildValueGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        notes.length,
            (index) {
          int value = notes
              .firstWhere((element) => element['value'] == valueOrder[index])['value'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = value;
              });
              _checkPair();},
            child: Container(
              width: 80, // Adjust this width based on your UI design
              height: 40, // Adjust this height based on your UI design
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedValue == value
                    ? Colors.grey.shade400
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  formatter.format(value),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );},
      ),
    );
  }
}
