import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/ios_badge.dart';
import '../widgets/modal_guru_login.dart';

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

  void _bukaModalLoginGuru(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalGuruLogin(repo: repo),
    );
  }

  void _konfirmasiLogoutGuru(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Keluar Mode Guru'),
        content: const Text('Apakah Anda ingin keluar dari sesi Guru & Wali Kelas?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Keluar'),
            onPressed: () {
              repo.logoutGuru();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final accent = repo.accentColor;
    final todayKey = _getHariIniKey();
    final jadwalToday = repo.jadwalMap[todayKey] ?? [];
    final piketToday = repo.piketMap[todayKey];
    final activeTugas = repo.tugasList.where((t) => !t.selesai).toList();
    final rekap = repo.getRekapAbsensi();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${repo.themeEmoji} Kelas 8A'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _bukaModalLoginGuru(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                repo.isGuruLoggedIn ? '👨‍🏫 Guru' : '🔑 Login',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: repo.isGuruLoggedIn ? CupertinoColors.systemGreen : accent,
                ),
              ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            // Dynamic Island Capsule (iOS 26/27 Signature)
            Container(
              margin: const EdgeInsets.only(bottom: 14.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.black,
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: accent.withOpacity(0.6), blurRadius: 6, spreadRadius: 1),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      jadwalToday.isNotEmpty
                          ? 'Aktif: ${jadwalToday.first.mapel} (${jadwalToday.first.jam})'
                          : 'Kelas 8A • SMP Negeri Unggulan',
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${repo.themeEmoji} 8A',
                      style: const TextStyle(color: CupertinoColors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now()).toUpperCase(),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel, letterSpacing: 0.6),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Portal Kelas 8A',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Theme Switcher Quick Bar (Laut, Biru, Merah, Pink, Ungu)
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildThemeChip('laut', '🌊 Tema Laut', const Color(0xFF0096C7)),
                  const SizedBox(width: 8),
                  _buildThemeChip('biru', '🔵 Biru iOS', const Color(0xFF007AFF)),
                  const SizedBox(width: 8),
                  _buildThemeChip('merah', '🔴 Merah Ruby', const Color(0xFFFF2D55)),
                  const SizedBox(width: 8),
                  _buildThemeChip('pink', '🌸 Sakura Pink', const Color(0xFFFF2D92)),
                  const SizedBox(width: 8),
                  _buildThemeChip('ungu', '💜 Lavender', const Color(0xFF5856D6)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 1. BANNER LOGIN GURU / WALI KELAS
            IosCard(
              padding: const EdgeInsets.all(16),
              gradient: repo.isGuruLoggedIn
                  ? LinearGradient(
                      colors: [
                        CupertinoColors.systemGreen.withOpacity(0.15),
                        accent.withOpacity(0.1),
                      ],
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (repo.isGuruLoggedIn ? CupertinoColors.systemGreen : accent).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text('👨‍🏫', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  repo.isGuruLoggedIn ? 'Guru Terverifikasi' : 'Mode Guru & Wali Kelas',
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                                ),
                                if (repo.isGuruLoggedIn) ...[
                                  const SizedBox(width: 6),
                                  const Icon(CupertinoIcons.checkmark_seal_fill, size: 16, color: CupertinoColors.systemGreen),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              repo.isGuruLoggedIn
                                  ? '${repo.namaGuru} (${repo.mapelGuru})'
                                  : 'Masuk untuk validasi piket & pantau absensi kelas',
                              style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (!repo.isGuruLoggedIn)
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: accent,
                            borderRadius: BorderRadius.circular(12),
                            onPressed: () => _bukaModalLoginGuru(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.person_badge_plus_fill, size: 16, color: CupertinoColors.white),
                                SizedBox(width: 6),
                                Text('Login Guru / Wali Kelas', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.white)),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: CupertinoColors.systemGreen.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                            onPressed: () => onNavigateTab(4), // ke tab absensi
                            child: const Text('Kelola Absensi Siswa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.systemGreen)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          color: CupertinoColors.systemRed.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          onPressed: () => _konfirmasiLogoutGuru(context),
                          child: const Text('Keluar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.systemRed)),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // 2. JADWAL PELAJARAN HARI INI
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('📚', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      'JADWAL HARI INI (${todayKey.toUpperCase()})',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onNavigateTab(1),
                  child: Text('Lihat Semua', style: TextStyle(fontSize: 13, color: accent, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            IosCard(
              padding: EdgeInsets.zero,
              child: jadwalToday.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: Text('Libur atau tidak ada jadwal mapel hari ini 🎉', style: TextStyle(color: CupertinoColors.secondaryLabel))),
                    )
                  : Column(
                      children: jadwalToday.map((j) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                    Text(j.mapel, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                    const SizedBox(height: 2),
                                    Text('${j.jam} • ${j.guru}', style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
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
            const SizedBox(height: 14),

            // 3. PIKET KEBERSIHAN HARI INI
            Row(
              children: [
                const Text('🧹', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  'PIKET KEBERSIHAN (${todayKey.toUpperCase()})',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (piketToday != null)
              IosCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Petugas Bertugas Hari Ini', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => repo.togglePiket(todayKey),
                          child: IosBadge(
                            text: piketToday.selesai ? 'Sudah Piket ✨' : 'Belum Piket ⏳',
                            type: piketToday.selesai ? IosBadgeType.green : IosBadgeType.orange,
                            icon: piketToday.selesai ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.clock_fill,
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
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
            const SizedBox(height: 14),

            // 4. KAS & ABSENSI GRID
            Row(
              children: [
                Expanded(
                  child: IosCard(
                    padding: const EdgeInsets.all(16),
                    onTap: () => onNavigateTab(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('💰 Kas 8A', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
                            Icon(CupertinoIcons.chevron_forward, size: 14, color: CupertinoColors.secondaryLabel),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatRupiah(repo.saldoKas),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: accent),
                        ),
                        const SizedBox(height: 4),
                        const Text('Ketuk detail transaksi', style: TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: IosCard(
                    padding: const EdgeInsets.all(16),
                    onTap: () => onNavigateTab(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('📊 Absensi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel)),
                            Icon(CupertinoIcons.chevron_forward, size: 14, color: CupertinoColors.secondaryLabel),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${rekap['Hadir']} / ${repo.siswaList.length} Hadir',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CupertinoColors.systemGreen),
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
            const SizedBox(height: 14),

            // 5. TUGAS & PR TERDEKAT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('📝', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 6),
                    Text('TUGAS & PR AKTIF', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
                  ],
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onNavigateTab(2),
                  child: Text('Semua', style: TextStyle(fontSize: 13, color: accent, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            IosCard(
              padding: EdgeInsets.zero,
              child: activeTugas.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(22.0),
                      child: Center(child: Text('Semua PR telah tuntas dikerjakan! 🎉', style: TextStyle(color: CupertinoColors.secondaryLabel))),
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
                                    Text(t.judul, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                    const SizedBox(height: 2),
                                    Text('${t.mapel} • Deadline: ${DateFormat('dd MMM').format(t.deadline)}', style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeChip(String code, String label, Color dotColor) {
    final isSelected = repo.themeCode == code;
    return GestureDetector(
      onTap: () => repo.setThemeCode(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? dotColor : dotColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isSelected ? dotColor : dotColor.withOpacity(0.3), width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? CupertinoColors.white : dotColor,
          ),
        ),
      ),
    );
  }
}
