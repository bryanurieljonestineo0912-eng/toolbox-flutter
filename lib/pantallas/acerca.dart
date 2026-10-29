// Bryan Uriel Jones Tineo - Matrícula 2025-1391
import 'package:flutter/material.dart';

class Acerca extends StatelessWidget {
  const Acerca({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/foto.png',
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.account_circle, size: 150);
              },
            ),
            const SizedBox(height: 15),
            const Text('Bryan Uriel Jones Tineo', style: TextStyle(fontSize: 24)),
            const Text('Matrícula: 2025-1391'),
            const Text('Estudiante de Desarrollo de Software - ITLA'),
            const SizedBox(height: 15),
            
            const Text('Correo: bryanurieljonestineo0912@gmail.com'),
            const Text('Teléfono: +1 (809) 479-4955'),
            const Text('GitHub: github.com/bryanurieljonestineo0912-eng'),
          ],
        ),
      ),
    );
  }
}
