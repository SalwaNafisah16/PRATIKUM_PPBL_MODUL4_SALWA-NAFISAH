import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() =>
      _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  final TextEditingController _pencarianController =
      TextEditingController();

  String _kataKunci = '';
  String _kategoriTerpilih = 'Semua';

  final List<Map<String, String>> _daftarLayanan = [
    {
      'nama': 'Administrasi Kependudukan',
      'dinas': 'Dinas Kependudukan',
      'jam': '08.00–15.00',
      'kategori': 'Administrasi',
      'keterangan':
          'Layanan administrasi kependudukan dan dokumen warga.',
      'ikon': 'person',
    },
    {
      'nama': 'Perizinan Usaha',
      'dinas': 'Dinas Perizinan',
      'jam': '08.00–15.00',
      'kategori': 'Perizinan',
      'keterangan':
          'Layanan informasi dan pengajuan perizinan usaha.',
      'ikon': 'business',
    },
    {
      'nama': 'Pengaduan Lingkungan',
      'dinas': 'Dinas Lingkungan Hidup',
      'jam': '08.00–16.00',
      'kategori': 'Pengaduan',
      'keterangan':
          'Layanan pengaduan terkait kebersihan dan lingkungan.',
      'ikon': 'eco',
    },
    {
      'nama': 'Layanan Kesehatan',
      'dinas': 'Dinas Kesehatan',
      'jam': '08.00–14.00',
      'kategori': 'Kesehatan',
      'keterangan':
          'Layanan informasi dan administrasi kesehatan warga.',
      'ikon': 'health',
    },
    {
      'nama': 'Pengaduan Infrastruktur',
      'dinas': 'Dinas Pekerjaan Umum',
      'jam': '08.00–16.00',
      'kategori': 'Pengaduan',
      'keterangan':
          'Layanan pengaduan jalan, drainase, dan fasilitas umum.',
      'ikon': 'building',
    },
    {
      'nama': 'Informasi Bantuan Sosial',
      'dinas': 'Dinas Sosial',
      'jam': '08.00–15.00',
      'kategori': 'Sosial',
      'keterangan':
          'Layanan informasi mengenai program bantuan sosial.',
      'ikon': 'people',
    },
  ];

  final List<String> _kategori = [
    'Semua',
    'Administrasi',
    'Perizinan',
    'Pengaduan',
    'Kesehatan',
    'Sosial',
  ];

  @override
  void dispose() {
    _pencarianController.dispose();
    super.dispose();
  }

  IconData _ikonLayanan(String? ikon) {
    switch (ikon) {
      case 'person':
        return Icons.badge_outlined;
      case 'business':
        return Icons.business_outlined;
      case 'eco':
        return Icons.eco_outlined;
      case 'health':
        return Icons.health_and_safety_outlined;
      case 'building':
        return Icons.location_city_outlined;
      case 'people':
        return Icons.groups_outlined;
      default:
        return Icons.miscellaneous_services;
    }
  }

  void _bukaDetail(Map<String, String> layanan) {
    Navigator.pushNamed(
      context,
      AppRoutes.detailLayanan,
      arguments: layanan,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritModel = context.watch<FavoritModel>();

    final layananTampil = _daftarLayanan.where((layanan) {
      final nama = (layanan['nama'] ?? '').toLowerCase();
      final dinas = (layanan['dinas'] ?? '').toLowerCase();
      final kategori = layanan['kategori'] ?? '';

      final cocokKataKunci =
          nama.contains(_kataKunci.toLowerCase()) ||
          dinas.contains(_kataKunci.toLowerCase());

      final cocokKategori = _kategoriTerpilih == 'Semua' ||
          kategori == _kategoriTerpilih;

      return cocokKataKunci && cocokKategori;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan Warga'),
        actions: [
          IconButton(
            tooltip: 'Hapus pencarian',
            onPressed: () {
              _pencarianController.clear();
              setState(() {
                _kataKunci = '';
                _kategoriTerpilih = 'Semua';
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _pencarianController,
              decoration: InputDecoration(
                hintText: 'Cari nama layanan atau dinas...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _kataKunci.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _pencarianController.clear();
                          setState(() => _kataKunci = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _kataKunci = value.trim());
              },
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _kategori.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final kategori = _kategori[index];

                return ChoiceChip(
                  label: Text(kategori),
                  selected: _kategoriTerpilih == kategori,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _kategoriTerpilih = kategori;
                      });
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${layananTampil.length} layanan tersedia',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Icon(Icons.favorite, color: Colors.red),
                const SizedBox(width: 4),
                Text('${favoritModel.layananFavorit.length} favorit'),
              ],
            ),
          ),
          Expanded(
            child: layananTampil.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 56,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text('Layanan tidak ditemukan.'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      16,
                    ),
                    itemCount: layananTampil.length,
                    itemBuilder: (context, index) {
                      final layanan = layananTampil[index];
                      final nama = layanan['nama'] ?? '';
                      final dinas = layanan['dinas'] ?? '';
                      final kategori = layanan['kategori'] ?? '';
                      final isFavorit =
                          favoritModel.isFavorit(nama);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _bukaDetail(layanan),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  child: Icon(
                                    _ikonLayanan(layanan['ikon']),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nama,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(dinas),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Jadwal: ${layanan['jam'] ?? '-'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 8),
                                      Chip(
                                        label: Text(kategori),
                                        visualDensity:
                                            VisualDensity.compact,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      tooltip: isFavorit
                                          ? 'Hapus dari favorit'
                                          : 'Tambahkan ke favorit',
                                      onPressed: () {
                                        final model = context
                                            .read<FavoritModel>();

                                        if (isFavorit) {
                                          model.batalTandai(nama);
                                        } else {
                                          model.tandai(nama);
                                        }
                                      },
                                      icon: Icon(
                                        isFavorit
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorit
                                            ? Colors.red
                                            : null,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}