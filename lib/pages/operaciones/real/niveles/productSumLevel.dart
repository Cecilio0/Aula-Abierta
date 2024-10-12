import 'package:aula_abierta/utils/productUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductSumLevel extends StatefulWidget {
  final int difficulty;
  final VoidCallback onLevelCompleted;

  const ProductSumLevel({
    super.key,
    required this.difficulty,
    required this.onLevelCompleted,
  });

  @override
  _ProductSumLevelState createState() => _ProductSumLevelState();
}

class _ProductSumLevelState extends State<ProductSumLevel> {
  late List<Map<String, dynamic>> products;
  late List<List<int>> productOrder;
  final formatter = NumberFormat('#,###');

  int levelCount = 5;
  int currentIndex = 0;
  String userInput = '';
  String feedbackMessage = 'Escribe el valor total en pesos de los productos';
  int wasUserCorrect = 2;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = ProductUtils.loadProducts();

    productOrder = RandomUtils.nRandomDistinctLists(levelCount, 2, 0, products.length);
  }

  void _checkUserInput() {
    int correctValue = 0;
    for(int i = 0; i < productOrder[currentIndex].length; i++){
      correctValue += products[productOrder[currentIndex][i]]['value'] as int;
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
