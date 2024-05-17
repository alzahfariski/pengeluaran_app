import 'package:flutter/material.dart';
import 'package:pengeluaran/models/keluar.dart';
import 'package:pengeluaran/widgets/chart/chart.dart';
import 'package:pengeluaran/widgets/pengeluaran_baru.dart';
import 'package:pengeluaran/widgets/pengeluaran_list/pegeluaran_list.dart';

class Pengeluaran extends StatefulWidget {
  const Pengeluaran({super.key});

  @override
  State<Pengeluaran> createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {
  final List<Keluar> _daftarkeluar = [
    Keluar(
      judul: 'makanan',
      jumlah: 200,
      kategori: Kategori.makanan,
      tgl: DateTime.now(),
    ),
    Keluar(
      judul: 'pekerjaan',
      jumlah: 300,
      kategori: Kategori.pekerjaan,
      tgl: DateTime.now(),
    ),
  ];

  void _openTambahPengeluaran() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => PengeluaranBaru(onTambahKeluar: _tambahPengeluaran),
    );
  }

  void _tambahPengeluaran(Keluar keluar) {
    setState(() {
      _daftarkeluar.add(keluar);
    });
  }

  void _hapusPengeluaran(Keluar keluar) {
    final keluarIndex = _daftarkeluar.indexOf(keluar);
    setState(() {
      _daftarkeluar.remove(keluar);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('berhasil dihapus'),
        action: SnackBarAction(
            label: 'Batalkan',
            onPressed: () {
              setState(() {
                _daftarkeluar.insert(keluarIndex, keluar);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('tidak ada data ...'),
    );

    if (_daftarkeluar.isNotEmpty) {
      mainContent = PengeluaranList(
        pengeluaran: _daftarkeluar,
        onHapusPengeluaran: _hapusPengeluaran,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Pengeluaran'),
        actions: [
          IconButton(
            onPressed: _openTambahPengeluaran,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _daftarkeluar),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
