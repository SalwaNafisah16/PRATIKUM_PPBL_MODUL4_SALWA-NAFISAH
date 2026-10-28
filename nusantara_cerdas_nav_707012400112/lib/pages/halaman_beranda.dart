
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  static const warnaUtama = Color(0xFF145DA0);
  static const warnaLatar = Color(0xFFF4F7FB);

  @override
  Widget build(BuildContext context) {
    final pengajuan = context.watch<PengajuanModel>();

    return Container(
      color: warnaLatar,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF145DA0), Color(0xFF0C8A91)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_city,
                    color: Colors.white, size: 36),
                SizedBox(height: 20),
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Nusantara Cerdas Mobile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Akses layanan publik dengan mudah dalam satu aplikasi.',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Ringkasan Pengajuan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F0FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.assignment_outlined,
                    color: warnaUtama,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Total pengajuan layanan',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  '${pengajuan.totalPengajuan}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: warnaUtama,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Akses Cepat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _menuCepat(
                  context,
                  Icons.people_alt_outlined,
                  'Layanan Warga',
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.beranda,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _menuCepat(
                  context,
                  Icons.chat_bubble_outline,
                  'Tanya Petugas',
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.tanyaPetugas,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            'Enam Pilar Smart City',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _pilar(
            Icons.account_balance_outlined,
            'Smart Governance',
            'Layanan pemerintahan yang terintegrasi.',
          ),
          _pilar(
            Icons.storefront_outlined,
            'Smart Economy',
            'Mendukung pertumbuhan ekonomi masyarakat.',
          ),
          _pilar(
            Icons.groups_outlined,
            'Smart Society',
            'Mendorong partisipasi masyarakat.',
          ),
          _pilar(
            Icons.eco_outlined,
            'Smart Environment',
            'Mendukung lingkungan yang berkelanjutan.',
          ),
          _pilar(
            Icons.directions_bus_outlined,
            'Smart Mobility',
            'Mendukung mobilitas warga.',
          ),
          _pilar(
            Icons.health_and_safety_outlined,
            'Smart Living',
            'Meningkatkan kualitas hidup masyarakat.',
          ),
        ],
      ),
    );
  }

  Widget _menuCepat(
    BuildContext context,
    IconData ikon,
    String judul,
    VoidCallback aksi,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: aksi,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 12,
          ),
          child: Column(
            children: [
              Icon(ikon, color: warnaUtama, size: 30),
              const SizedBox(height: 10),
              Text(
                judul,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pilar(
    IconData ikon,
    String judul,
    String keterangan,
  ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F0FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(ikon, color: warnaUtama),
        ),
        title: Text(
          judul,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(keterangan),
      ),
    );
  }
}
