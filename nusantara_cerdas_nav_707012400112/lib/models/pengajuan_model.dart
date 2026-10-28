import 'package:flutter/foundation.dart';

class DataPengajuan {
  final String nama;
  final String email;
  final String bidangLayanan;
  final String sesi;
  bool selesai;

  DataPengajuan({
    required this.nama,
    required this.email,
    required this.bidangLayanan,
    required this.sesi,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<DataPengajuan> _daftarPengajuan = [];

  List<DataPengajuan> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);

  int get totalPengajuan => _daftarPengajuan.length;

  void tambahPengajuan(DataPengajuan pengajuan) {
    _daftarPengajuan.add(pengajuan);
    notifyListeners();
  }

  void tandaiSelesai(int index) {
    if (index >= 0 && index < _daftarPengajuan.length) {
      _daftarPengajuan[index].selesai = true;
      notifyListeners();
    }
  }

  Map<String, int> get statistikLayanan {
    final Map<String, int> statistik = {};

    for (final pengajuan in _daftarPengajuan) {
      statistik.update(
        pengajuan.bidangLayanan,
        (jumlah) => jumlah + 1,
        ifAbsent: () => 1,
      );
    }

    return statistik;
  }
}
