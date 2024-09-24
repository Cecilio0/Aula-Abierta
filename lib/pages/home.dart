import 'package:aula_abierta/pages/cajero/levelSelection.dart';
import 'package:aula_abierta/pages/testPage.dart';
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
                  Image.asset(
                    "assets/logos/logo_aulaabierta.png",
                    width: 300,
                    height: 200,
                    color: Colors.black,
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
                  text: "Ejemplos comprador",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TestPage()
                        )
                    );
                  }
              ),
              CustomButton(
                  text: "Test Page",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TestPage()
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
