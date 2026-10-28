import 'package:flutter/material.dart';

class HalamanKeluar extends StatelessWidget {
  const HalamanKeluar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keluar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Kembali ke Aplikasi'),
        ),
      ),
    );
  }
}