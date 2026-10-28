// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'package:flutter/material.dart';
import 'genero.dart';
import 'persona.dart';
import 'universidades.dart';
import 'clima.dart';
import 'pokemon.dart';
import 'noticias.dart';
import 'acerca.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  // boton que abre otra pantalla
  Widget boton(BuildContext context, String texto, Widget pantalla) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => pantalla));
        },
        child: Text(texto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caja de herramientas')),
      body: ListView(
        children: [
          // foto de la caja de herramientas
          Image.asset(
            'assets/images/toolbox.png',
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.handyman, size: 150);
            },
          ),
          const SizedBox(height: 10),
          boton(context, 'Predecir género', const Genero()),
          boton(context, 'Persona aleatoria', const Persona()),
          boton(context, 'Universidades', const Universidades()),
          boton(context, 'Clima en RD', const Clima()),
          boton(context, 'Pokémon', const Pokemon()),
          boton(context, 'Noticias WordPress', const Noticias()),
          boton(context, 'Acerca de', const Acerca()),
        ],
      ),
    );
  }
}
