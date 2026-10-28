
import 'package:flutter/material.dart';

class HalamanTanyaPetugas extends StatefulWidget {
  const HalamanTanyaPetugas({super.key});

  @override
  State<HalamanTanyaPetugas> createState() =>
      _HalamanTanyaPetugasState();
}

class _HalamanTanyaPetugasState
    extends State<HalamanTanyaPetugas> {
  final _pesanController = TextEditingController();

  final List<Map<String, dynamic>> _pesan = [
    {
      'isi': 'Selamat datang. Ada yang bisa kami bantu?',
      'warga': false,
    },
  ];

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  void _kirimPesan() {
    final teks = _pesanController.text.trim();

    if (teks.isEmpty) return;

    setState(() {
      _pesan.add({
        'isi': teks,
        'warga': true,
      });
      _pesanController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pesan.length,
              itemBuilder: (context, index) {
                final pesan = _pesan[index];
                final dariWarga = pesan['warga'] as bool;

                return Align(
                  alignment: dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: dariWarga
                          ? const Color(0xFF145DA0)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      pesan['isi'] as String,
                      style: TextStyle(
                        color: dariWarga
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    decoration: InputDecoration(
                      hintText: 'Tulis pesan...',
                      filled: true,
                      fillColor: const Color(0xFFF4F7FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _kirimPesan(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _kirimPesan,
                  icon: const Icon(Icons.send),
                  tooltip: 'Kirim pesan',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
