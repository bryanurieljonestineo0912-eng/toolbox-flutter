// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'package:flutter/material.dart';
import 'pantallas/inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja de herramientas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const Inicio(),
    );
  }
}
