
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/pengajuan_model.dart';

class HalamanStatistikLayanan extends StatelessWidget {
  const HalamanStatistikLayanan({super.key});

  static const Color warnaUtama = Color(0xFF145DA0);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final statistik = model.statistikLayanan;

    final Map<String, int> dataGrafik = statistik.isEmpty
        ? <String, int>{'Belum ada': 0}
        : statistik;

    final nilaiTertinggi = dataGrafik.values.fold<int>(
      0,
      (tertinggi, nilai) =>
          nilai > tertinggi ? nilai : tertinggi,
    );

    final double maxY =
        nilaiTertinggi == 0 ? 5.0 : (nilaiTertinggi + 1).toDouble();

    return Container(
      color: const Color(0xFFF4F7FB),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF145DA0),
                  Color(0xFF0C8A9B),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 36,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Statistik Layanan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Ringkasan pengajuan berdasarkan jenis layanan.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Total Pengajuan',
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  '${model.totalPengajuan}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE3EAF2)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Jumlah Pengajuan per Layanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 280,
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        minY: 0,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (
                              group,
                              groupIndex,
                              rod,
                              rodIndex,
                            ) {
                              final nama =
                                  dataGrafik.keys.elementAt(groupIndex);

                              return BarTooltipItem(
                                '$nama\n${rod.toY.toInt()} pengajuan',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  meta: meta,
                                  space: 8,
                                  child: Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 65,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                final namaLayanan =
                                    dataGrafik.keys.toList();

                                if (index < 0 ||
                                    index >= namaLayanan.length) {
                                  return const SizedBox.shrink();
                                }

                                return SideTitleWidget(
                                  meta: meta,
                                  space: 8,
                                  child: SizedBox(
                                    width: 70,
                                    child: Text(
                                      namaLayanan[index],
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        barGroups: List.generate(
                          dataGrafik.length,
                          (index) {
                            final jumlah =
                                dataGrafik.values.elementAt(index);

                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: jumlah.toDouble(),
                                  width: 24,
                                  color: warnaUtama,
                                  borderRadius:
                                      const BorderRadius.vertical(
                                    top: Radius.circular(6),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  if (statistik.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Text(
                          'Belum ada pengajuan. Grafik akan terisi '
                          'setelah data ditambahkan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE3EAF2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Pengajuan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (statistik.isEmpty)
                    const Text('Belum ada data layanan.')
                  else
                    ...statistik.entries.map(
                      (entry) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE5EFFA),
                          child: Icon(
                            Icons.assignment_outlined,
                            color: warnaUtama,
                          ),
                        ),
                        title: Text(entry.key),
                        trailing: Text(
                          '${entry.value}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warnaUtama,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
