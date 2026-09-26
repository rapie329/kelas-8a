import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/kas.dart';

class ModalTambahKas extends StatefulWidget {
  final String initialTipe;
  final Function(TransaksiKas) onSave;

  const ModalTambahKas({
    super.key,
    this.initialTipe = 'masuk',
    required this.onSave,
  });

  @override
  State<ModalTambahKas> createState() => _ModalTambahKasState();
}

class _ModalTambahKasState extends State<ModalTambahKas> {
  late String _tipe;
  final _nominalController = TextEditingController();
  final _keteranganController = TextEditingController();
  DateTime _tanggal = DateTime.now();
  String _kategori = 'Iuran Kas';

  final List<String> _kategoriMasuk = [
    'Iuran Kas',
    'Donasi / Sukarela',
    'Dana Usaha',
    'Sisa Kegiatan',
    'Lainnya',
  ];

  final List<String> _kategoriKeluar = [
    'ATK Kelas',
    'Perlengkapan',
    'Dekorasi & P3K',
    'Fotokopi',
    'Sosial & Jenguk',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _tipe = widget.initialTipe;
    _kategori = _tipe == 'masuk' ? _kategoriMasuk.first : _kategoriKeluar.first;
  }

  @override
  void dispose() {
    _nominalController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  void _submit() {
    final nominalText = _nominalController.text.trim();
    if (nominalText.isEmpty) return;
    final nominal = int.tryParse(nominalText) ?? 0;
    if (nominal <= 0) return;

    final keterangan = _keteranganController.text.trim();
    if (keterangan.isEmpty) return;

    final transaksi = TransaksiKas(
      id: 'ks-${DateTime.now().millisecondsSinceEpoch}',
      tanggal: _tanggal,
      tipe: _tipe,
      kategori: _kategori,
      nominal: nominal,
      keterangan: keterangan,
    );

    widget.onSave(transaksi);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final currentKategoriList = _tipe == 'masuk' ? _kategoriMasuk : _kategoriKeluar;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey3,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _tipe == 'masuk' ? 'Catat Kas Masuk' : 'Catat Pengeluaran',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.clear_circled_solid, color: CupertinoColors.systemGrey2),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CupertinoSlidingSegmentedControl<String>(
              groupValue: _tipe,
              children: const {
                'masuk': Padding(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6), child: Text('Pemasukan')),
                'keluar': Padding(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6), child: Text('Pengeluaran')),
              },
              onValueChanged: (val) {
                if (val != null) {
                  setState(() {
                    _tipe = val;
                    _kategori = _tipe == 'masuk' ? _kategoriMasuk.first : _kategoriKeluar.first;
                  });
                }
              },
            ),
            const SizedBox(height: 14),
            const Text(
              'NOMINAL (RUPIAH)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              placeholder: 'Contoh: 50000',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'KATEGORI',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (ctx) => Container(
                      height: 200,
                      color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                      child: CupertinoPicker(
                        itemExtent: 36,
                        scrollController: FixedExtentScrollController(
                          initialItem: currentKategoriList.indexOf(_kategori),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() => _kategori = currentKategoriList[index]);
                        },
                        children: currentKategoriList.map((k) => Center(child: Text(k))).toList(),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_kategori, style: TextStyle(color: isDark ? CupertinoColors.white : CupertinoColors.black)),
                    const Icon(CupertinoIcons.chevron_down, size: 16, color: CupertinoColors.secondaryLabel),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'KETERANGAN TRANSAKSI',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _keteranganController,
              placeholder: _tipe == 'masuk' ? 'Misal: Iuran Kas Minggu ke-5 (32 Siswa)' : 'Misal: Beli 2 spidol whiteboard hitam',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'TANGGAL TRANSAKSI',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                alignment: Alignment.centerLeft,
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (ctx) => Container(
                      height: 220,
                      color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _tanggal,
                        onDateTimeChanged: (val) {
                          setState(() => _tanggal = val);
                        },
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(_tanggal),
                      style: TextStyle(color: isDark ? CupertinoColors.white : CupertinoColors.black),
                    ),
                    const Icon(CupertinoIcons.calendar, size: 18, color: CupertinoColors.activeBlue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            CupertinoButton(
              color: _tipe == 'masuk' ? CupertinoColors.activeBlue : CupertinoColors.systemRed,
              borderRadius: BorderRadius.circular(12),
              onPressed: _submit,
              child: Text(
                _tipe == 'masuk' ? 'Simpan Pemasukan' : 'Simpan Pengeluaran',
                style: const TextStyle(fontWeight: FontWeight.w600, color: CupertinoColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
