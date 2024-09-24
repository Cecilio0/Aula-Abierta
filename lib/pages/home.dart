import 'package:aula_abierta/pages/ayudas/help.dart';
import 'package:aula_abierta/pages/cajero/levelSelection.dart';
import 'package:aula_abierta/pages/testPage.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _checkNoteExistence() async {
    Box<Map<String, dynamic>> noteBox = Hive.box('noteBox');

    await noteBox.clear();

    // moneda100
    if (noteBox.get('moneda100', defaultValue: null) == null) {
      Map<String, dynamic> moneda100 = {
        'name': 'Moneda 100 pesos',
        'value': 100,
        'route': 'assets/monedas/nueva_100.png'
      };

      noteBox.put('moneda100', moneda100);
    }

    // moneda200
    if (noteBox.get('moneda200', defaultValue: null) == null) {
      Map<String, dynamic> moneda200 = {
        'name': 'Moneda 200 pesos',
        'value': 200,
        'route': 'assets/monedas/nueva_200.png'
      };

      noteBox.put('moneda200', moneda200);
    }

    // moneda500
    if (noteBox.get('moneda500', defaultValue: null) == null) {
      Map<String, dynamic> moneda500 = {
        'name': 'Moneda 500 pesos',
        'value': 500,
        'route': 'assets/monedas/nueva_500.png'
      };

      noteBox.put('moneda500', moneda500);
    }

    // moneda1000
    if (noteBox.get('moneda1000', defaultValue: null) == null) {
      Map<String, dynamic> moneda1000 = {
        'name': 'Moneda 1,000 pesos',
        'value': 1000,
        'route': 'assets/monedas/nueva_1000.png'
      };

      noteBox.put('moneda1000', moneda1000);
    }

    // billete2000
    if (noteBox.get('billete2000', defaultValue: null) == null) {
      Map<String, dynamic> billete2000 = {
        'name': 'Billete 2,000 pesos',
        'value': 2000,
        'route': 'assets/billetes/anverso2000.jpg'
      };

      noteBox.put('billete2000', billete2000);
    }

    // billete5000
    if (noteBox.get('billete5000', defaultValue: null) == null) {
      Map<String, dynamic> billete5000 = {
        'name': 'Billete 5,000 pesos',
        'value': 5000,
        'route': 'assets/billetes/anverso5000.png'
      };

      noteBox.put('billete5000', billete5000);
    }

    // billete10000
    if (noteBox.get('billete10000', defaultValue: null) == null) {
      Map<String, dynamic> billete10000 = {
        'name': 'Billete 10,000 pesos',
        'value': 10000,
        'route': 'assets/billetes/anverso10000.jpg'
      };

      noteBox.put('billete10000', billete10000);
    }

    // billete20000
    if (noteBox.get('billete20000', defaultValue: null) == null) {
      Map<String, dynamic> billete20000 = {
        'name': 'Billete 20,000 pesos',
        'value': 20000,
        'route': 'assets/billetes/anverso20000.png'
      };

      noteBox.put('billete20000', billete20000);
    }

    // billete50000
    if (noteBox.get('billete50000', defaultValue: null) == null) {
      Map<String, dynamic> billete50000 = {
        'name': 'Billete 50,000 pesos',
        'value': 50000,
        'route': 'assets/billetes/anverso50000.png'
      };

      noteBox.put('billete50000', billete50000);
    }

    // billete100000
    if (noteBox.get('billete100000', defaultValue: null) == null) {
      Map<String, dynamic> billete100000 = {
        'name': 'Billete 100,000 pesos',
        'value': 100000,
        'route': 'assets/billetes/anverso100000.jpg'
      };

      noteBox.put('billete100000', billete100000);
    }
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
