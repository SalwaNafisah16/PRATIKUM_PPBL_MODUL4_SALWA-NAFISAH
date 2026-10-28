import 'package:flutter/material.dart';

class Pendaftar {
  final String nama;
  final String nim;
  final String sesi;

  Pendaftar({required this.nama, required this.nim, required this.sesi});
}

class PendaftarModel extends ChangeNotifier {
  final List<Pendaftar> _daftarPendaftar = [];

  List<Pendaftar> get daftarPendaftar => List.unmodifiable(_daftarPendaftar);

  void tambahPendaftar({
    required String nama,
    required String nim,
    required String sesi,
  }) {
    _daftarPendaftar.add(Pendaftar(nama: nama, nim: nim, sesi: sesi));

    notifyListeners();
  }

  int jumlahPendaftarPerSesi(String sesi) {
    return _daftarPendaftar.where((pendaftar) => pendaftar.sesi == sesi).length;
  }

  int get totalPendaftar => _daftarPendaftar.length;
}
