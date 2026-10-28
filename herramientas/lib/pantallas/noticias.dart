// Bryan Uriel Jones Tineo - Matrícula 2025-1391
// API usada: https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Noticias extends StatefulWidget {
  const Noticias({super.key});

  @override
  State<Noticias> createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  List noticias = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarNoticias();
  }

  Future<void> cargarNoticias() async {
    var url = Uri.parse('https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3');
    var respuesta = await http.get(url);
    setState(() {
      noticias = jsonDecode(respuesta.body);
      cargando = false;
    });
  }

  // quita las etiquetas html del texto
  String limpiar(String texto) {
    texto = texto.replaceAll(RegExp(r'<[^>]*>'), '');
    texto = texto.replaceAll('&hellip;', '...');
    texto = texto.replaceAll('&#8217;', "'");
    texto = texto.replaceAll('&amp;', '&');
    return texto.trim();
  }

  Future<void> visitar(String link) async {
    await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias WordPress')),
      body: Column(
        children: [
          Image.network(
            'https://s.w.org/style/images/about/WordPress-logotype-standard.png',
            height: 70,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.public, size: 70);
            },
          ),
          Expanded(
            child: cargando
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: noticias.length,
                    itemBuilder: (context, i) {
                      var noticia = noticias[i];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                limpiar(noticia['title']['rendered']),
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(limpiar(noticia['excerpt']['rendered'])),
                              TextButton(
                                onPressed: () => visitar(noticia['link']),
                                child: const Text('Visitar'),
                              ),
                            ],
                          ),
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
