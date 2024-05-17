import 'package:flutter/material.dart';

import 'chart_bar.dart';
import '../../models/keluar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Keluar> expenses;

  List<KeluarBucket> get buckets {
    return [
      KeluarBucket.forKategori(expenses, Kategori.makanan),
      KeluarBucket.forKategori(expenses, Kategori.liburan),
      KeluarBucket.forKategori(expenses, Kategori.kendaraan),
      KeluarBucket.forKategori(expenses, Kategori.pekerjaan),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalPengeluaran > maxTotalExpense) {
        maxTotalExpense = bucket.totalPengeluaran;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalPengeluaran == 0
                        ? 0
                        : bucket.totalPengeluaran / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        kategoriIcons[bucket.kategori],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
