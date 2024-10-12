import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/productUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteSelectionLevel extends StatefulWidget {
  final int difficulty;
  final VoidCallback onLevelCompleted;

  const NoteSelectionLevel({
    super.key,
    required this.difficulty,
    required this.onLevelCompleted,
  });

  @override
  _NoteSelectionLevelState createState() => _NoteSelectionLevelState();
}

class _NoteSelectionLevelState extends State<NoteSelectionLevel> {
  late List<Map<String, dynamic>> products;
  late List<List<int>> productOrder;
  late List<Map<String, dynamic>> notes;
  late List<List<int>> noteOrder;
  final formatter = NumberFormat('#,###');

  int levelCount = 5;
  int currentIndex = 0;
  String selectedImage = '';
  String feedbackMessage = 'Selecciona la moneda o billete de denominación mas baja que te permita pagar todos los productos';
  int wasUserCorrect = 2;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = ProductUtils.loadProducts();

    productOrder = RandomUtils.nRandomDistinctLists(levelCount, 2, 0, products.length);

    notes = NoteUtils.loadNotes();

    noteOrder = RandomUtils.nRandomDistinctLists(levelCount, 3, 0, notes.length);

    for(int i = 0; i < levelCount; i++){
      int correctValue = 0;
      for(int j = 0; j < productOrder[i].length; j++){
        correctValue += products[productOrder[i][j]]['value'] as int;
      }

      int highestValueIndex = 0;
      for(int j = 0; j < noteOrder[i].length; j++){
        if(notes[noteOrder[i][j]]['value'] as int >= correctValue){
          highestValueIndex = j;
          break;
        }
      }

      while (notes[noteOrder[i][highestValueIndex]]['value'] as int < correctValue){
        noteOrder[i][highestValueIndex] = RandomUtils.randomInRange(0, 9);
      }
    }
  }

  void _checkUserInput() {
    int correctValue = 0;
    for(int i = 0; i < productOrder[currentIndex].length; i++){
      correctValue += products[productOrder[currentIndex][i]]['value'] as int;
    }

    // TODO: fix this, as it is selecting the leftmost note with a value greater than or equal to the correct value
    String? correctImage;
    int correctIndex = 0;
    int lowestPositiveDifference = 1000000;
    for(int i = 0; i < notes[currentIndex].length; i++){
      int difference = (notes[noteOrder[currentIndex][i]]['value'] as int) - correctValue;
      if(difference > 0 && difference < lowestPositiveDifference){
        lowestPositiveDifference = difference;
        correctIndex = i;
      }
    }

    correctImage = notes[noteOrder[currentIndex][correctIndex]]['route'];

    if (selectedImage == correctImage) {
      setState(() {
        feedbackMessage = "¡Correcto! Has acertado el billete o moneda.";
        if (currentIndex < levelCount - 1) {
          currentIndex++;
        } else {
          _showWinDialog();
        }
        _controller.clear();
        selectedImage = '';
        wasUserCorrect = 1;
      });
    } else {
      setState(() {
        feedbackMessage = "Ese billete o moneda no es correcto, inténtalo de nuevo.";
        _controller.clear();
        selectedImage = '';
        wasUserCorrect = 0;
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinDialog(description: "Has logrado indicar todas los valores de las sumas de los productos");
      },
    ).then((_) {
      widget.onLevelCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Juego de Selección',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductImageGrid(),
            const SizedBox(height: 12),
            _buildNoteImageGrid(),
            const SizedBox(height: 12),
            Text(
              feedbackMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: wasUserCorrect == 1
                    ? Colors.green
                    : wasUserCorrect == 0
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImageGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        (productOrder[currentIndex].length*2-1),
            (index) {
          if ((index & 1) == 0){
            String name = products[productOrder[currentIndex][index~/2]]['name'];
            String image = products[productOrder[currentIndex][index~/2]]['route'];
            int value = products[productOrder[currentIndex][index~/2]]['value'] as int;
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 140,
              height: 200,
              child: Column(
                children: [
                  Center(
                    child: Text(
                        '$name\n\$${formatter.format(value)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        )
                    ),
                  ),
                  Image.asset(
                    image,
                    height: 110,
                    width: 110,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
                width: 20,
                height: 50,
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                )
            );
          }
        },
      ),
    );
  }

  Widget _buildNoteImageGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        noteOrder[currentIndex].length,
            (index) {
          String image = notes[noteOrder[currentIndex][index]]['route'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedImage = image;
              });
              _checkUserInput();
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
}
