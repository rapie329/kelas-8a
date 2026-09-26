import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/siswa.dart';
import '../models/jadwal.dart';
import '../models/tugas.dart';
import '../models/kas.dart';
import '../models/struktur.dart';
import '../models/pengumuman.dart';
import 'default_data.dart';

class KelasRepository extends ChangeNotifier {
  static const String _keyStorage = 'kelas_8a_flutter_data_v1';
  static const String _keyTheme = 'kelas_8a_flutter_theme';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

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

  KelasRepository() {
    _initData();
  }

  Future<void> _initData() async {
    _loadDefault();
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool(_keyTheme) ?? false;
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
      await prefs.setBool(_keyTheme, _isDarkMode);
    } catch (e) {
      debugPrint('Error saving preferences: $e');
    }
    notifyListeners();
  }

  void toggleTheme(bool value) {
    _isDarkMode = value;
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

  // Export / Import
  String exportJson() {
    final map = {
      'siswa': _siswaList.map((s) => s.toJson()).toList(),
      'tugas': _tugasList.map((t) => t.toJson()).toList(),
      'kas': _kasList.map((k) => k.toJson()).toList(),
      'piket': _piketMap.map((k, v) => MapEntry(k, v.toJson())),
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
  }

  void resetToDefault() {
    _loadDefault();
    save();
  }
}
