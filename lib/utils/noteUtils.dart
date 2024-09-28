import 'package:hive/hive.dart';

class NoteUtils {
  static List<Map<String, dynamic>> loadNotes() {

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

  static Future<void> saveNotes() async {
    Box<Map<String, dynamic>> noteBox = Hive.box('noteBox');

    await noteBox.clear();

    // moneda100
    Map<String, dynamic> moneda100 = {
      'name': 'Moneda 100 pesos',
      'value': 100,
      'route': 'assets/monedas/nueva_100.png'
    };

    noteBox.put('moneda100', moneda100);

    // moneda200
    Map<String, dynamic> moneda200 = {
      'name': 'Moneda 200 pesos',
      'value': 200,
      'route': 'assets/monedas/nueva_200.png'
    };

    noteBox.put('moneda200', moneda200);


    // moneda500
    Map<String, dynamic> moneda500 = {
      'name': 'Moneda 500 pesos',
      'value': 500,
      'route': 'assets/monedas/nueva_500.png'
    };

    noteBox.put('moneda500', moneda500);


    // moneda1000
    Map<String, dynamic> moneda1000 = {
      'name': 'Moneda 1,000 pesos',
      'value': 1000,
      'route': 'assets/monedas/nueva_1000.png'
    };

    noteBox.put('moneda1000', moneda1000);


    // billete2000
    Map<String, dynamic> billete2000 = {
      'name': 'Billete 2,000 pesos',
      'value': 2000,
      'route': 'assets/billetes/anverso2000.jpg'
    };

    noteBox.put('billete2000', billete2000);


    // billete5000
    Map<String, dynamic> billete5000 = {
      'name': 'Billete 5,000 pesos',
      'value': 5000,
      'route': 'assets/billetes/anverso5000.png'
    };

    noteBox.put('billete5000', billete5000);


    // billete10000
    Map<String, dynamic> billete10000 = {
      'name': 'Billete 10,000 pesos',
      'value': 10000,
      'route': 'assets/billetes/anverso10000.jpg'
    };

    noteBox.put('billete10000', billete10000);

    // billete20000
    Map<String, dynamic> billete20000 = {
      'name': 'Billete 20,000 pesos',
      'value': 20000,
      'route': 'assets/billetes/anverso20000.png'
    };

    noteBox.put('billete20000', billete20000);

    // billete50000
    Map<String, dynamic> billete50000 = {
      'name': 'Billete 50,000 pesos',
      'value': 50000,
      'route': 'assets/billetes/anverso50000.png'
    };

    noteBox.put('billete50000', billete50000);

    // billete100000
    Map<String, dynamic> billete100000 = {
      'name': 'Billete 100,000 pesos',
      'value': 100000,
      'route': 'assets/billetes/anverso100000.jpg'
    };

    noteBox.put('billete100000', billete100000);
  }
}