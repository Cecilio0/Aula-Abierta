import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberGuessingGame extends StatefulWidget {
  @override
  _NumberGuessingGameState createState() => _NumberGuessingGameState();
}

class _NumberGuessingGameState extends State<NumberGuessingGame> {
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/monedas/nueva_100.png', 'value': 100, 'name': 'Moneda 100 pesos'},
    {'image': 'assets/monedas/nueva_200.png', 'value': 200, 'name': 'Moneda 200 pesos'},
    {'image': 'assets/monedas/nueva_500.png', 'value': 500, 'name': 'Moneda 500 pesos'},
  ];

  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = '';
  final TextEditingController _controller = TextEditingController();
  final formatter = NumberFormat('#,###');

  void _checkUserInput() {
    int correctValue = items[currentIndex]['value'];
    if (int.tryParse(userInput) == correctValue) {
      setState(() {
        feedbackMessage = "¡Correcto! Has acertado el valor.";
        if (currentIndex < items.length - 1) {
          currentIndex++;
        } else {
          feedbackMessage = "¡Felicidades! Has terminado el juego.";
        }
        _controller.clear();
        userInput = '';
      });
    } else {
      setState(() {
        feedbackMessage = "Incorrecto, inténtalo de nuevo.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String image = items[currentIndex]['image'];
    String name = items[currentIndex]['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Valor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the image
            Image.asset(
              image,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 16),
            // Display the name of the item
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Text input field for user to enter value
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Escribe el valor en pesos',
              ),
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Button to submit answer
            ElevatedButton(
              onPressed: _checkUserInput,
              child: Text('Comprobar'),
            ),
            const SizedBox(height: 16),
            // Feedback message
            Text(
              feedbackMessage,
              style: TextStyle(
                fontSize: 18,
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
