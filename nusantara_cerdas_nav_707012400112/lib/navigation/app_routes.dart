
import 'package:flutter/material.dart';

import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_tentang.dart';
import '../pages/halaman_keluar.dart';
import '../pages/halaman_riwayat.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayat = '/riwayat';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';
  static const String keluar = '/keluar';
  static const String tanyaPetugas = '/tanya-petugas';
  static const String lokasiKantor = '/lokasi-kantor';
  static const String statistikLayanan = '/statistik-layanan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayat: (context) => const HalamanRiwayat(),
      pengaturan: (context) => const HalamanPengaturan(),
      tentang: (context) => const HalamanTentang(),
      keluar: (context) => const HalamanKeluar(),
      tanyaPetugas: (context) => const HalamanTanyaPetugas(),
      lokasiKantor: (context) => const HalamanLokasiKantor(),
      statistikLayanan: (context) =>
          const HalamanStatistikLayanan(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final arguments = settings.arguments;

      if (arguments is Map<String, String>) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HalamanDetailLayanan(),
        );
      }

      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Data Layanan'),
          ),
          body: const Center(
            child: Text('Data layanan tidak tersedia.'),
          ),
        ),
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Tidak Ditemukan'),
        ),
        body: Center(
          child: Text(
            'Route ${settings.name} belum terdaftar.',
          ),
        ),
      ),
    );
  }
}
