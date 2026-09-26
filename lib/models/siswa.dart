class Siswa {
  final int no;
  final String nisn;
  final String nama;
  final String gender;
  final String? jabatan;
  String status;

  Siswa({
    required this.no,
    required this.nisn,
    required this.nama,
    required this.gender,
    this.jabatan,
    this.status = 'Hadir',
  });

  Map<String, dynamic> toJson() => {
    'no': no,
    'nisn': nisn,
    'nama': nama,
    'gender': gender,
    'jabatan': jabatan,
    'status': status,
  };

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
    no: json['no'] as int,
    nisn: json['nisn'] as String,
    nama: json['nama'] as String,
    gender: json['gender'] as String,
    jabatan: json['jabatan'] as String?,
    status: (json['status'] as String?) ?? 'Hadir',
  );
}
