import 'package:flutter/material.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: const Center(
        child: Text(
          'Pengaturan Kota',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}