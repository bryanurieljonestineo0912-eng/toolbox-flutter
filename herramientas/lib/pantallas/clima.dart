// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  bool cargando = true;
  String fecha = '';
  String estado = '';
  num temperatura = 0;
  num maxima = 0;
  num minima = 0;
  num lluvia = 0;

  @override
  void initState() {
    super.initState();
    cargarClima();
  }

  // el codigo del clima lo convierto a texto
  String obtenerEstado(int codigo) {
    if (codigo == 0) return 'Despejado';
    if (codigo <= 3) return 'Parcialmente nublado';
    if (codigo < 60) return 'Neblina o llovizna';
    if (codigo < 70) return 'Lluvia';
    if (codigo < 90) return 'Chubascos';
    return 'Tormenta';
  }

  Future<void> cargarClima() async {
    // Santo Domingo
    var url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=18.4861&longitude=-69.9312'
        '&current=temperature_2m,weather_code'
        '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max'
        '&timezone=America/Santo_Domingo&forecast_days=1');
    var respuesta = await http.get(url);
    var datos = jsonDecode(respuesta.body);

    setState(() {
      fecha = datos['daily']['time'][0];
      temperatura = datos['current']['temperature_2m'];
      estado = obtenerEstado(datos['current']['weather_code']);
      maxima = datos['daily']['temperature_2m_max'][0];
      minima = datos['daily']['temperature_2m_min'][0];
      lluvia = datos['daily']['precipitation_probability_max'][0];
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima en RD')),
      body: Center(
        child: cargando
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Santo Domingo', style: TextStyle(fontSize: 24)),
                  Text(fecha),
                  const Icon(Icons.wb_sunny, size: 80),
                  Text('$temperatura °C', style: const TextStyle(fontSize: 40)),
                  Text(estado, style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 10),
                  Text('Máxima: $maxima °C   Mínima: $minima °C'),
                  Text('Probabilidad de lluvia: $lluvia%'),
                ],
              ),
      ),
    );
  }
}
