import 'package:flutter/material.dart';

import '../pages/detail_kegiatan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailKegiatan = '/detail-kegiatan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      detailKegiatan: (context) => const DetailKegiatanPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Route Tidak Ditemukan')),
        body: Center(child: Text('Route ${settings.name} belum terdaftar.')),
      ),
    );
  }
}
