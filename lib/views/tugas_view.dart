import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/ios_badge.dart';
import '../widgets/modal_tugas.dart';

class TugasView extends StatefulWidget {
  final KelasRepository repo;

  const TugasView({super.key, required this.repo});

  @override
  State<TugasView> createState() => _TugasViewState();
}

class _TugasViewState extends State<TugasView> {
  String _filter = 'semua';

  void _bukaModalTambah() {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalTambahTugas(
        onSave: (tugas) {
          widget.repo.addTugas(tugas);
        },
      ),
    );
  }

  void _konfirmasiHapus(String id) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Hapus Tugas'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan tugas ini?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Hapus'),
            onPressed: () {
              widget.repo.deleteTugas(id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.repo.accentColor;
    final allTugas = widget.repo.tugasList;
    final list = _filter == 'belum'
        ? allTugas.where((t) => !t.selesai).toList()
        : _filter == 'selesai'
            ? allTugas.where((t) => t.selesai).toList()
            : allTugas;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('📝 Agenda Tugas & PR'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _bukaModalTambah,
          child: Icon(CupertinoIcons.plus_circle_fill, size: 24, color: accent),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AGENDA AKADEMIK',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel, letterSpacing: 0.6),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tugas & PR 📝',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  color: accent,
                  borderRadius: BorderRadius.circular(16),
                  onPressed: _bukaModalTambah,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.add, size: 14, color: CupertinoColors.white),
                      SizedBox(width: 4),
                      Text('Tugas Baru', style: TextStyle(fontSize: 12, color: CupertinoColors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Segmented Control
            Center(
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _filter,
                  children: const {
                    'semua': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Semua')),
                    'belum': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Belum Selesai ⏳')),
                    'selesai': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Selesai ✨')),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _filter = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            IosCard(
              padding: EdgeInsets.zero,
              child: list.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: Text(
                          'Tidak ada catatan tugas pada filter ini. 🎉',
                          style: TextStyle(color: CupertinoColors.secondaryLabel),
                        ),
                      ),
                    )
                  : Column(
                      children: list.map((item) {
                        final isDone = item.selesai;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CupertinoButton(
                                padding: const EdgeInsets.only(top: 2),
                                onPressed: () => widget.repo.toggleTugas(item.id),
                                child: Icon(
                                  isDone ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
                                  size: 22,
                                  color: isDone ? CupertinoColors.systemGreen : CupertinoColors.systemGrey3,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.judul,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        decoration: isDone ? TextDecoration.lineThrough : null,
                                        color: isDone ? CupertinoColors.secondaryLabel : CupertinoColors.label,
                                      ),
                                    ),
                                    if (item.deskripsi.isNotEmpty) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        item.deskripsi,
                                        style: const TextStyle(fontSize: 12, height: 1.35, color: CupertinoColors.secondaryLabel),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 4,
                                      children: [
                                        IosBadge(text: item.mapel, type: IosBadgeType.gray),
                                        IosBadge(
                                          text: 'Deadline: ${DateFormat('dd MMM yyyy').format(item.deadline)}',
                                          type: isDone ? IosBadgeType.green : IosBadgeType.blue,
                                        ),
                                        IosBadge(
                                          text: item.prioritas,
                                          type: item.prioritas == 'Tinggi' ? IosBadgeType.red : IosBadgeType.gray,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _konfirmasiHapus(item.id),
                                child: const Icon(CupertinoIcons.trash, size: 16, color: CupertinoColors.systemGrey),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
