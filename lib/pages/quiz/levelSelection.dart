import 'package:aula_abierta/pages/cajero/niveles/level1.dart';
import 'package:aula_abierta/pages/quiz/niveles/noteQuiz.dart';
import 'package:aula_abierta/pages/quiz/niveles/valueQuiz.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../widgets/button.dart';

class QuizLevelSelectionScreen extends StatelessWidget {
  const QuizLevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Selección de modo',
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Selecciona un modo para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomButton(
                text: "Valores",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ValueGuessingGame()
                      )
                  );
                }
            ),
            CustomButton(
                text: "Imágenes",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoteGuessingGame()
                      )
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
