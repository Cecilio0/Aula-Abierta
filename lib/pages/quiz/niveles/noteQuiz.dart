import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/randomUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:aula_abierta/widgets/winDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteGuessingGame extends StatefulWidget {
  const NoteGuessingGame({super.key});

  @override
  _NoteGuessingGameState createState() => _NoteGuessingGameState();
}

class _NoteGuessingGameState extends State<NoteGuessingGame> {
  late List<Map<String, dynamic>> notes;
  late List<int> noteOrder;
  late List<int> imageOrder;

  int currentIndex = 0;
  String feedbackMessage = '';
  final formatter = NumberFormat('#,###');
  String? selectedImage;

  @override
  void initState() {
    super.initState();
    notes = NoteUtils.loadNotes();
    noteOrder = RandomUtils.randomList(notes.length);

    _randomListIncludingIndex(noteOrder[currentIndex]);
  }

  void _randomListIncludingIndex(int index){
    imageOrder = RandomUtils.randomListInRange(4, 0, notes.length);

    if (!imageOrder.contains(index)) {
      int rand = RandomUtils.randomInRange(0, 4);
      imageOrder[rand] = index;
    }
  }

  void _checkUserInput() {
    String correctImage = notes[noteOrder[currentIndex]]['route'];
    if (selectedImage == correctImage) {
      setState(() {
        feedbackMessage = "¡Correcto! Has acertado la imagen.";
        if (currentIndex < notes.length - 1) {
          currentIndex++;
          _randomListIncludingIndex(noteOrder[currentIndex]);
        } else {
          _showWinDialog();
        }
      });
    } else {
      setState(() {
        feedbackMessage = "Esa imagen no es correcta, inténtalo de nuevo.";
      });
    }
    selectedImage = null;
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WinDialog(description: "Has logrado emparejar todos los valores con sus respectivos billetes o monedas.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int value = notes[noteOrder[currentIndex]]['value'];

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
            const Text(
              'Selecciona la imagen que corresponda al valor:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Text(
              formatter.format(value),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            const SizedBox(height: 16),
            _buildImageGrid(),
            const SizedBox(height: 16),
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

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: List.generate(
          imageOrder.length,
            (index) {
          String image = notes[imageOrder[index]]['route'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedImage = image;
              });
              _checkUserInput();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedImage == image ? Colors.grey.shade400 : Colors.transparent,
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Image.asset(image),
            ),
          );
        },
      ),
    );
  }
}

