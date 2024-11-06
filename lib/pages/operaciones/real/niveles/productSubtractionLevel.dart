import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/productUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductSubtractionLevel extends StatefulWidget {
  final int difficulty;
  final VoidCallback onLevelCompleted;

  const ProductSubtractionLevel({
    super.key,
    required this.difficulty,
    required this.onLevelCompleted,
  });

  @override
  _NoteSubtractionLevelState createState() => _NoteSubtractionLevelState();
}

class _NoteSubtractionLevelState extends State<ProductSubtractionLevel> {
  late List<Map<String, dynamic>> products;
  late List<Map<String, dynamic>> notes;
  late List<List<int>> boughtProductsOrder;
  late List<List<int>> payingNoteOrder;

  final commaFormatter = NumberFormat('#,###', 'en_US');
  final dotFormatter = NumberFormat('#,###', 'de_DE');

  int levelCount = 4;
  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = 'Escribe el valor en pesos que debes devolverle a la persona';
  int wasUserCorrect = 2;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = ProductUtils.loadProducts();
    notes = NoteUtils.loadNotes();
    switch (widget.difficulty) {
      case 0:
        setDifficulty(1, 1, 0, notes.length);
        break;
      case 1:
        setDifficulty(2, 1, 0, notes.length);
        break;
      case 2:
        setDifficulty(2, 2, 0, notes.length);
        break;
    }
    for (var element in payingNoteOrder) {
      element.sort((noteA, noteB) => notes[noteA]['value'] - notes[noteB]['value']);
    }
  }

  // idek what's going on anymore
  void setDifficulty (int boughtProductSize, int payingNoteSize, int payingNoteStart, int payingNoteEnd){
    boughtProductsOrder = RandomUtils.nRandomDistinctLists(levelCount, boughtProductSize, 0, products.length);
    payingNoteOrder = [];
    for(int i = 0; i < levelCount; i++){
      List<int> tempList = RandomUtils.randomListInRange(payingNoteSize, payingNoteStart, payingNoteEnd);
      int payingSum = tempList.length > 1
          ? tempList.reduce((noteA, noteB) => (notes[noteA]['value'] as int) + (notes[noteB]['value'] as int))
          : notes[tempList[0]]['value'] as int;

      int productSum = boughtProductsOrder[i].length > 1
          ? boughtProductsOrder[i].reduce((productA, productB) => (products[productA]['value'] as int) + (products[productB]['value'] as int))
          : products[boughtProductsOrder[i][0]]['value'] as int;

      while(productSum > payingSum){
        tempList = RandomUtils.randomListInRange(payingNoteSize, payingNoteStart, payingNoteEnd);
        payingSum = tempList.length > 1
            ? tempList.reduce((noteA, noteB) => (notes[noteA]['value'] as int) + (notes[noteB]['value'] as int))
            : notes[tempList[0]]['value'] as int;
      }
      payingNoteOrder.add(tempList);
    }
  }

  void _checkUserInput() {
    int correctValue = 0;
    for(int i = 0; i < payingNoteOrder[currentIndex].length; i++){
      correctValue += notes[payingNoteOrder[currentIndex][i]]['value'] as int;
    }

    for(int i = 0; i < boughtProductsOrder[currentIndex].length; i++){
      correctValue -= products[boughtProductsOrder[currentIndex][i]]['value'] as int;
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
        return WinDialog(description: "Has logrado indicar los valoers a devolver para cada situacion");
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
                'En una tienda alguien te quiere comprar los siguientes productos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              _buildBoughtProductsImageGrid(),
              const Text(
                'y te pagaron con los siguientes billetes o monedas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              _buildPayingNoteImageGrid(),
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

  Widget _buildBoughtProductsImageGrid() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        (boughtProductsOrder[currentIndex].length*2-1),
            (index) {
          if ((index & 1) == 0){
            String name = products[boughtProductsOrder[currentIndex][index~/2]]['name'];
            String image = products[boughtProductsOrder[currentIndex][index~/2]]['route'];
            int value = products[boughtProductsOrder[currentIndex][index~/2]]['value'] as int;
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 140,
              height: 200,
              child: Column(
                children: [
                  Center(
                    child: Text(
                        '$name\n\$${commaFormatter.format(value)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        )
                    ),
                  ),
                  Image.asset(
                    image,
                    height: 100,
                    width: 100,
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
}
