import 'package:aula_abierta/pages/operaciones/practica/niveles/noteSubtractionLevel.dart';
import 'package:aula_abierta/pages/operaciones/practica/niveles/noteSumLevel.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:aula_abierta/config/app_config.dart';

class PracticeLevelSelectionScreen extends StatefulWidget {
  const PracticeLevelSelectionScreen({super.key});

  @override
  _PracticeLevelSelectionScreenState createState() =>
      _PracticeLevelSelectionScreenState();
}

class _PracticeLevelSelectionScreenState
    extends State<PracticeLevelSelectionScreen> {
  late Box<bool> _levelBox;
  String _message = "Selecciona un nivel para continuar";

  @override
  void initState() {
    super.initState();
    _levelBox = Hive.box<bool>('nivelesPracticaBox'); // Get the opened box
  }

  // Mark a level as completed and store it in Hive
  Future<void> _markLevelAsCompleted(int level) async {
    _levelBox.put('level_$level', true); // Mark the level as completed
    setState(() {
      _message = "Bien hecho! Completaste el nivel ${level + 1}";
    }); // Update the UI
  }

  // Check if the previous level was completed
  bool _canPlayLevel(int level) {
    if (AppConfig().isDevMode) return true; // Always allow in dev mode
    if (level == 0) return true; // First level is always playable
    return _levelBox.get('level_${level - 1}', defaultValue: false) == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Selección de nivel'),
      body: Center(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _message,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                  child: CustomButton(
                    text: 'Nivel ${index + 1}',
                    onPressed: _canPlayLevel(index)
                        ? () => _playLevel(index)
                        : () => _lockedLevelPressed(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canPlayLevel(index)
                          ? Colors.deepPurple.shade600
                          : Colors.grey.shade600,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  void _lockedLevelPressed() {
    setState(() {
      _message =
          "Este nivel se encuentra bloqueado, intenta jugar niveles anteriores";
    });
  }

  // Handle playing a level and mark it as completed
  void _playLevel(int level) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => level < 5
                ? NoteSumlevel(
                    difficulty: level,
                    onLevelCompleted: () {
                      _markLevelAsCompleted(level);
                    },
                  )
                : NoteSubtractionLevel(
                    difficulty: level - 5,
                    onLevelCompleted: () {
                      _markLevelAsCompleted(level);
                    },
                  )));
  }
}
