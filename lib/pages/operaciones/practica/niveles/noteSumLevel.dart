import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';

class NoteSumlevel extends StatefulWidget {
  final int difficulty;
  final VoidCallback onLevelCompleted;

  const NoteSumlevel({
    super.key,
    required this.difficulty,
    required this.onLevelCompleted,
  });

  @override
  _NoteSumlevelState createState() => _NoteSumlevelState();
}

class _NoteSumlevelState extends State<NoteSumlevel> {
  late List<Map<String, dynamic>> notes;
  late List<List<int>> noteOrder;

  int levelCount = 4;
  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = 'Escribe el valor en pesos de la suma de las monedas y/o billetes';
  int wasUserCorrect = 2;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    notes = NoteUtils.loadNotes();

    switch (widget.difficulty) {
      case 0:
        noteOrder = RandomUtils.nRandomDistinctLists(levelCount, 2, 0, 4);
        break;
      case 1:
        noteOrder = RandomUtils.nRandomDistinctLists(levelCount, 3, 0, 4);
        break;
      case 2:
        noteOrder = RandomUtils.nRandomDistinctLists(levelCount, 2, 4, notes.length);
        break;
      case 3:
        noteOrder = RandomUtils.nRandomDistinctLists(levelCount, 3, 4, notes.length);
        break;
      case 4:
        noteOrder = joinLists(RandomUtils.nRandomDistinctLists(levelCount, 1, 0, 4), RandomUtils.nRandomDistinctLists(levelCount, 1, 4, notes.length));
        break;
      case 5:
        noteOrder = joinLists(RandomUtils.nRandomDistinctLists(levelCount, 2, 0, 4), RandomUtils.nRandomDistinctLists(levelCount, 1, 4, notes.length));
        break;
      case 6:
        noteOrder = joinLists(RandomUtils.nRandomDistinctLists(levelCount, 1, 0, 4), RandomUtils.nRandomDistinctLists(levelCount, 2, 4, notes.length));
        break;
      case 7:
        noteOrder = joinLists(RandomUtils.nRandomDistinctLists(levelCount, 2, 0, 4), RandomUtils.nRandomDistinctLists(levelCount, 2, 4, notes.length));
        break;
    }
    for (var element in noteOrder) {
      element.sort((noteA, noteB) => notes[noteA]['value'] - notes[noteB]['value']);
    }
  }

  List<List<int>> joinLists(List<List<int>> list1, List<List<int>> list2) {
    List<List<int>> result = [];
    for (int i = 0; i < list1.length; i++) {
      result.add([...list1[i], ...list2[i]]);
    }
    return result;
  }

  void _checkUserInput() {
    int correctValue = 0;
    for(int i = 0; i < noteOrder[currentIndex].length; i++){
      correctValue += notes[noteOrder[currentIndex][i]]['value'] as int;
    }

    if (userInput.contains('.') || userInput.contains(',')){
      setState(() {
        feedbackMessage = "Intenta no usar puntos ni comas.";
        _controller.clear();
        userInput = '';
        wasUserCorrect = 0;
      });
      return;
    }

    if (int.tryParse(userInput) == correctValue) {
      setState(() {
        feedbackMessage = "¡Correcto! Has acertado el valor.";
        if (currentIndex < levelCount - 1) {
          currentIndex++;
        } else {
          _showWinDialog();
        }
        _controller.clear();
        userInput = '';
        wasUserCorrect = 1;
      });
    } else {
      setState(() {
        feedbackMessage = "Ese valor no es correcto, inténtalo de nuevo.";
        _controller.clear();
        userInput = '';
        wasUserCorrect = 0;
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinDialog(description: "Has logrado indicar todos los valores de las sumas de las monedas y/o billetes");
      },
    ).then((_) {
      widget.onLevelCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Juego de Valor',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageGrid(),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Escribe el valor aquí',
              ),
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
                text: 'Comprobar',
                onPressed: _checkUserInput
            ),
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

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        (noteOrder[currentIndex].length*2-1),
            (index) {
          if ((index & 1) == 0){
            String image = notes[noteOrder[currentIndex][index~/2]]['route'];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              width: 110,
              height: 110,
              child: Image.asset(image),
            );
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              width: 50,
              height: 50,
              child: const Center(
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
}
