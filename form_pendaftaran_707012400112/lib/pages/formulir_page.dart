import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';
import 'detail_kegiatan_page.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});

  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();

  String _sesi = 'Pagi';
  bool _setuju = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  void _daftar() {
    if (!_formKey.currentState!.validate()) return;

    if (!_setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan setujui persyaratan terlebih dahulu.'),
        ),
      );
      return;
    }

    context.read<PendaftarModel>().tambahPendaftar(
      nama: _namaController.text.trim(),
      nim: _nimController.text.trim(),
      sesi: _sesi,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil disimpan!')),
    );

    _formKey.currentState!.reset();
    _namaController.clear();
    _nimController.clear();

    setState(() {
      _sesi = 'Pagi';
      _setuju = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pendaftaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailKegiatanPage(),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.event, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Kegiatan Kampus',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Ketuk untuk melihat detail kegiatan.'),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              const Text(
                'Pilih Sesi Kegiatan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              RadioListTile<String>(
                title: const Text('Pagi'),
                value: 'Pagi',
                groupValue: _sesi,
                onChanged: (value) {
                  setState(() {
                    _sesi = value!;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Siang'),
                value: 'Siang',
                groupValue: _sesi,
                onChanged: (value) {
                  setState(() {
                    _sesi = value!;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Sore'),
                value: 'Sore',
                groupValue: _sesi,
                onChanged: (value) {
                  setState(() {
                    _sesi = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: const Text('Saya menyetujui persyaratan kegiatan'),
                value: _setuju,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _setuju = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: _daftar,
                icon: const Icon(Icons.send),
                label: const Text('Daftar Sekarang'),
              ),

              const SizedBox(height: 12),

              const Text(
                'Isi formulir dengan data yang benar '
                'sebelum mendaftar.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Informasi kegiatan',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DetailKegiatanPage()),
          );
        },
        child: const Icon(Icons.info_outline),
      ),
    );
  }
}
