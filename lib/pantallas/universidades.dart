// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Universidades extends StatefulWidget {
  const Universidades({super.key});

  @override
  State<Universidades> createState() => _UniversidadesState();
}

class _UniversidadesState extends State<Universidades> {
  final paisController = TextEditingController(text: 'Dominican Republic');
  List universidades = [];
  bool cargando = false;

  Future<void> buscar() async {
    setState(() {
      cargando = true;
    });

    try {
      var url = Uri.https('adamix.net', '/proxy.php', {'country': paisController.text.trim()});
      var respuesta = await http.get(url);
      universidades = jsonDecode(respuesta.body);
    } catch (e) {
      universidades = [];
    }

    setState(() {
      cargando = false;
    });
  }

  Future<void> abrirLink(String link) async {
    await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: paisController,
              decoration: const InputDecoration(labelText: 'País (en inglés)', border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: buscar, child: const Text('Buscar')),
          Expanded(
            child: cargando
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: universidades.length,
                    itemBuilder: (context, i) {
                      var uni = universidades[i];
                      String web = uni['web_pages'][0];
                      return Card(
                        child: ListTile(
                          title: Text(uni['name']),
                          subtitle: Text('Dominio: ${uni['domains'][0]}\n$web'),
                          onTap: () => abrirLink(web),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
