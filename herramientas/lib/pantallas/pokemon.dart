// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon extends StatefulWidget {
  const Pokemon({super.key});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  final nombreController = TextEditingController(text: 'pikachu');
  final player = AudioPlayer();
  String nombre = '';
  String imagen = '';
  String habilidades = '';
  String sonido = '';
  int experiencia = 0;
  String error = '';

  Future<void> buscar() async {
    String texto = nombreController.text.trim().toLowerCase();
    var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$texto');
    var respuesta = await http.get(url);

    if (respuesta.statusCode != 200) {
      setState(() {
        error = 'No se encontró el pokemon';
        nombre = '';
      });
      return;
    }

    var datos = jsonDecode(respuesta.body);
    String lista = '';
    for (var h in datos['abilities']) {
      lista += '${h['ability']['name']}, ';
    }

    setState(() {
      error = '';
      nombre = datos['name'];
      imagen = datos['sprites']['other']['official-artwork']['front_default'];
      experiencia = datos['base_experience'];
      habilidades = lista;
      sonido = datos['cries']['latest'];
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del pokemon', border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(onPressed: buscar, child: const Text('Buscar')),
            Text(error, style: const TextStyle(color: Colors.red)),
            if (nombre != '') ...[
              Image.network(imagen, height: 200),
              Text(nombre, style: const TextStyle(fontSize: 26)),
              Text('Experiencia base: $experiencia'),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Habilidades: $habilidades'),
              ),
              ElevatedButton.icon(
                onPressed: () => player.play(UrlSource(sonido)),
                icon: const Icon(Icons.volume_up),
                label: const Text('Escuchar sonido'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
