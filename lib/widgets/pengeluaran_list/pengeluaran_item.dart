import 'package:flutter/material.dart';
import 'package:pengeluaran/models/keluar.dart';

class PengeluaranItem extends StatelessWidget {
  const PengeluaranItem(this.keluar, {super.key});

  final Keluar keluar;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keluar.judul,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${keluar.jumlah.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(kategoriIcons[keluar.kategori]),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(keluar.formattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
