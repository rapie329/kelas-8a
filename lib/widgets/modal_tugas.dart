import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/tugas.dart';

class ModalTambahTugas extends StatefulWidget {
  final Function(Tugas) onSave;

  const ModalTambahTugas({super.key, required this.onSave});

  @override
  State<ModalTambahTugas> createState() => _ModalTambahTugasState();
}

class _ModalTambahTugasState extends State<ModalTambahTugas> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String _mapel = 'Matematika';
  DateTime _deadline = DateTime.now().add(const Duration(days: 3));
  String _prioritas = 'Sedang';

  final List<String> _listMapel = [
    'Matematika',
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'IPA Terpadu',
    'IPS Terpadu',
    'Pendidikan Agama Islam',
    'PPKn',
    'Informatika',
    'PJOK (Olahraga)',
    'Prakarya',
    'Seni Budaya',
    'Bahasa Daerah',
    'Lainnya',
  ];

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_judulController.text.trim().isEmpty) return;

    final tugas = Tugas(
      id: 'tg-${DateTime.now().millisecondsSinceEpoch}',
      mapel: _mapel,
      judul: _judulController.text.trim(),
      deskripsi: _deskripsiController.text.trim(),
      deadline: _deadline,
      prioritas: _prioritas,
    );

    widget.onSave(tugas);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;

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
                const Text(
                  'Catat Tugas Baru',
                  style: TextStyle(
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
            const SizedBox(height: 16),
            const Text(
              'MATA PELAJARAN',
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
                      height: 220,
                      color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                      child: CupertinoPicker(
                        itemExtent: 36,
                        scrollController: FixedExtentScrollController(
                          initialItem: _listMapel.indexOf(_mapel),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() => _mapel = _listMapel[index]);
                        },
                        children: _listMapel.map((m) => Center(child: Text(m))).toList(),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_mapel, style: TextStyle(color: isDark ? CupertinoColors.white : CupertinoColors.black)),
                    const Icon(CupertinoIcons.chevron_down, size: 16, color: CupertinoColors.secondaryLabel),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'JUDUL / INSTRUKSI TUGAS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _judulController,
              placeholder: 'Misal: Latihan Soal Hal 84 No 1-10',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'KETERANGAN TAMBAHAN',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _deskripsiController,
              placeholder: 'Format buku, pembagian kelompok, atau pesan guru...',
              maxLines: 2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'TENGGAT WAKTU (DEADLINE)',
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
                      height: 240,
                      color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _deadline,
                        onDateTimeChanged: (val) {
                          setState(() => _deadline = val);
                        },
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(_deadline),
                      style: TextStyle(color: isDark ? CupertinoColors.white : CupertinoColors.black),
                    ),
                    const Icon(CupertinoIcons.calendar, size: 18, color: CupertinoColors.activeBlue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'TINGKAT PRIORITAS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoSlidingSegmentedControl<String>(
              groupValue: _prioritas,
              children: const {
                'Tinggi': Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Tinggi')),
                'Sedang': Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Sedang')),
                'Rendah': Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Rendah')),
              },
              onValueChanged: (val) {
                if (val != null) setState(() => _prioritas = val);
              },
            ),
            const SizedBox(height: 22),
            CupertinoButton.filled(
              onPressed: _submit,
              borderRadius: BorderRadius.circular(12),
              child: const Text('Simpan Tugas', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
