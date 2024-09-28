import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PairingGame extends StatefulWidget {
  const PairingGame({super.key});

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
    notes = NoteUtils.loadNotes();
    imageOrder = RandomUtils.randomList(notes.length)
        .map((value) => notes[value]['route'] as String)
        .toList();
    valueOrder = RandomUtils.randomList(notes.length)
        .map((value) => notes[value]['value'] as int)
        .toList();
  }

  int? wasUserCorrect;
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
          wasUserCorrect = 1;
        });

        if (notes.isEmpty) {
          _showWinDialog();
        }
      } else {
        setState(() {
          selectedImage = null;
          selectedValue = null;
          _message = "Esa moneda o billete y ese valor no corresponden, intentalo de nuevo";
          wasUserCorrect = 0;
        });
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinDialog(description: "Has logrado emparejar todos los billetes y monedas con sus valores.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Emparejar'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _message,
              style: TextStyle(
                color: wasUserCorrect == 0
                    ? Colors.red
                    : wasUserCorrect == 1
                    ? Colors.green
                    : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              controller: ScrollController(),
              child: Column(
                children: [
                  _buildImageGrid(),
                  const SizedBox(height: 32),
                  _buildValueGrid(),
                ],
              ),
            ),
          ),
        ],
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
              _checkPair();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedImage == image ? Colors.grey.shade400 : Colors.transparent,
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Image.asset(image),
            ),
          );
        },
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
          int value = notes.firstWhere((element) => element['value'] == valueOrder[index])['value'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = value;
              });
              _checkPair();
            },
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedValue == value ? Colors.grey.shade400 : Colors.transparent,
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Center(
                child: Text(
                  formatter.format(value),
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}