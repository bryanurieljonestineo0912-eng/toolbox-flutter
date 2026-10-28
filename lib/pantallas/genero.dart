// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Genero extends StatefulWidget {
  const Genero({super.key});

  @override
  State<Genero> createState() => _GeneroState();
}

class _GeneroState extends State<Genero> {
  final nombreController = TextEditingController();
  Color color = Colors.white;
  String mensaje = '';

  Future<void> predecir() async {
    String nombre = nombreController.text.trim();
    if (nombre.isEmpty) return;

    try {
      var url = Uri.https('api.genderize.io', '/', {'name': nombre});
      var respuesta = await http.get(url);
      var datos = jsonDecode(respuesta.body);

      setState(() {
        if (datos['gender'] == 'male') {
          color = Colors.blue;
          mensaje = 'Masculino';
        } else {
          color = Colors.pink;
          mensaje = datos['gender'] == 'female' ? 'Femenino' : 'No se pudo predecir';
        }
      });
    } catch (e) {
      setState(() {
        mensaje = 'Error al conectar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predecir género')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: predecir, child: const Text('Predecir')),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              color: color,
              child: Center(
                child: Text(mensaje, style: const TextStyle(fontSize: 30, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
