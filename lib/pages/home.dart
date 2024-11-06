import 'package:aula_abierta/pages/ayudas/help.dart';
import 'package:aula_abierta/pages/emparejar/pair.dart';
import 'package:aula_abierta/pages/operaciones/levelSelection.dart';
import 'package:aula_abierta/pages/quiz/levelSelection.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Aula Abierta',
        isBackButtonActive: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Image.asset(
                      "assets/logos/aula-abierta-logo.jpg",
                      width: 300,
                      height: 300,
                    ),
                  ),
                  const Text(
                    "Bienvenido a la app de conciencia financiera de Aula Abierta 🤗",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
              ),

              CustomButton(
                  text: "Quiz",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizLevelSelectionScreen()
                        )
                    );
                  }
              ),
              CustomButton(
                  text: "Emparejar",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PairingGame()
                        )
                    );
                  }
              ),
              CustomButton(
                text: "Operaciones",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OperationLevelSelectionScreen()
                      )
                  );
                }
              ),
              CustomButton(
                text: "Ayudas",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpScreen()
                      )
                  );
                }
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: const Text(
                    "Desarrollado por Daniel Restrepo, Pablo Mesa y Simón González, estudiantes de Ingeniería de Sistemas y Computación de la Universidad EIA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                )
              ),
          ],
        ),
      ),
    );
  }
}
