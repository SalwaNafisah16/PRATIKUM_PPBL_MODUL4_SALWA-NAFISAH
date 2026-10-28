import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Nusantara Cerdas Mobile\n'
            'Aplikasi layanan warga Kota Nusantara.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}