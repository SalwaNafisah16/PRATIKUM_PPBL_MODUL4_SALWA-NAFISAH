
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  static const Color warnaUtama = Color(0xFF145DA0);

  @override
  Widget build(BuildContext context) {
    final pengajuanModel = context.watch<PengajuanModel>();
    final daftarPengajuan = pengajuanModel.daftarPengajuan;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profil warga
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFE5F0FF),
                  child: Icon(
                    Icons.person,
                    size: 34,
                    color: warnaUtama,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Salwa Nafisah',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Warga Nusantara'),
                    ],
                  ),
                ),
                Icon(
                  Icons.verified_user_outlined,
                  color: warnaUtama,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Ringkasan pengajuan
          Row(
            children: [
              Expanded(
                child: _ringkasan(
                  'Total Pengajuan',
                  '${pengajuanModel.totalPengajuan}',
                  Icons.assignment_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ringkasan(
                  'Selesai',
                  '${daftarPengajuan.where((item) => item.selesai).length}',
                  Icons.check_circle_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Riwayat Pengajuan',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Ketuk kartu untuk melihat detail. '
            'Tekan lama untuk menandai selesai.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),

          // Daftar riwayat pengajuan
          if (daftarPengajuan.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 44,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Belum ada pengajuan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pengajuan yang dikirim akan tampil di sini.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...List.generate(daftarPengajuan.length, (index) {
              final item = daftarPengajuan[index];

              return GestureDetector(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Detail Pengajuan'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama: ${item.nama}'),
                            const SizedBox(height: 8),
                            Text('Email: ${item.email}'),
                            const SizedBox(height: 8),
                            Text('Layanan: ${item.bidangLayanan}'),
                            const SizedBox(height: 8),
                            Text('Sesi: ${item.sesi}'),
                            const SizedBox(height: 8),
                            Text(
                              'Status: ${item.selesai ? "Selesai" : "Belum selesai"}',
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onLongPress: () {
                  if (item.selesai) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pengajuan ini sudah ditandai selesai.',
                        ),
                      ),
                    );
                    return;
                  }

                  pengajuanModel.tandaiSelesai(index);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pengajuan ditandai selesai ditindaklanjuti.',
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: Color(0xFFE6EAF0),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE5F0FF),
                      child: Icon(
                        Icons.description_outlined,
                        color: warnaUtama,
                      ),
                    ),
                    title: Text(
                      item.bidangLayanan,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item.nama}\nSesi ${item.sesi}',
                    ),
                    isThreeLine: true,
                    trailing: Icon(
                      item.selesai
                          ? Icons.check_circle
                          : Icons.pending_actions,
                      color: item.selesai
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              );
            }),

          const SizedBox(height: 24),

          const Text(
            'Layanan Favorit',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Daftar layanan favorit
          Consumer<FavoritModel>(
            builder: (context, favoritModel, child) {
              final daftarFavorit =
                  favoritModel.layananFavorit.toList();

              if (daftarFavorit.isEmpty) {
                return const Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.star_outline),
                    title: Text('Belum ada layanan favorit.'),
                  ),
                );
              }

              return Column(
                children: daftarFavorit.map((namaLayanan) {
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    child: ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      title: Text(namaLayanan),
                      trailing: IconButton(
                        tooltip: 'Hapus dari favorit',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          favoritModel.batalTandai(namaLayanan);
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 80),
        ],
      ),

      // Tombol pengajuan baru
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailLayanan,
            arguments: <String, String>{
              'nama': 'Pengajuan Layanan Baru',
              'dinas': 'Pelayanan Warga',
              'jam': 'Sesuai jadwal layanan',
              'keterangan':
                  'Lengkapi formulir pengajuan layanan warga.',
            },
          );
        },
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Pengajuan Baru'),
      ),
    );
  }

  Widget _ringkasan(
    String judul,
    String jumlah,
    IconData ikon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: warnaUtama, size: 26),
          const SizedBox(height: 12),
          Text(
            jumlah,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            judul,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
