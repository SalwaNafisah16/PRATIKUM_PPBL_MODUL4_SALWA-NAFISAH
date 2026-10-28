import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';

class HalamanDetailLayanan extends StatefulWidget {
  const HalamanDetailLayanan({super.key});

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  bool _setujuSyarat = false;
  bool _sedangMengirim = false;
  String? _sesiTerpilih = 'Pagi';

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirimPengajuan(Map<String, String> layanan) async {
    if (!_formKey.currentState!.validate()) return;

    if (!_setujuSyarat || _sesiTerpilih == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setujui persyaratan dan pilih sesi kunjungan.'),
        ),
      );
      return;
    }

    setState(() => _sedangMengirim = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final pengajuan = DataPengajuan(
      nama: _namaController.text.trim(),
      email: _emailController.text.trim(),
      bidangLayanan:
          layanan['dinas'] ?? 'Pelayanan Warga',
      sesi: _sesiTerpilih!,
    );

    context.read<PengajuanModel>().tambahPengajuan(pengajuan);

    setState(() => _sedangMengirim = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan berhasil dikirim.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    final layanan = arguments is Map
        ? arguments.map(
            (key, value) => MapEntry(
              key.toString(),
              value.toString(),
            ),
          )
        : <String, String>{
            'nama': 'Pengajuan Layanan Baru',
            'dinas': 'Pelayanan Warga',
            'jam': 'Sesuai jadwal layanan',
            'keterangan': 'Lengkapi formulir pengajuan layanan.',
          };

    final namaLayanan =
        layanan['nama'] ?? 'Pengajuan Layanan Baru';
    final dinas =
        layanan['dinas'] ?? 'Pelayanan Warga';
    final jam =
        layanan['jam'] ?? 'Sesuai jadwal layanan';
    final keterangan =
        layanan['keterangan'] ?? 'Lengkapi formulir pengajuan.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.account_balance,
                        size: 42,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        namaLayanan,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Bidang layanan: $dinas'),
                      const SizedBox(height: 4),
                      Text('Jadwal: $jam'),
                      const SizedBox(height: 8),
                      Text(keterangan),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Formulir Pengajuan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Alamat Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';

                  if (email.isEmpty) {
                    return 'Email wajib diisi.';
                  }

                  if (!email.contains('@') ||
                      !email.contains('.')) {
                    return 'Masukkan alamat email yang valid.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Pilih Sesi Kunjungan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioGroup<String>(
                groupValue: _sesiTerpilih,
                onChanged: (value) {
                  setState(() {
                    _sesiTerpilih = value;
                  });
                },
                child: const Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Sesi Pagi'),
                      subtitle: Text('08.00–11.00'),
                      value: 'Pagi',
                    ),
                    RadioListTile<String>(
                      title: Text('Sesi Siang'),
                      subtitle: Text('11.00–14.00'),
                      value: 'Siang',
                    ),
                    RadioListTile<String>(
                      title: Text('Sesi Sore'),
                      subtitle: Text('14.00–16.00'),
                      value: 'Sore',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _setujuSyarat,
                title: const Text(
                  'Saya menyetujui persyaratan dan penggunaan data '
                  'untuk keperluan pengajuan.',
                ),
                onChanged: _sedangMengirim
                    ? null
                    : (value) {
                        setState(() {
                          _setujuSyarat = value ?? false;
                        });
                      },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _sedangMengirim
                      ? null
                      : () => _kirimPengajuan(layanan),
                  icon: _sedangMengirim
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    _sedangMengirim
                        ? 'Mengirim Pengajuan...'
                        : 'Kirim Pengajuan',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}