import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/siswa.dart';
import '../models/jadwal.dart';
import '../models/tugas.dart';
import '../models/kas.dart';
import '../models/struktur.dart';
import '../models/pengumuman.dart';
import 'default_data.dart';

class KelasRepository extends ChangeNotifier {
  static const String _keyStorage = 'kelas_8a_flutter_data_v2';
  static const String _keyThemeMode = 'kelas_8a_theme_mode';
  static const String _keyThemeCode = 'kelas_8a_theme_code';
  static const String _keyGuruStatus = 'kelas_8a_guru_status';
  static const String _keyGuruNama = 'kelas_8a_guru_nama';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _themeCode = 'laut'; // 'laut', 'biru', 'merah', 'pink', 'ungu'
  String get themeCode => _themeCode;

  // Guru / Wali Kelas Auth State
  bool _isGuruLoggedIn = false;
  bool get isGuruLoggedIn => _isGuruLoggedIn;

  String _namaGuru = 'Dra. Hj. Nurjanah, M.Pd.';
  String get namaGuru => _namaGuru;

  String _mapelGuru = 'Wali Kelas & Guru BK';
  String get mapelGuru => _mapelGuru;

  List<Siswa> _siswaList = [];
  Map<String, List<JadwalMapel>> _jadwalMap = {};
  Map<String, PiketHarian> _piketMap = {};
  List<Tugas> _tugasList = [];
  List<TransaksiKas> _kasList = [];
  List<PengurusStruktur> _strukturList = [];
  List<Pengumuman> _pengumumanList = [];

  List<Siswa> get siswaList => _siswaList;
  Map<String, List<JadwalMapel>> get jadwalMap => _jadwalMap;
  Map<String, PiketHarian> get piketMap => _piketMap;
  List<Tugas> get tugasList => _tugasList;
  List<TransaksiKas> get kasList => _kasList;
  List<PengurusStruktur> get strukturList => _strukturList;
  List<Pengumuman> get pengumumanList => _pengumumanList;

  // Dynamic Apple iOS 26/27 Accent Colors
  Color get accentColor {
    switch (_themeCode) {
      case 'laut':
        return const Color(0xFF0096C7); // Deep Ocean Blue
      case 'biru':
        return const Color(0xFF007AFF); // Apple System Blue
      case 'merah':
        return const Color(0xFFFF2D55); // Crimson Ruby
      case 'pink':
        return const Color(0xFFFF2D92); // Sakura Pink
      case 'ungu':
        return const Color(0xFF5856D6); // Royal Purple
      default:
        return const Color(0xFF0096C7);
    }
  }

  Color get secondaryAccentColor {
    switch (_themeCode) {
      case 'laut':
        return const Color(0xFF00B4D8);
      case 'biru':
        return const Color(0xFF5AC8FA);
      case 'merah':
        return const Color(0xFFFF375F);
      case 'pink':
        return const Color(0xFFFF75B6);
      case 'ungu':
        return const Color(0xFFAF52DE);
      default:
        return const Color(0xFF00B4D8);
    }
  }

  LinearGradient get themeGradient {
    return LinearGradient(
      colors: [accentColor, secondaryAccentColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  String get themeEmoji {
    switch (_themeCode) {
      case 'laut': return '🌊';
      case 'biru': return '🔵';
      case 'merah': return '🔴';
      case 'pink': return '🌸';
      case 'ungu': return '💜';
      default: return '🌊';
    }
  }

  String get themeName {
    switch (_themeCode) {
      case 'laut': return 'Ocean Blue';
      case 'biru': return 'Classic Blue';
      case 'merah': return 'Ruby Crimson';
      case 'pink': return 'Sakura Pink';
      case 'ungu': return 'Royal Purple';
      default: return 'Ocean Blue';
    }
  }

  KelasRepository() {
    _initData();
  }

  Future<void> _initData() async {
    _loadDefault();
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool(_keyThemeMode) ?? false;
      _themeCode = prefs.getString(_keyThemeCode) ?? 'laut';
      _isGuruLoggedIn = prefs.getBool(_keyGuruStatus) ?? false;
      _namaGuru = prefs.getString(_keyGuruNama) ?? 'Dra. Hj. Nurjanah, M.Pd.';

      final raw = prefs.getString(_keyStorage);
      if (raw != null) {
        _parseJson(raw);
      }
    } catch (e) {
      debugPrint('Error loading preferences: $e');
    }
    notifyListeners();
  }

  void _loadDefault() {
    _siswaList = DefaultData.getSiswaList();
    _jadwalMap = DefaultData.getJadwalMap();
    _piketMap = DefaultData.getPiketMap();
    _tugasList = DefaultData.getTugasList();
    _kasList = DefaultData.getKasList();
    _strukturList = DefaultData.getStrukturList();
    _pengumumanList = DefaultData.getPengumumanList();
  }

  Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyStorage, exportJson());
      await prefs.setBool(_keyThemeMode, _isDarkMode);
      await prefs.setString(_keyThemeCode, _themeCode);
      await prefs.setBool(_keyGuruStatus, _isGuruLoggedIn);
      await prefs.setString(_keyGuruNama, _namaGuru);
    } catch (e) {
      debugPrint('Error saving preferences: $e');
    }
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    save();
  }

  void setThemeCode(String code) {
    _themeCode = code;
    save();
  }

  // Guru Authentication Flow
  bool loginGuru(String nama, String mapel, String pin) {
    // PIN default guru: 1234 atau 8888 (atau apa saja jika diisi)
    if (pin.trim() == '1234' || pin.trim() == '8888' || pin.trim().isNotEmpty) {
      _isGuruLoggedIn = true;
      _namaGuru = nama.trim().isNotEmpty ? nama.trim() : 'Dra. Hj. Nurjanah, M.Pd.';
      _mapelGuru = mapel.trim().isNotEmpty ? mapel.trim() : 'Wali Kelas 8A';
      save();
      return true;
    }
    return false;
  }

  void logoutGuru() {
    _isGuruLoggedIn = false;
    save();
  }

  // Rekap Absensi
  Map<String, int> getRekapAbsensi() {
    final counts = {'Hadir': 0, 'Sakit': 0, 'Izin': 0, 'Alpa': 0};
    for (final s in _siswaList) {
      if (counts.containsKey(s.status)) {
        counts[s.status] = counts[s.status]! + 1;
      } else {
        counts['Hadir'] = counts['Hadir']! + 1;
      }
    }
    return counts;
  }

  void setSiswaStatus(int noAbsen, String newStatus) {
    final idx = _siswaList.indexWhere((s) => s.no == noAbsen);
    if (idx != -1) {
      _siswaList[idx].status = newStatus;
      save();
    }
  }

  // Rekap Kas
  int get totalPemasukan {
    int total = 0;
    for (final k in _kasList) {
      if (k.tipe == 'masuk') total += k.nominal;
    }
    return total;
  }

  int get totalPengeluaran {
    int total = 0;
    for (final k in _kasList) {
      if (k.tipe == 'keluar') total += k.nominal;
    }
    return total;
  }

  int get saldoKas => totalPemasukan - totalPengeluaran;

  void addKas(TransaksiKas transaksi) {
    _kasList.insert(0, transaksi);
    save();
  }

  void deleteKas(String id) {
    _kasList.removeWhere((k) => k.id == id);
    save();
  }

  // Tugas
  void addTugas(Tugas tugas) {
    _tugasList.insert(0, tugas);
    save();
  }

  void toggleTugas(String id) {
    final idx = _tugasList.indexWhere((t) => t.id == id);
    if (idx != -1) {
      _tugasList[idx].selesai = !_tugasList[idx].selesai;
      save();
    }
  }

  void deleteTugas(String id) {
    _tugasList.removeWhere((t) => t.id == id);
    save();
  }

  // Piket
  void togglePiket(String hari) {
    if (_piketMap.containsKey(hari)) {
      _piketMap[hari]!.selesai = !_piketMap[hari]!.selesai;
      save();
    }
  }

  // Pengumuman
  void addPengumuman(Pengumuman p) {
    _pengumumanList.insert(0, p);
    save();
  }

  // Export / Import
  String exportJson() {
    final map = {
      'siswa': _siswaList.map((s) => s.toJson()).toList(),
      'tugas': _tugasList.map((t) => t.toJson()).toList(),
      'kas': _kasList.map((k) => k.toJson()).toList(),
      'piket': _piketMap.map((k, v) => MapEntry(k, v.toJson())),
      'pengumuman': _pengumumanList.map((p) => p.toJson()).toList(),
    };
    return jsonEncode(map);
  }

  bool importJson(String jsonString) {
    try {
      _parseJson(jsonString);
      save();
      return true;
    } catch (e) {
      debugPrint('Error parsing imported JSON: $e');
      return false;
    }
  }

  void _parseJson(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    if (decoded.containsKey('siswa')) {
      _siswaList = (decoded['siswa'] as List).map((i) => Siswa.fromJson(i as Map<String, dynamic>)).toList();
    }
    if (decoded.containsKey('tugas')) {
      _tugasList = (decoded['tugas'] as List).map((i) => Tugas.fromJson(i as Map<String, dynamic>)).toList();
    }
    if (decoded.containsKey('kas')) {
      _kasList = (decoded['kas'] as List).map((i) => TransaksiKas.fromJson(i as Map<String, dynamic>)).toList();
    }
    if (decoded.containsKey('piket')) {
      final piketRaw = decoded['piket'] as Map<String, dynamic>;
      _piketMap = piketRaw.map((k, v) => MapEntry(k, PiketHarian.fromJson(v as Map<String, dynamic>)));
    }
    if (decoded.containsKey('pengumuman')) {
      _pengumumanList = (decoded['pengumuman'] as List).map((p) => Pengumuman.fromJson(p as Map<String, dynamic>)).toList();
    }
  }

  void resetToDefault() {
    _loadDefault();
    _isGuruLoggedIn = false;
    _themeCode = 'laut';
    save();
  }
}
