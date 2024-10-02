import 'package:aula_abierta/pages/operaciones/practica/levelSelection.dart';
import 'package:aula_abierta/pages/quiz/niveles/noteQuiz.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class OperationLevelSelectionScreen extends StatelessWidget {
  const OperationLevelSelectionScreen({super.key});

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
                text: "Practicar",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LevelSelectionScreen()
                      )
                  );
                }
            ),
            CustomButton(
                text: "Ejemplos vida real",
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
