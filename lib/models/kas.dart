class TransaksiKas {
  final String id;
  final DateTime tanggal;
  final String tipe; // 'masuk' atau 'keluar'
  final String kategori;
  final int nominal;
  final String keterangan;

  TransaksiKas({
    required this.id,
    required this.tanggal,
    required this.tipe,
    required this.kategori,
    required this.nominal,
    required this.keterangan,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'tanggal': tanggal.toIso8601String(),
    'tipe': tipe,
    'kategori': kategori,
    'nominal': nominal,
    'keterangan': keterangan,
  };

  factory TransaksiKas.fromJson(Map<String, dynamic> json) => TransaksiKas(
    id: json['id'] as String,
    tanggal: DateTime.parse(json['tanggal'] as String),
    tipe: json['tipe'] as String,
    kategori: json['kategori'] as String,
    nominal: json['nominal'] as int,
    keterangan: json['keterangan'] as String,
  );
}
