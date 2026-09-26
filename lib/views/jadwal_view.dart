import 'package:flutter/cupertino.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/ios_badge.dart';

class JadwalView extends StatefulWidget {
  final KelasRepository repo;

  const JadwalView({super.key, required this.repo});

  @override
  State<JadwalView> createState() => _JadwalViewState();
}

class _JadwalViewState extends State<JadwalView> {
  String _selectedDay = 'senin';

  @override
  Widget build(BuildContext context) {
    final accent = widget.repo.accentColor;
    final list = widget.repo.jadwalMap[_selectedDay] ?? [];
    final piket = widget.repo.piketMap[_selectedDay];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('📅 Jadwal Pelajaran 8A'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            const Text(
              'WAKTU & PEMBELAJARAN',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel, letterSpacing: 0.6),
            ),
            const SizedBox(height: 2),
            const Text(
              'Jadwal Kelas 8A',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
            ),
            const SizedBox(height: 14),

            // Segmented Control
            Center(
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _selectedDay,
                  children: const {
                    'senin': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Sen')),
                    'selasa': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Sel')),
                    'rabu': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Rab')),
                    'kamis': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Kam')),
                    'jumat': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Jum')),
                    'sabtu': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Sab')),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _selectedDay = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            Row(
              children: [
                const Text('📚', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  'MAPEL HARI ${_selectedDay.toUpperCase()}',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel),
                ),
              ],
            ),
            const SizedBox(height: 8),

            IosCard(
              padding: EdgeInsets.zero,
              child: list.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: Text('Tidak ada jadwal pelajaran hari ini 🎉', style: TextStyle(color: CupertinoColors.secondaryLabel))),
                    )
                  : Column(
                      children: list.map((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Icon(CupertinoIcons.book_fill, size: 18, color: accent),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.mapel, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                    const SizedBox(height: 2),
                                    Text('${item.jam} • ${item.guru}', style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                                  ],
                                ),
                              ),
                              IosBadge(text: item.ruang, type: IosBadgeType.gray),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),

            if (piket != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('🧹', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    'REGU PIKET HARI ${_selectedDay.toUpperCase()}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              IosCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Petugas Kebersihan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => widget.repo.togglePiket(_selectedDay),
                          child: IosBadge(
                            text: piket.selesai ? 'Sudah Piket ✨' : 'Belum Piket ⏳',
                            type: piket.selesai ? IosBadgeType.green : IosBadgeType.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: piket.anggota.map((nama) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF2C2C2E)
                                : const Color(0xFFF2F2F7),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('👤', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 4),
                              Text(nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
