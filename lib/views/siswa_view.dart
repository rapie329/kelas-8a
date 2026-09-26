import 'package:flutter/cupertino.dart';
import '../data/kelas_repository.dart';
import '../widgets/ios_card.dart';
import '../widgets/ios_badge.dart';
import '../widgets/modal_guru_login.dart';

class SiswaView extends StatefulWidget {
  final KelasRepository repo;

  const SiswaView({super.key, required this.repo});

  @override
  State<SiswaView> createState() => _SiswaViewState();
}

class _SiswaViewState extends State<SiswaView> {
  String _subView = 'absen';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _bukaModalLoginGuru() {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalGuruLogin(repo: widget.repo),
    );
  }

  void _konfirmasiReset() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Reset Data Kelas'),
        content: const Text('Apakah Anda yakin ingin mengembalikan seluruh data ke pengaturan awal Kelas 8A?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Reset'),
            onPressed: () {
              widget.repo.resetToDefault();
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
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final rekap = widget.repo.getRekapAbsensi();
    final allSiswa = widget.repo.siswaList;
    final filteredSiswa = _searchQuery.trim().isEmpty
        ? allSiswa
        : allSiswa.where((s) {
            final q = _searchQuery.toLowerCase();
            return s.nama.toLowerCase().contains(q) || s.no.toString().contains(q);
          }).toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.repo.themeEmoji} Data Kelas 8A'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            const Text(
              'INFORMASI & ADMINISTRASI',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel, letterSpacing: 0.6),
            ),
            const SizedBox(height: 2),
            const Text(
              'Kelas 8A 👥',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
            ),
            const SizedBox(height: 14),

            // Subview Segmented Switcher
            Center(
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _subView,
                  children: const {
                    'absen': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Absensi (32) 📋')),
                    'struktur': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Struktur 🏛️')),
                    'pengaturan': Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Pengaturan ⚙️')),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _subView = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            // SUBVIEW 1: ABSENSI & SISWA
            if (_subView == 'absen') ...[
              // Summary 4 Badges Card
              IosCard(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const IosBadge(text: 'Hadir ✨', type: IosBadgeType.green),
                        const SizedBox(height: 4),
                        Text('${rekap['Hadir']}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.systemGreen)),
                      ],
                    ),
                    Column(
                      children: [
                        const IosBadge(text: 'Sakit 🏥', type: IosBadgeType.red),
                        const SizedBox(height: 4),
                        Text('${rekap['Sakit']}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.systemRed)),
                      ],
                    ),
                    Column(
                      children: [
                        const IosBadge(text: 'Izin ✉️', type: IosBadgeType.orange),
                        const SizedBox(height: 4),
                        Text('${rekap['Izin']}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.systemOrange)),
                      ],
                    ),
                    Column(
                      children: [
                        const IosBadge(text: 'Alpa ❌', type: IosBadgeType.gray),
                        const SizedBox(height: 4),
                        Text('${rekap['Alpa']}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Search Box
              CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Cari nama atau nomor absen...',
                onChanged: (val) {
                  setState(() => _searchQuery = val);
                },
              ),
              const SizedBox(height: 14),

              IosCard(
                padding: EdgeInsets.zero,
                child: filteredSiswa.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: Text('Siswa tidak ditemukan 🔍', style: TextStyle(color: CupertinoColors.secondaryLabel))),
                      )
                    : Column(
                        children: filteredSiswa.map((s) {
                          final status = s.status;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0x1F8E8E93), width: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey4.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${s.no}',
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              s.nama,
                                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (s.jabatan != null) ...[
                                            const SizedBox(width: 6),
                                            IosBadge(text: s.jabatan!, type: IosBadgeType.blue),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${s.gender == 'L' ? 'Laki-laki 👦' : 'Perempuan 👧'} • NISN: ${s.nisn}',
                                        style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                // Quick Status Chips: H / S / I / A
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildStatusButton(s.no, 'H', status == 'Hadir', CupertinoColors.systemGreen),
                                    const SizedBox(width: 3),
                                    _buildStatusButton(s.no, 'S', status == 'Sakit', CupertinoColors.systemRed),
                                    const SizedBox(width: 3),
                                    _buildStatusButton(s.no, 'I', status == 'Izin', CupertinoColors.systemOrange),
                                    const SizedBox(width: 3),
                                    _buildStatusButton(s.no, 'A', status == 'Alpa', CupertinoColors.secondaryLabel),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],

            // SUBVIEW 2: STRUKTUR ORGANISASI
            if (_subView == 'struktur') ...[
              const Text('DEWAN PENGURUS KELAS', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 8),
              IosCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: widget.repo.strukturList.map((item) {
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
                              color: const Color(0xFF5856D6).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text('🎓', style: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.nama, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.jabatan}${item.sub != null ? ' • ${item.sub}' : ''}',
                                  style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                                ),
                              ],
                            ),
                          ),
                          IosBadge(text: item.kontak, type: IosBadgeType.gray),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // SUBVIEW 3: PENGATURAN & TEMA
            if (_subView == 'pengaturan') ...[
              // Mode Guru Section
              const Text('STATUS SESI PENGGUNA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 8),
              IosCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: (widget.repo.isGuruLoggedIn ? CupertinoColors.systemGreen : accent).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text('👨‍🏫', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.repo.isGuruLoggedIn ? 'Mode Guru Aktif 👨‍🏫' : 'Mode Siswa & Umum 👤',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.repo.isGuruLoggedIn ? widget.repo.namaGuru : 'Login untuk hak akses wali kelas',
                            style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      color: widget.repo.isGuruLoggedIn ? CupertinoColors.systemRed : accent,
                      borderRadius: BorderRadius.circular(10),
                      onPressed: () {
                        if (widget.repo.isGuruLoggedIn) {
                          widget.repo.logoutGuru();
                        } else {
                          _bukaModalLoginGuru();
                        }
                      },
                      child: Text(
                        widget.repo.isGuruLoggedIn ? 'Keluar' : 'Login Guru',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CupertinoColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Theme Selector
              const Text('TEMA WARNA APLIKASI (IOS ACCENT)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 8),
              IosCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tema Saat Ini: ${widget.repo.themeEmoji} ${widget.repo.themeName}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildThemeSelectBtn('laut', '🌊 Tema Laut (Ocean Blue)', const Color(0xFF0096C7)),
                        _buildThemeSelectBtn('biru', '🔵 Biru Klasik iOS', const Color(0xFF007AFF)),
                        _buildThemeSelectBtn('merah', '🔴 Merah Ruby', const Color(0xFFFF2D55)),
                        _buildThemeSelectBtn('pink', '🌸 Sakura Pink', const Color(0xFFFF2D92)),
                        _buildThemeSelectBtn('ungu', '💜 Lavender Ungu', const Color(0xFF5856D6)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Dark Mode
              const Text('TAMPILAN CAHAYA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 8),
              IosCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mode Gelap (Dark Mode)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        SizedBox(height: 2),
                        Text('Apple iOS Night OLED Black', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                    CupertinoSwitch(
                      activeColor: accent,
                      value: widget.repo.isDarkMode,
                      onChanged: (val) {
                        widget.repo.toggleTheme(val);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Reset Data
              const Text('PEMELIHARAAN DATA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 8),
              IosCard(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(CupertinoIcons.trash_fill, size: 16, color: CupertinoColors.systemRed),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reset ke Data Awal', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: CupertinoColors.systemRed)),
                            SizedBox(height: 2),
                            Text('Kembalikan ke data bawaan Kelas 8A', style: TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _konfirmasiReset,
                        child: const Icon(CupertinoIcons.chevron_forward, size: 16, color: CupertinoColors.secondaryLabel),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // About Card
              IosCard(
                padding: const EdgeInsets.all(18),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: widget.repo.themeGradient,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text('8A', style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w900, fontSize: 24)),
                      ),
                      const SizedBox(height: 10),
                      Text('Kelas 8A - iOS 26/27 Edition ${widget.repo.themeEmoji}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 4),
                      const Text('Versi 1.0.2 (Build Rilis Resmi)', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      const SizedBox(height: 4),
                      const Text('SMP Negeri Unggulan • 2024 / 2025', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelectBtn(String code, String label, Color color) {
    final isSelected = widget.repo.themeCode == code;
    return GestureDetector(
      onTap: () => widget.repo.setThemeCode(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? color : color.withOpacity(0.3), width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? CupertinoColors.white : color,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(int noAbsen, String label, bool isSelected, Color activeColor) {
    return GestureDetector(
      onTap: () {
        final Map<String, String> mapLabel = {
          'H': 'Hadir',
          'S': 'Sakit',
          'I': 'Izin',
          'A': 'Alpa',
        };
        widget.repo.setSiswaStatus(noAbsen, mapLabel[label]!);
      },
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : CupertinoColors.systemGrey5.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: isSelected ? CupertinoColors.white : CupertinoColors.secondaryLabel,
          ),
        ),
      ),
    );
  }
}
