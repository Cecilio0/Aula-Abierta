import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/widgets/appBar.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  List<Map<String, dynamic>> _loadDataFromHive() {
    return NoteUtils.loadNotes();
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
                height: 600, // Limit height for the grid
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  physics: const NeverScrollableScrollPhysics(), // Disable grid's scrolling
                  children: List.generate(5, (index) {
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
                  children: List.generate(notes.length - 5, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          notes.elementAt(index + 5)['route'],
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          notes.elementAt(index + 5)['name'],
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
