import 'package:flutter/cupertino.dart';
import '../data/kelas_repository.dart';

class ModalGuruLogin extends StatefulWidget {
  final KelasRepository repo;

  const ModalGuruLogin({super.key, required this.repo});

  @override
  State<ModalGuruLogin> createState() => _ModalGuruLoginState();
}

class _ModalGuruLoginState extends State<ModalGuruLogin> {
  final _namaController = TextEditingController(text: 'Dra. Hj. Nurjanah, M.Pd.');
  final _mapelController = TextEditingController(text: 'Wali Kelas 8A');
  final _pinController = TextEditingController(text: '1234');
  String? _errorMsg;

  final List<Map<String, String>> _daftarGuru = [
    {'nama': 'Dra. Hj. Nurjanah, M.Pd.', 'mapel': 'Wali Kelas & Guru BK'},
    {'nama': 'Budi Santoso, S.Pd.', 'mapel': 'Guru Matematika'},
    {'nama': 'Siti Aminah, M.Pd.', 'mapel': 'Guru Bahasa Indonesia'},
    {'nama': 'Rahmat Hidayat, M.Si.', 'mapel': 'Guru IPA Terpadu'},
    {'nama': 'Ustadz Ahmad Fauzan, S.Ag.', 'mapel': 'Guru PAI'},
    {'nama': 'Dewi Lestari, S.Pd.', 'mapel': 'Guru Bahasa Inggris'},
    {'nama': 'Hendra Setiawan, S.Pd.', 'mapel': 'Guru PJOK (Olahraga)'},
    {'nama': 'Fajar Nugraha, S.Kom.', 'mapel': 'Guru Informatika'},
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _mapelController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    final nama = _namaController.text.trim();
    final mapel = _mapelController.text.trim();
    final pin = _pinController.text.trim();

    if (nama.isEmpty) {
      setState(() => _errorMsg = 'Nama guru tidak boleh kosong');
      return;
    }

    final success = widget.repo.loginGuru(nama, mapel, pin);
    if (success) {
      Navigator.of(context).pop();
    } else {
      setState(() => _errorMsg = 'PIN salah. Gunakan PIN: 1234 atau 8888');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final accent = widget.repo.accentColor;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 38,
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
                Row(
                  children: [
                    Text('👨‍🏫', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    const Text(
                      'Login Guru & Wali Kelas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.clear_circled_solid, color: CupertinoColors.systemGrey2),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Quick select preset guru
            const Text(
              'PILIH GURU / WALI KELAS',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _daftarGuru.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, idx) {
                  final g = _daftarGuru[idx];
                  final isSelected = _namaController.text == g['nama'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _namaController.text = g['nama']!;
                        _mapelController.text = g['mapel']!;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? accent : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        g['nama']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? CupertinoColors.white : CupertinoColors.label,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            const Text(
              'NAMA LENGKAP & GELAR',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _namaController,
              placeholder: 'Nama Guru / Wali Kelas',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 14),

            const Text(
              'JABATAN / MATA PELAJARAN',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _mapelController,
              placeholder: 'Contoh: Wali Kelas 8A / Guru Matematika',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 14),

            const Text(
              'PIN KEAMANAN GURU',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 6),
            CupertinoTextField(
              controller: _pinController,
              placeholder: 'Masukkan PIN (Default: 1234 atau 8888)',
              obscureText: true,
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            if (_errorMsg != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMsg!,
                style: const TextStyle(color: CupertinoColors.systemRed, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],

            const SizedBox(height: 22),
            CupertinoButton(
              color: accent,
              borderRadius: BorderRadius.circular(14),
              onPressed: _submit,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.lock_shield_fill, color: CupertinoColors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Masuk Sebagai Guru',
                    style: TextStyle(fontWeight: FontWeight.w700, color: CupertinoColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
