class JadwalMapel {
  final String jam;
  final String mapel;
  final String guru;
  final String ruang;

  JadwalMapel({
    required this.jam,
    required this.mapel,
    required this.guru,
    required this.ruang,
  });

  Map<String, dynamic> toJson() => {
    'jam': jam,
    'mapel': mapel,
    'guru': guru,
    'ruang': ruang,
  };

  factory JadwalMapel.fromJson(Map<String, dynamic> json) => JadwalMapel(
    jam: json['jam'] as String,
    mapel: json['mapel'] as String,
    guru: json['guru'] as String,
    ruang: json['ruang'] as String,
  );
}
