import 'package:aula_abierta/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  List<Map<String, dynamic>> _loadDataFromHive() {
    Box<Map<String, dynamic>> noteBox = Hive.box('noteBox');

    Iterable keys = noteBox.keys;

    List<Map<String, dynamic>> notes = [];
    for (String key in keys) {
      var note = noteBox.get(key);
      if (note is Map<String, dynamic>) {
        notes.add(note);
      }
    }

    notes.sort((a, b) => a['value'] - b['value']);
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notes = _loadDataFromHive();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Ayudas'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Monedas',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            // First Grid for Monedas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 400, // Limit height for the grid
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  physics: const NeverScrollableScrollPhysics(), // Disable grid's scrolling
                  children: List.generate(4, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          notes.elementAt(index)['route'],
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          notes.elementAt(index)['name'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Billetes',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            // Second Grid for Billetes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 600, // Limit height for the grid
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  physics: const NeverScrollableScrollPhysics(), // Disable grid's scrolling
                  children: List.generate(notes.length - 4, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          notes.elementAt(index + 4)['route'],
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          notes.elementAt(index + 4)['name'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
