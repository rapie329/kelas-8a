class Pengumuman {
  final String id;
  final DateTime tanggal;
  final String judul;
  final String isi;

  Pengumuman({
    required this.id,
    required this.tanggal,
    required this.judul,
    required this.isi,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'tanggal': tanggal.toIso8601String(),
    'judul': judul,
    'isi': isi,
  };

  factory Pengumuman.fromJson(Map<String, dynamic> json) => Pengumuman(
    id: json['id'] as String,
    tanggal: DateTime.parse(json['tanggal'] as String),
    judul: json['judul'] as String,
    isi: json['isi'] as String,
  );
}
