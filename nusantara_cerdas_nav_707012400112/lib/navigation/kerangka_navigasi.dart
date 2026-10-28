
import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
    HalamanTanyaPetugas(),
    HalamanLokasiKantor(),
    HalamanStatistikLayanan(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik Layanan',
  ];

  final List<IconData> _ikon = const [
    Icons.home_outlined,
    Icons.miscellaneous_services_outlined,
    Icons.people_outline,
    Icons.chat_outlined,
    Icons.location_on_outlined,
    Icons.bar_chart_outlined,
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool layarLebar =
            constraints.maxWidth >= 700;

        return Scaffold(
          appBar: AppBar(
            title: Text(_judul[_indeksTerpilih]),
          ),
          drawer: _buatDrawer(),
          body: Row(
            children: [
              if (layarLebar)
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihTujuan,
                  extended: constraints.maxWidth >= 950,
                  destinations: List.generate(
                    _judul.length,
                    (index) => NavigationRailDestination(
                      icon: Icon(_ikon[index]),
                      label: Text(_judul[index]),
                    ),
                  ),
                ),
              if (layarLebar)
                const VerticalDivider(width: 1),
              Expanded(
                child: IndexedStack(
                  index: _indeksTerpilih,
                  children: _halaman,
                ),
              ),
            ],
          ),
          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihTujuan,
                  destinations: List.generate(
                    _judul.length,
                    (index) => NavigationDestination(
                      icon: Icon(_ikon[index]),
                      label: _judul[index],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        _pilihTujuan(indeks);
        Navigator.pop(context);
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 28, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                child: Icon(Icons.location_city, size: 30),
              ),
              SizedBox(height: 12),
              Text(
                'Nusantara Cerdas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Layanan warga dalam satu aplikasi'),
            ],
          ),
        ),
        const Divider(),
        for (int i = 0; i < _judul.length; i++)
          NavigationDrawerDestination(
            icon: Icon(_ikon[i]),
            label: Text(_judul[i]),
          ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.pengaturan,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.tentang,
            );
          },
        ),
      ],
    );
  }
}
