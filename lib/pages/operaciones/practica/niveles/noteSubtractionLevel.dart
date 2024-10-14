import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteSubtractionLevel extends StatefulWidget {
  final int difficulty;
  final VoidCallback onLevelCompleted;

  const NoteSubtractionLevel({
    super.key,
    required this.difficulty,
    required this.onLevelCompleted,
  });

  @override
  _NoteSubtractionLevelState createState() => _NoteSubtractionLevelState();
}

class _NoteSubtractionLevelState extends State<NoteSubtractionLevel> {
  late List<Map<String, dynamic>> notes;
  late List<List<int>> payingNoteOrder;
  late List<List<int>> changeNoteOrder;

  final commaFormatter = NumberFormat('#,###', 'en_US');
  final dotFormatter = NumberFormat('#,###', 'de_DE');

  int levelCount = 4;
  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = 'Escribe el valor en pesos que pagaste después de la devolución';
  int wasUserCorrect = 2;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    notes = NoteUtils.loadNotes();
    switch (widget.difficulty) {
      case 0:
        setDifficulty(1, 0, 5, 1, 0, 5);
        break;
      case 1:
        setDifficulty(2, 0, 5, 1, 0, 5);
        break;
      case 2:
        setDifficulty(1, 5, notes.length, 1, 0, notes.length);
        break;
      case 3:
        setDifficulty(2, 5, notes.length, 1, 0, notes.length);
        break;
      case 4:
        setDifficulty(2, 5, notes.length, 2, 0, notes.length);
        break;
    }
    for (var element in payingNoteOrder) {
      element.sort((noteA, noteB) => notes[noteA]['value'] - notes[noteB]['value']);
    }
    for (var element in changeNoteOrder) {
      element.sort((noteA, noteB) => notes[noteA]['value'] - notes[noteB]['value']);
    }
  }

  // idek what's going on anymore
  void setDifficulty (int payingNoteSize, int payingNoteStart, int payingNoteEnd, int changeNoteSize, int changeNoteStart, int changeNoteEnd){
    payingNoteOrder = RandomUtils.nRandomDistinctLists(levelCount, payingNoteSize, payingNoteStart, payingNoteEnd);
    changeNoteOrder = [];
    for(int i = 0; i < payingNoteOrder.length; i++){
      List<int> tempList = RandomUtils.randomListInRange(changeNoteSize, changeNoteStart, changeNoteEnd);
      int payingSum = payingNoteOrder[i].length > 1
          ? payingNoteOrder[i].reduce((noteA, noteB) => (notes[noteA]['value'] as int) + (notes[noteB]['value'] as int))
          : notes[payingNoteOrder[i][0]]['value'] as int;

      int changeSum = tempList.length > 1
          ? tempList.reduce((noteA, noteB) => (notes[noteA]['value'] as int) + (notes[noteB]['value'] as int))
          : notes[tempList[0]]['value'] as int;

      while(changeSum > payingSum){
        tempList = RandomUtils.randomListInRange(changeNoteSize, changeNoteStart, changeNoteEnd);
        changeSum = tempList.length > 1
            ? tempList.reduce((noteA, noteB) => (notes[noteA]['value'] as int) + (notes[noteB]['value'] as int))
            : notes[tempList[0]]['value'] as int;
      }
      changeNoteOrder.add(tempList);
    }
  }

  void _checkUserInput() {
    int correctValue = 0;
    for(int i = 0; i < payingNoteOrder[currentIndex].length; i++){
      correctValue += notes[payingNoteOrder[currentIndex][i]]['value'] as int;
    }

    for(int i = 0; i < changeNoteOrder[currentIndex].length; i++){
      correctValue -= notes[changeNoteOrder[currentIndex][i]]['value'] as int;
    }

    List<String> correctValues = [
      correctValue.toString(),
      dotFormatter.format(correctValue),
      commaFormatter.format(correctValue)
    ];

    if (correctValues.contains(userInput)) {
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
        return WinDialog(description: "Has logrado indicar los valores reales que habrías pagado para cada situación");
      },
    ).then((_) {
      widget.onLevelCompleted();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Juego de Valor',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Wrap your Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'En una tienda pagaste con los siguientes monedas y/o billetes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              _buildPayingNoteImageGrid(),
              const Text(
                'y te devolvieron las siguientes monedas y/o billetes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              _buildChangeNoteImageGrid(),
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
                onPressed: _checkUserInput,
              ),
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
      ),
    );
  }


  Widget _buildPayingNoteImageGrid() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        (payingNoteOrder[currentIndex].length*2-1),
            (index) {
          if ((index & 1) == 0){
            String image = notes[payingNoteOrder[currentIndex][index~/2]]['route'];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              width: 105,
              height: 105,
              child: Image.asset(image),
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

  Widget _buildChangeNoteImageGrid() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        (changeNoteOrder[currentIndex].length*2-1),
            (index) {
          if ((index & 1) == 0){
            String image = notes[changeNoteOrder[currentIndex][index~/2]]['route'];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              width: 105,
              height: 105,
              child: Image.asset(image),
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
}
