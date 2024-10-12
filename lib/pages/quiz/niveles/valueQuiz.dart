import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ValueGuessingGame extends StatefulWidget {
  const ValueGuessingGame({super.key});

  @override
  _ValueGuessingGameState createState() => _ValueGuessingGameState();
}

class _ValueGuessingGameState extends State<ValueGuessingGame> {
  late List<Map<String, dynamic>> notes;
  late List<int> noteOrder;

  final commaFormatter = NumberFormat('#,###', 'en_US');
  final dotFormatter = NumberFormat('#,###', 'de_DE');

  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    notes = NoteUtils.loadNotes();
    noteOrder = RandomUtils.randomList(notes.length);
  }

  void _checkUserInput() {
    int correctValue = notes[noteOrder[currentIndex]]['value'];

    List<String> correctValues = [
      correctValue.toString(),
      dotFormatter.format(correctValue),
      commaFormatter.format(correctValue)
    ];

    if (correctValues.contains(userInput)) {
      setState(() {
        feedbackMessage = "¡Correcto! Has acertado el valor.";
        if (currentIndex < notes.length - 1) {
          currentIndex++;
        } else {
          _showWinDialog();
        }
        _controller.clear();
        userInput = '';
      });
    } else {
      setState(() {
        feedbackMessage = "Ese valor no es correcto, inténtalo de nuevo.";
        _controller.clear();
        userInput = '';
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinDialog(description: "Has logrado indicar todos los valores de los billetes y monedas.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String image = notes[noteOrder[currentIndex]]['route'];

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
            // Display the image
            Image.asset(
              image,
              width: 220,
              height: 220,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            // Text input field for user to enter value
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Escribe el valor en pesos de la moneda o billete',
              ),
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Button to submit answer
            CustomButton(
                text: 'Comprobar',
                onPressed: _checkUserInput
            ),
            const SizedBox(height: 16),
            // Feedback message
            Text(
              feedbackMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: feedbackMessage.startsWith('¡Correcto!')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
