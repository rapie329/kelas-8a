class Tugas {
  final String id;
  final String mapel;
  final String judul;
  final String deskripsi;
  final DateTime deadline;
  bool selesai;
  final String prioritas;

  Tugas({
    required this.id,
    required this.mapel,
    required this.judul,
    required this.deskripsi,
    required this.deadline,
    this.selesai = false,
    this.prioritas = 'Sedang',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'mapel': mapel,
    'judul': judul,
    'deskripsi': deskripsi,
    'deadline': deadline.toIso8601String(),
    'selesai': selesai,
    'prioritas': prioritas,
  };

  factory Tugas.fromJson(Map<String, dynamic> json) => Tugas(
    id: json['id'] as String,
    mapel: json['mapel'] as String,
    judul: json['judul'] as String,
    deskripsi: (json['deskripsi'] as String?) ?? '',
    deadline: DateTime.parse(json['deadline'] as String),
    selesai: (json['selesai'] as bool?) ?? false,
    prioritas: (json['prioritas'] as String?) ?? 'Sedang',
  );
}
