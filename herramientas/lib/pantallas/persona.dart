// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Persona extends StatefulWidget {
  const Persona({super.key});

  @override
  State<Persona> createState() => _PersonaState();
}

class _PersonaState extends State<Persona> {
  bool cargando = true;
  String nombre = '';
  String apellido = '';
  String foto = '';
  String fecha = '';
  int edad = 0;

  @override
  void initState() {
    super.initState();
    cargarPersona();
  }

  Future<void> cargarPersona() async {
    setState(() {
      cargando = true;
    });

    var url = Uri.parse('https://randomuser.me/api/?results=1');
    var respuesta = await http.get(url);
    var datos = jsonDecode(respuesta.body);
    var persona = datos['results'][0];

    setState(() {
      nombre = persona['name']['first'];
      apellido = persona['name']['last'];
      foto = persona['picture']['large'];
      fecha = persona['dob']['date'].substring(0, 10);
      edad = persona['dob']['age'];
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persona aleatoria')),
      body: Center(
        child: cargando
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(foto, height: 150),
                  const SizedBox(height: 15),
                  Text('Nombre: $nombre', style: const TextStyle(fontSize: 20)),
                  Text('Apellido: $apellido', style: const TextStyle(fontSize: 20)),
                  Text('Fecha de nacimiento: $fecha', style: const TextStyle(fontSize: 20)),
                  Text('Edad: $edad', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 15),
                  ElevatedButton(onPressed: cargarPersona, child: const Text('Otra persona')),
                ],
              ),
      ),
    );
  }
}
