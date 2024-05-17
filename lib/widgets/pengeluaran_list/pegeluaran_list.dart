import 'package:flutter/material.dart';
import 'package:pengeluaran/models/keluar.dart';
import 'package:pengeluaran/widgets/pengeluaran_list/pengeluaran_item.dart';

class PengeluaranList extends StatelessWidget {
  const PengeluaranList({
    super.key,
    required this.pengeluaran,
    required this.onHapusPengeluaran,
  });

  final List<Keluar> pengeluaran;
  final void Function(Keluar keluar) onHapusPengeluaran;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pengeluaran.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onHapusPengeluaran(pengeluaran[index]);
        },
        key: ValueKey(pengeluaran[index]),
        child: PengeluaranItem(pengeluaran[index]),
      ),
    );
  }
}
