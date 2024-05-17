import 'package:flutter/material.dart';
import 'package:pengeluaran/models/keluar.dart';

class PengeluaranBaru extends StatefulWidget {
  const PengeluaranBaru({super.key, required this.onTambahKeluar});

  final void Function(Keluar keluar) onTambahKeluar;

  @override
  State<PengeluaranBaru> createState() => _PengeluaranBaruState();
}

class _PengeluaranBaruState extends State<PengeluaranBaru> {
  final _titleController = TextEditingController();
  final _jumlahController = TextEditingController();
  DateTime? _selectedTanggal;
  Kategori _selectedKategori = Kategori.kendaraan;

  void _presentTanggal() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedTanggal = pickedDate;
    });
  }

  void _submitKeluarData() {
    final enteredJumlah = double.tryParse(_jumlahController.text);
    final jumlahIsInvalid = enteredJumlah == null || enteredJumlah <= 0;
    if (_titleController.text.trim().isEmpty ||
        jumlahIsInvalid ||
        _selectedTanggal == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('invalid input'),
          content: const Text('masukan data dengan benar'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('oke'))
          ],
        ),
      );
      return;
    }
    widget.onTambahKeluar(
      Keluar(
        judul: _titleController.text,
        jumlah: enteredJumlah,
        kategori: _selectedKategori,
        tgl: _selectedTanggal!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('jumlah'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedTanggal == null
                          ? 'tidak ada data'
                          : formatter.format(_selectedTanggal!),
                    ),
                    IconButton(
                      onPressed: _presentTanggal,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedKategori,
                items: Kategori.values
                    .map(
                      (kategori) => DropdownMenuItem(
                        value: kategori,
                        child: Text(
                          kategori.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedKategori = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: _submitKeluarData,
                child: const Text('save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
