// lib/pages/home.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/logo_aulaabierta.png',
          height: 40, // Ajusta la altura según tus necesidades
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text('Contenido de la página'),
      ),
    );
  }
}
