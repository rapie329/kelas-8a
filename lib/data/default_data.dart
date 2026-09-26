import '../models/siswa.dart';
import '../models/jadwal.dart';
import '../models/tugas.dart';
import '../models/kas.dart';
import '../models/struktur.dart';
import '../models/pengumuman.dart';

class DefaultData {
  static List<Siswa> getSiswaList() => [
    Siswa(no: 1, nisn: '009812001', nama: 'Aditya Pratama', gender: 'L'),
    Siswa(no: 2, nisn: '009812002', nama: 'Ahmad Faiz Mubarok', gender: 'L'),
    Siswa(no: 3, nisn: '009812003', nama: 'Aisyah Putri Azzahra', gender: 'P', jabatan: 'Wakil Ketua'),
    Siswa(no: 4, nisn: '009812004', nama: 'Alifia Nurul Hidayah', gender: 'P'),
    Siswa(no: 5, nisn: '009812005', nama: 'Ananda Bagus Perkasa', gender: 'L'),
    Siswa(no: 6, nisn: '009812006', nama: 'Annisa Dwi Lestari', gender: 'P'),
    Siswa(no: 7, nisn: '009812007', nama: 'Bagas Satria Pratama', gender: 'L', jabatan: 'Sie Keamanan'),
    Siswa(no: 8, nisn: '009812008', nama: 'Bintang Ramadhan', gender: 'L'),
    Siswa(no: 9, nisn: '009812009', nama: 'Cantika Maharani', gender: 'P', status: 'Izin'),
    Siswa(no: 10, nisn: '009812010', nama: 'Daffa Raihan Alfarizi', gender: 'L'),
    Siswa(no: 11, nisn: '009812011', nama: 'Dimas Aditya Nugraha', gender: 'L', jabatan: 'Sie Kebersihan'),
    Siswa(no: 12, nisn: '009812012', nama: 'Fathir Danendra Putra', gender: 'L', jabatan: 'Bendahara 1'),
    Siswa(no: 13, nisn: '009812013', nama: 'Farhan Dwi Cahyo', gender: 'L', jabatan: 'Sie Keagamaan'),
    Siswa(no: 14, nisn: '009812014', nama: 'Genta Arya Kusuma', gender: 'L', jabatan: 'Sie Perlengkapan'),
    Siswa(no: 15, nisn: '009812015', nama: 'Hafizah Syakira', gender: 'P'),
    Siswa(no: 16, nisn: '009812016', nama: 'Intan Permata Sari', gender: 'P', status: 'Sakit'),
    Siswa(no: 17, nisn: '009812017', nama: 'Kaisar Rayhan', gender: 'L'),
    Siswa(no: 18, nisn: '009812018', nama: 'Keisha Amanda Putri', gender: 'P', jabatan: 'Bendahara 2'),
    Siswa(no: 19, nisn: '009812019', nama: 'Latifah Nur Rahma', gender: 'P'),
    Siswa(no: 20, nisn: '009812020', nama: 'Mahesa Danu Saputra', gender: 'L'),
    Siswa(no: 21, nisn: '009812021', nama: 'Muhammad Rizky Pratama', gender: 'L', jabatan: 'Ketua Kelas'),
    Siswa(no: 22, nisn: '009812022', nama: 'Mutiara Cinta Kasih', gender: 'P'),
    Siswa(no: 23, nisn: '009812023', nama: 'Nadhif Arya Putra', gender: 'L'),
    Siswa(no: 24, nisn: '009812024', nama: 'Nabila Syifa Wardhani', gender: 'P', jabatan: 'Sekretaris 1'),
    Siswa(no: 25, nisn: '009812025', nama: 'Putra Bayu Samudra', gender: 'L'),
    Siswa(no: 26, nisn: '009812026', nama: 'Rafi Ahmad Fauzi', gender: 'L', jabatan: 'Sie Olahraga'),
    Siswa(no: 27, nisn: '009812027', nama: 'Rania Salma Humaira', gender: 'P'),
    Siswa(no: 28, nisn: '009812028', nama: 'Satria Dewa Bramantyo', gender: 'L'),
    Siswa(no: 29, nisn: '009812029', nama: 'Syahla Kamila', gender: 'P'),
    Siswa(no: 30, nisn: '009812030', nama: 'Taufiq Hidayatulloh', gender: 'L'),
    Siswa(no: 31, nisn: '009812031', nama: 'Vina Aulia Rahma', gender: 'P'),
    Siswa(no: 32, nisn: '009812032', nama: 'Zahra Amalia Ramadhani', gender: 'P', jabatan: 'Sekretaris 2'),
  ];

  static Map<String, List<JadwalMapel>> getJadwalMap() => {
    'senin': [
      JadwalMapel(jam: '07.00 - 07.45', mapel: 'Upacara Bendera', guru: 'Seluruh Dewan Guru', ruang: 'Lapangan Utama'),
      JadwalMapel(jam: '07.45 - 09.05', mapel: 'Matematika', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '09.05 - 09.25', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin'),
      JadwalMapel(jam: '09.25 - 10.45', mapel: 'Bahasa Indonesia', guru: 'Siti Aminah, M.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '10.45 - 12.05', mapel: 'IPA Terpadu (Fisika)', guru: 'Rahmat Hidayat, M.Si.', ruang: 'Lab IPA'),
      JadwalMapel(jam: '12.05 - 12.45', mapel: 'Istirahat & Sholat', guru: '-', ruang: 'Masjid Sekolah'),
      JadwalMapel(jam: '12.45 - 14.05', mapel: 'Pendidikan Agama Islam', guru: 'Ustadz Ahmad Fauzan', ruang: 'Ruang 8A'),
    ],
    'selasa': [
      JadwalMapel(jam: '07.00 - 08.20', mapel: 'PJOK (Olahraga)', guru: 'Hendra Setiawan, S.Pd.', ruang: 'Lapangan Olahraga'),
      JadwalMapel(jam: '08.20 - 09.40', mapel: 'Bahasa Inggris', guru: 'Dewi Lestari, S.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin'),
      JadwalMapel(jam: '10.00 - 11.20', mapel: 'Informatika', guru: 'Fajar Nugraha, S.Kom.', ruang: 'Lab Komputer 2'),
      JadwalMapel(jam: '11.20 - 12.40', mapel: 'PPKn', guru: 'Drs. Supardi', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '12.40 - 13.20', mapel: 'Istirahat & Sholat', guru: '-', ruang: 'Masjid Sekolah'),
      JadwalMapel(jam: '13.20 - 14.40', mapel: 'Prakarya', guru: 'Endang Sulastri, S.Pd.', ruang: 'Ruang Kesenian'),
    ],
    'rabu': [
      JadwalMapel(jam: '07.00 - 08.20', mapel: 'IPA Terpadu (Biologi)', guru: 'Nurul Hasanah, S.Si.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '08.20 - 09.40', mapel: 'IPS Terpadu', guru: 'Bambang Irawan, M.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin'),
      JadwalMapel(jam: '10.00 - 11.20', mapel: 'Matematika', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '11.20 - 12.40', mapel: 'Seni Budaya', guru: 'Tri Wahyuni, S.Sn.', ruang: 'Ruang Musik'),
      JadwalMapel(jam: '12.40 - 13.20', mapel: 'Istirahat & Sholat', guru: '-', ruang: 'Masjid Sekolah'),
      JadwalMapel(jam: '13.20 - 14.40', mapel: 'Bahasa Daerah', guru: 'Supriyanto, S.Pd.', ruang: 'Ruang 8A'),
    ],
    'kamis': [
      JadwalMapel(jam: '07.00 - 08.20', mapel: 'Bahasa Indonesia', guru: 'Siti Aminah, M.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '08.20 - 09.40', mapel: 'Bahasa Inggris', guru: 'Dewi Lestari, S.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin'),
      JadwalMapel(jam: '10.00 - 11.20', mapel: 'IPS Terpadu', guru: 'Bambang Irawan, M.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '11.20 - 12.40', mapel: 'Bimbingan Konseling (BK)', guru: 'Dra. Hj. Nurjanah, M.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '12.40 - 13.20', mapel: 'Istirahat & Sholat', guru: '-', ruang: 'Masjid Sekolah'),
      JadwalMapel(jam: '13.20 - 14.40', mapel: 'Literasi Sekolah', guru: 'Tim Literasi', ruang: 'Perpustakaan'),
    ],
    'jumat': [
      JadwalMapel(jam: '06.45 - 07.45', mapel: 'Jumat Bersih & Rohani', guru: 'Seluruh Pembina', ruang: 'Lapangan Utama'),
      JadwalMapel(jam: '07.45 - 09.05', mapel: 'Pendidikan Agama Islam', guru: 'Ustadz Ahmad Fauzan', ruang: 'Masjid Sekolah'),
      JadwalMapel(jam: '09.05 - 09.25', mapel: 'Istirahat', guru: '-', ruang: 'Area Kantin'),
      JadwalMapel(jam: '09.25 - 10.45', mapel: 'Matematika Pendalaman', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A'),
      JadwalMapel(jam: '10.45 - 11.15', mapel: 'Persiapan Ibadah Sholat Jumat', guru: '-', ruang: 'Masjid Sekolah'),
    ],
    'sabtu': [
      JadwalMapel(jam: '07.00 - 08.30', mapel: 'Gerakan Pramuka', guru: 'Pembina Pramuka', ruang: 'Lapangan Utama'),
      JadwalMapel(jam: '08.30 - 10.00', mapel: 'Ekstrakurikuler Wajib', guru: 'Instruktur Masing-masing', ruang: 'Sesuai Ekskul'),
      JadwalMapel(jam: '10.00 - 10.30', mapel: 'Evaluasi & Bersih Kelas', guru: 'Pengurus Kelas 8A', ruang: 'Ruang 8A'),
    ],
  };

  static Map<String, PiketHarian> getPiketMap() => {
    'senin': PiketHarian(
      anggota: ['Aditya Pratama', 'Aisyah Putri Azzahra', 'Bagas Satria Pratama', 'Cantika Maharani', 'Dimas Aditya Nugraha', 'Fathir Danendra Putra'],
      selesai: true,
    ),
    'selasa': PiketHarian(
      anggota: ['Ahmad Faiz Mubarok', 'Alifia Nurul Hidayah', 'Bintang Ramadhan', 'Daffa Raihan Alfarizi', 'Farhan Dwi Cahyo', 'Genta Arya Kusuma'],
      selesai: false,
    ),
    'rabu': PiketHarian(
      anggota: ['Ananda Bagus Perkasa', 'Annisa Dwi Lestari', 'Hafizah Syakira', 'Kaisar Rayhan', 'Keisha Amanda Putri', 'Latifah Nur Rahma'],
      selesai: false,
    ),
    'kamis': PiketHarian(
      anggota: ['Mahesa Danu Saputra', 'Muhammad Rizky Pratama', 'Mutiara Cinta Kasih', 'Nadhif Arya Putra', 'Nabila Syifa Wardhani', 'Putra Bayu Samudra'],
      selesai: false,
    ),
    'jumat': PiketHarian(
      anggota: ['Rafi Ahmad Fauzi', 'Rania Salma Humaira', 'Satria Dewa Bramantyo', 'Syahla Kamila', 'Taufiq Hidayatulloh', 'Vina Aulia Rahma', 'Zahra Amalia Ramadhani'],
      selesai: false,
    ),
  };

  static List<Tugas> getTugasList() => [
    Tugas(
      id: 'tg-01',
      mapel: 'Matematika',
      judul: 'Latihan Soal Teorema Pythagoras',
      deskripsi: 'Kerjakan Buku Paket halaman 84 nomor 1 sampai 10 di buku PR kotak.',
      deadline: DateTime(2026, 9, 30),
      selesai: false,
      prioritas: 'Tinggi',
    ),
    Tugas(
      id: 'tg-02',
      mapel: 'IPA Terpadu',
      judul: 'Laporan Praktikum Pernapasan Manusia',
      deskripsi: 'Format laporan: Judul, Tujuan, Alat, Langkah, Data Pengamatan, dan Analisis.',
      deadline: DateTime(2026, 10, 2),
      selesai: false,
      prioritas: 'Sedang',
    ),
    Tugas(
      id: 'tg-03',
      mapel: 'Bahasa Indonesia',
      judul: 'Menulis Teks Ulasan Novel',
      deskripsi: 'Pilih satu buku fiksi yang telah dibaca dari perpustakaan sekolah.',
      deadline: DateTime(2026, 10, 5),
      selesai: false,
      prioritas: 'Sedang',
    ),
    Tugas(
      id: 'tg-04',
      mapel: 'Bahasa Inggris',
      judul: 'Recount Text Vacation Experience',
      deskripsi: 'Write a short paragraph about your holiday in simple past tense.',
      deadline: DateTime(2026, 9, 28),
      selesai: true,
      prioritas: 'Selesai',
    ),
  ];

  static List<TransaksiKas> getKasList() => [
    TransaksiKas(id: 'ks-01', tanggal: DateTime(2026, 9, 1), tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-1 (32 Siswa)'),
    TransaksiKas(id: 'ks-02', tanggal: DateTime(2026, 9, 3), tipe: 'keluar', kategori: 'Perlengkapan', nominal: 45000, keterangan: 'Beli 2 sapu lantai & 1 serokan'),
    TransaksiKas(id: 'ks-03', tanggal: DateTime(2026, 9, 8), tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-2 (32 Siswa)'),
    TransaksiKas(id: 'ks-04', tanggal: DateTime(2026, 9, 10), tipe: 'keluar', kategori: 'ATK Kelas', nominal: 35000, keterangan: 'Isi ulang spidol whiteboard hitam dan biru'),
    TransaksiKas(id: 'ks-05', tanggal: DateTime(2026, 9, 15), tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-3 (32 Siswa)'),
    TransaksiKas(id: 'ks-06', tanggal: DateTime(2026, 9, 18), tipe: 'keluar', kategori: 'Fotokopi', nominal: 28000, keterangan: 'Fotokopi bahan ajar tengah semester'),
    TransaksiKas(id: 'ks-07', tanggal: DateTime(2026, 9, 22), tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-4 (32 Siswa)'),
    TransaksiKas(id: 'ks-08', tanggal: DateTime(2026, 9, 24), tipe: 'keluar', kategori: 'Dekorasi & P3K', nominal: 50000, keterangan: 'Perlengkapan kotak P3K & taplak meja guru'),
  ];

  static List<PengurusStruktur> getStrukturList() => [
    PengurusStruktur(jabatan: 'Wali Kelas', nama: 'Dra. Hj. Nurjanah, M.Pd.', kontak: '0812-3456-7890', sub: 'Pembina & Pengawas'),
    PengurusStruktur(jabatan: 'Ketua Kelas', nama: 'Muhammad Rizky Pratama', kontak: '0821-1122-3344', sub: 'Absen 21'),
    PengurusStruktur(jabatan: 'Wakil Ketua Kelas', nama: 'Aisyah Putri Azzahra', kontak: '0822-2233-4455', sub: 'Absen 03'),
    PengurusStruktur(jabatan: 'Sekretaris 1', nama: 'Nabila Syifa Wardhani', kontak: '0823-3344-5566', sub: 'Absen 24'),
    PengurusStruktur(jabatan: 'Sekretaris 2', nama: 'Zahra Amalia Ramadhani', kontak: '0824-4455-6677', sub: 'Absen 32'),
    PengurusStruktur(jabatan: 'Bendahara 1', nama: 'Fathir Danendra Putra', kontak: '0825-5566-7788', sub: 'Absen 12'),
    PengurusStruktur(jabatan: 'Bendahara 2', nama: 'Keisha Amanda Putri', kontak: '0826-6677-8899', sub: 'Absen 18'),
    PengurusStruktur(jabatan: 'Sie Kebersihan', nama: 'Dimas Aditya Nugraha', kontak: '0827-7788-9900', sub: 'Koordinator'),
    PengurusStruktur(jabatan: 'Sie Keamanan', nama: 'Bagas Satria Pratama', kontak: '0828-8899-0011', sub: 'Koordinator'),
    PengurusStruktur(jabatan: 'Sie Keagamaan', nama: 'Farhan Dwi Cahyo', kontak: '0829-9900-1122', sub: 'Koordinator'),
    PengurusStruktur(jabatan: 'Sie Olahraga', nama: 'Rafi Ahmad Fauzi', kontak: '0830-0011-2233', sub: 'Koordinator'),
    PengurusStruktur(jabatan: 'Sie Perlengkapan', nama: 'Genta Arya Kusuma', kontak: '0831-1122-3344', sub: 'Koordinator'),
  ];

  static List<Pengumuman> getPengumumanList() => [
    Pengumuman(
      id: 'pg-01',
      tanggal: DateTime(2026, 9, 26),
      judul: 'Penilaian Tengah Semester (PTS) Ganjil',
      isi: 'PTS akan dilaksanakan mulai tanggal 12 Oktober 2026. Seluruh siswa diharapkan melengkapi catatan dan menyelesaikan tugas tertunggak.',
    ),
    Pengumuman(
      id: 'pg-02',
      tanggal: DateTime(2026, 9, 24),
      judul: 'Pengecekan Kerapian Seragam Sekolah',
      isi: 'Mulai hari Senin depan, tata tertib pemakaian topi, dasi, ikat pinggang sekolah, serta kaos kaki putih di atas mata kaki akan diperiksa saat upacara.',
    ),
  ];
}
