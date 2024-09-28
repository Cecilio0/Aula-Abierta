import 'package:aula_abierta/pages/ayudas/help.dart';
import 'package:aula_abierta/pages/cajero/levelSelection.dart';
import 'package:aula_abierta/pages/emparejar/pair.dart';
import 'package:aula_abierta/pages/quiz/levelSelection.dart';
import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _checkNoteExistence() async {
    NoteUtils.saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    _checkNoteExistence();
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
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
              ),

              CustomButton(
                  text: "Quiz billetes",
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
                            builder: (context) => PairingGame()
                        )
                    );
                  }
              ),
              CustomButton(
                text: "Ejemplos cajero",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LevelSelectionScreen()
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
              )
            ],
          ),
      ),
    );
  }
}
