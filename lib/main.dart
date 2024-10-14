import 'package:aula_abierta/pages/home.dart';
import 'package:aula_abierta/utils/noteUtils.dart';
import 'package:aula_abierta/utils/productUtils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aula_abierta/config/app_config.dart';

void main() async {
  // Ensure Widgets are initialized before using Hive
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with Flutter
  await Hive.initFlutter();

  // Due to ease of use, boxes are being opened here
  await Hive.openBox('actionsBox');
  await Hive.openBox<bool>('nivelesPracticaBox');
  await Hive.openBox<bool>('nivelesRealesBox');
  await Hive.openBox<Map<String, dynamic>>('noteBox');
  await NoteUtils.saveNotes();
  await Hive.openBox<Map<String, dynamic>>('productBox');
  await ProductUtils.saveProducts();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Set internal app configuration
  AppConfig().isDevMode = dotenv.env['DEV_MODE'] == 'true';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false, // Use to avoid showing debug banner
      title: 'Aula Abierta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomePage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (AppConfig().isDevMode)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'DEVELOPER MODE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
