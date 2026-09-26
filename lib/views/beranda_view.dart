import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/ios_badge.dart';

class BerandaView extends StatelessWidget {
  final KelasRepository repo;
  final Function(int) onNavigateTab;

  const BerandaView({
    super.key,
    required this.repo,
    required this.onNavigateTab,
  });

  String _getHariIniKey() {
    final weekday = DateTime.now().weekday;
    switch (weekday) {
      case DateTime.monday: return 'senin';
      case DateTime.tuesday: return 'selasa';
      case DateTime.wednesday: return 'rabu';
      case DateTime.thursday: return 'kamis';
      case DateTime.friday: return 'jumat';
      case DateTime.saturday: return 'sabtu';
      default: return 'senin';
    }
  }

  String _formatRupiah(int val) {
    final f = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return f.format(val);
  }

  @override
  Widget build(BuildContext context) {
    final todayKey = _getHariIniKey();
    final jadwalToday = repo.jadwalMap[todayKey] ?? [];
    final piketToday = repo.piketMap[todayKey];
    final activeTugas = repo.tugasList.where((t) => !t.selesai).toList();
    final rekap = repo.getRekapAbsensi();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Kelas 8A'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            // iOS Large Title Header
            Text(
              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now()).toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.secondaryLabel,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Ringkasan Kelas 8A',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 16),

            // Top Stat Cards (Grid of 2)
            Row(
              children: [
                Expanded(
                  child: IosCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () => onNavigateTab(3), // Kas tab
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Saldo Kas', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel, fontWeight: FontWeight.w500)),
                            Icon(CupertinoIcons.money_dollar_circle_fill, size: 20, color: CupertinoColors.activeBlue),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatRupiah(repo.saldoKas),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: CupertinoColors.activeBlue),
                        ),
                        const SizedBox(height: 4),
                        const Text('Ketuk untuk detail', style: TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: IosCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () => onNavigateTab(4), // Info/Siswa tab
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Kehadiran', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel, fontWeight: FontWeight.w500)),
                            Icon(CupertinoIcons.person_2_fill, size: 20, color: CupertinoColors.systemGreen),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${rekap['Hadir']} / ${repo.siswaList.length}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: CupertinoColors.systemGreen),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sakit: ${rekap['Sakit']} • Izin: ${rekap['Izin']}',
                          style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Widget Jadwal Hari Ini
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('JADWAL HARI INI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onNavigateTab(1),
                  child: const Text('Semua', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            IosCard(
              padding: EdgeInsets.zero,
              child: jadwalToday.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: Text('Tidak ada pelajaran hari ini', style: TextStyle(color: CupertinoColors.secondaryLabel))),
                    )
                  : Column(
                      children: jadwalToday.take(4).map((j) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.activeBlue.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(CupertinoIcons.book_fill, size: 16, color: CupertinoColors.activeBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(j.mapel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                    const SizedBox(height: 2),
                                    Text('${j.jam} • ${j.guru}', style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
                                  ],
                                ),
                              ),
                              IosBadge(text: j.ruang, type: IosBadgeType.gray),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),

            // Widget Piket Kebersihan
            const SizedBox(height: 10),
            const Text('PIKET KEBERSIHAN HARI INI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            if (piketToday != null)
              IosCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(CupertinoIcons.sparkles, size: 18, color: Color(0xFF5856D6)),
                            const SizedBox(width: 6),
                            Text(
                              'Hari ${todayKey.toUpperCase()}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => repo.togglePiket(todayKey),
                          child: IosBadge(
                            text: piketToday.selesai ? 'Sudah Piket' : 'Belum Piket',
                            type: piketToday.selesai ? IosBadgeType.green : IosBadgeType.orange,
                            icon: piketToday.selesai ? CupertinoIcons.check_mark : CupertinoIcons.clock,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: piketToday.anggota.map((nama) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF2C2C2E)
                                : const Color(0xFFF2F2F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Widget Tugas Terdekat
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TUGAS & PR TERDEKAT', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onNavigateTab(2),
                  child: const Text('Kelola', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            IosCard(
              padding: EdgeInsets.zero,
              child: activeTugas.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: Text('Semua tugas telah diselesaikan', style: TextStyle(color: CupertinoColors.secondaryLabel))),
                    )
                  : Column(
                      children: activeTugas.take(3).map((t) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                          ),
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => repo.toggleTugas(t.id),
                                child: const Icon(CupertinoIcons.circle, size: 20, color: CupertinoColors.systemGrey3),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(t.judul, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${t.mapel} • Deadline: ${DateFormat('dd MMM').format(t.deadline)}',
                                      style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                                    ),
                                  ],
                                ),
                              ),
                              IosBadge(
                                text: t.prioritas,
                                type: t.prioritas == 'Tinggi' ? IosBadgeType.red : IosBadgeType.blue,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),

            // Pengumuman Wali Kelas
            const SizedBox(height: 10),
            const Text('PENGUMUMAN WALI KELAS', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            ...repo.pengumumanList.map((p) {
              return IosCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(CupertinoIcons.bell_fill, size: 16, color: CupertinoColors.activeBlue),
                            const SizedBox(width: 6),
                            Text(p.judul, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          ],
                        ),
                        Text(
                          DateFormat('dd MMM').format(p.tanggal),
                          style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      p.isi,
                      style: const TextStyle(fontSize: 13, height: 1.4, color: CupertinoColors.label),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
