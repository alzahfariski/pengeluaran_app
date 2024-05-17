import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Kategori { makanan, kendaraan, pekerjaan, liburan }

const kategoriIcons = {
  Kategori.kendaraan: Icons.flight_takeoff,
  Kategori.liburan: Icons.movie,
  Kategori.makanan: Icons.lunch_dining,
  Kategori.pekerjaan: Icons.work,
};

class Keluar {
  Keluar({
    required this.judul,
    required this.jumlah,
    required this.kategori,
    required this.tgl,
  }) : id = uuid.v4();

  final String id;
  final String judul;
  final double jumlah;
  final DateTime tgl;
  final Kategori kategori;

  String get formattedDate {
    return formatter.format(tgl);
  }
}

class KeluarBucket {
  const KeluarBucket({required this.kategori, required this.pengeluaran});

  KeluarBucket.forKategori(List<Keluar> allPengeluaran, this.kategori)
      : pengeluaran = allPengeluaran
            .where((keluar) => keluar.kategori == kategori)
            .toList();

  final Kategori kategori;
  final List<Keluar> pengeluaran;

  double get totalPengeluaran {
    double sum = 0;

    for (final keluar in pengeluaran) {
      sum += keluar.jumlah;
    }

    return sum;
  }
}
