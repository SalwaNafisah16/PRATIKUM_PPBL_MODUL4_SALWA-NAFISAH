import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PendaftarModel>();

    final sesi = ['Pagi', 'Siang', 'Sore'];
    final jumlah = sesi
        .map((namaSesi) => model.jumlahPendaftarPerSesi(namaSesi))
        .toList();

    final maxJumlah = jumlah.isEmpty
        ? 0
        : jumlah.reduce((a, b) => a > b ? a : b);

    // Skala grafik mengikuti jumlah pendaftar.
    final batasAtas = maxJumlah == 0 ? 10 : ((maxJumlah + 9) ~/ 10) * 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pendaftar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Pendaftar: ${model.totalPendaftar}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            const Text(
              'Jumlah Pendaftar per Sesi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik Pendaftar',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: GrafikPendaftarPainter(
                        jumlah: jumlah,
                        labelSesi: sesi,
                        batasAtas: batasAtas,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ...List.generate(sesi.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00BCD4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('${sesi[index]}: ${jumlah[index]} pendaftar'),
                    ),
                  ],
                ),
              );
            }),

            if (model.totalPendaftar == 0) ...[
              const SizedBox(height: 12),
              const Text(
                'Belum ada data pendaftar. '
                'Silakan isi formulir terlebih dahulu.',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class GrafikPendaftarPainter extends CustomPainter {
  final List<int> jumlah;
  final List<String> labelSesi;
  final int batasAtas;

  GrafikPendaftarPainter({
    required this.jumlah,
    required this.labelSesi,
    required this.batasAtas,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const kiri = 34.0;
    const kanan = 30.0;
    const atas = 8.0;
    const bawah = 28.0;

    final lebarGrafik = size.width - kiri - kanan;
    final tinggiGrafik = size.height - atas - bawah;

    final garis = Paint()
      ..color = Colors.blueGrey.withValues(alpha: 0.25)
      ..strokeWidth = 1;

    final sumbu = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1;

    final batang = Paint()
      ..color = const Color(0xFF00BCD4)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final teks = TextPainter(textDirection: TextDirection.ltr);

    // Garis horizontal dan label sumbu Y.
    for (int i = 0; i <= 5; i++) {
      final nilai = (batasAtas * i / 5).round();
      final y = atas + tinggiGrafik - (tinggiGrafik * i / 5);

      canvas.drawLine(Offset(kiri, y), Offset(kiri + lebarGrafik, y), garis);

      teks.text = TextSpan(
        text: '$nilai',
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      );
      teks.layout();
      teks.paint(canvas, Offset(kiri - teks.width - 6, y - teks.height / 2));
    }

    // Sumbu grafik.
    canvas.drawLine(
      const Offset(kiri, atas),
      Offset(kiri, atas + tinggiGrafik),
      sumbu,
    );
    canvas.drawLine(
      Offset(kiri, atas + tinggiGrafik),
      Offset(kiri + lebarGrafik, atas + tinggiGrafik),
      sumbu,
    );

    // Batang dan label sesi.
    final jarak = lebarGrafik / jumlah.length;

    for (int i = 0; i < jumlah.length; i++) {
      final x = kiri + jarak * (i + 0.5);
      final tinggiBatang = jumlah[i] / batasAtas * tinggiGrafik;
      final y = atas + tinggiGrafik - tinggiBatang;

      if (jumlah[i] > 0) {
        canvas.drawLine(Offset(x, atas + tinggiGrafik), Offset(x, y), batang);
      }

      teks.text = TextSpan(
        text: labelSesi[i],
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      );
      teks.layout();
      teks.paint(canvas, Offset(x - teks.width / 2, atas + tinggiGrafik + 8));
    }
  }

  @override
  bool shouldRepaint(covariant GrafikPendaftarPainter oldDelegate) {
    return oldDelegate.jumlah != jumlah ||
        oldDelegate.labelSesi != labelSesi ||
        oldDelegate.batasAtas != batasAtas;
  }
}
