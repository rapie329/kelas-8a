class PengurusStruktur {
  final String jabatan;
  final String nama;
  final String kontak;
  final String? sub;

  PengurusStruktur({
    required this.jabatan,
    required this.nama,
    required this.kontak,
    this.sub,
  });

  Map<String, dynamic> toJson() => {
    'jabatan': jabatan,
    'nama': nama,
    'kontak': kontak,
    'sub': sub,
  };

  factory PengurusStruktur.fromJson(Map<String, dynamic> json) => PengurusStruktur(
    jabatan: json['jabatan'] as String,
    nama: json['nama'] as String,
    kontak: json['kontak'] as String,
    sub: json['sub'] as String?,
  );
}

class PiketHarian {
  final List<String> anggota;
  bool selesai;

  PiketHarian({
    required this.anggota,
    this.selesai = false,
  });

  Map<String, dynamic> toJson() => {
    'anggota': anggota,
    'selesai': selesai,
  };

  factory PiketHarian.fromJson(Map<String, dynamic> json) => PiketHarian(
    anggota: List<String>.from(json['anggota'] as List),
    selesai: (json['selesai'] as bool?) ?? false,
  );
}
