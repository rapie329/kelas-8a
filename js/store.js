/**
 * Data Storage & State Management for Kelas 8A
 * Zero Emojis - iOS Cupertino Pure Style
 */

const STORAGE_KEY = 'kelas_8a_store_v1';
const THEME_KEY = 'kelas_8a_theme';

const DEFAULT_DATA = {
  info: {
    nama: 'Kelas 8A',
    tingkat: 'VIII (Delapan)',
    sekolah: 'SMP Negeri Unggulan',
    tahunAjaran: '2024 / 2025',
    semester: 'Genap',
    waliKelas: 'Dra. Hj. Nurjanah, M.Pd.',
    nipWali: '19750812 200212 2 003',
    motto: 'Disiplin, Cerdas, Berkarakter, dan Berprestasi'
  },
  struktur: [
    { jabatan: 'Wali Kelas', nama: 'Dra. Hj. Nurjanah, M.Pd.', kontak: '0812-3456-7890', sub: 'Pembina & Pengawas' },
    { jabatan: 'Ketua Kelas', nama: 'Muhammad Rizky Pratama', kontak: '0821-1122-3344', sub: 'Absen 21' },
    { jabatan: 'Wakil Ketua Kelas', nama: 'Aisyah Putri Azzahra', kontak: '0822-2233-4455', sub: 'Absen 03' },
    { jabatan: 'Sekretaris 1', nama: 'Nabila Syifa Wardhani', kontak: '0823-3344-5566', sub: 'Absen 24' },
    { jabatan: 'Sekretaris 2', nama: 'Zahra Amalia Ramadhani', kontak: '0824-4455-6677', sub: 'Absen 32' },
    { jabatan: 'Bendahara 1', nama: 'Fathir Danendra Putra', kontak: '0825-5566-7788', sub: 'Absen 12' },
    { jabatan: 'Bendahara 2', nama: 'Keisha Amanda Putri', kontak: '0826-6677-8899', sub: 'Absen 18' },
    { jabatan: 'Sie Kebersihan', nama: 'Dimas Aditya Nugraha', kontak: '0827-7788-9900', sub: 'Koordinator' },
    { jabatan: 'Sie Keamanan', nama: 'Bagas Satria Pratama', kontak: '0828-8899-0011', sub: 'Koordinator' },
    { jabatan: 'Sie Keagamaan', nama: 'Farhan Dwi Cahyo', kontak: '0829-9900-1122', sub: 'Koordinator' },
    { jabatan: 'Sie Olahraga', nama: 'Rafi Ahmad Fauzi', kontak: '0830-0011-2233', sub: 'Koordinator' },
    { jabatan: 'Sie Perlengkapan', nama: 'Genta Arya Kusuma', kontak: '0831-1122-3344', sub: 'Koordinator' }
  ],
  siswa: [
    { no: 1, nisn: '009812001', nama: 'Aditya Pratama', gender: 'L', status: 'Hadir' },
    { no: 2, nisn: '009812002', nama: 'Ahmad Faiz Mubarok', gender: 'L', status: 'Hadir' },
    { no: 3, nisn: '009812003', nama: 'Aisyah Putri Azzahra', gender: 'P', jabatan: 'Wakil Ketua', status: 'Hadir' },
    { no: 4, nisn: '009812004', nama: 'Alifia Nurul Hidayah', gender: 'P', status: 'Hadir' },
    { no: 5, nisn: '009812005', nama: 'Ananda Bagus Perkasa', gender: 'L', status: 'Hadir' },
    { no: 6, nisn: '009812006', nama: 'Annisa Dwi Lestari', gender: 'P', status: 'Hadir' },
    { no: 7, nisn: '009812007', nama: 'Bagas Satria Pratama', gender: 'L', jabatan: 'Sie Keamanan', status: 'Hadir' },
    { no: 8, nisn: '009812008', nama: 'Bintang Ramadhan', gender: 'L', status: 'Hadir' },
    { no: 9, nisn: '009812009', nama: 'Cantika Maharani', gender: 'P', status: 'Izin' },
    { no: 10, nisn: '009812010', nama: 'Daffa Raihan Alfarizi', gender: 'L', status: 'Hadir' },
    { no: 11, nisn: '009812011', nama: 'Dimas Aditya Nugraha', gender: 'L', jabatan: 'Sie Kebersihan', status: 'Hadir' },
    { no: 12, nisn: '009812012', nama: 'Fathir Danendra Putra', gender: 'L', jabatan: 'Bendahara 1', status: 'Hadir' },
    { no: 13, nisn: '009812013', nama: 'Farhan Dwi Cahyo', gender: 'L', jabatan: 'Sie Keagamaan', status: 'Hadir' },
    { no: 14, nisn: '009812014', nama: 'Genta Arya Kusuma', gender: 'L', jabatan: 'Sie Perlengkapan', status: 'Hadir' },
    { no: 15, nisn: '009812015', nama: 'Hafizah Syakira', gender: 'P', status: 'Hadir' },
    { no: 16, nisn: '009812016', nama: 'Intan Permata Sari', gender: 'P', status: 'Sakit' },
    { no: 17, nisn: '009812017', nama: 'Kaisar Rayhan', gender: 'L', status: 'Hadir' },
    { no: 18, nisn: '009812018', nama: 'Keisha Amanda Putri', gender: 'P', jabatan: 'Bendahara 2', status: 'Hadir' },
    { no: 19, nisn: '009812019', nama: 'Latifah Nur Rahma', gender: 'P', status: 'Hadir' },
    { no: 20, nisn: '009812020', nama: 'Mahesa Danu Saputra', gender: 'L', status: 'Hadir' },
    { no: 21, nisn: '009812021', nama: 'Muhammad Rizky Pratama', gender: 'L', jabatan: 'Ketua Kelas', status: 'Hadir' },
    { no: 22, nisn: '009812022', nama: 'Mutiara Cinta Kasih', gender: 'P', status: 'Hadir' },
    { no: 23, nisn: '009812023', nama: 'Nadhif Arya Putra', gender: 'L', status: 'Hadir' },
    { no: 24, nisn: '009812024', nama: 'Nabila Syifa Wardhani', gender: 'P', jabatan: 'Sekretaris 1', status: 'Hadir' },
    { no: 25, nisn: '009812025', nama: 'Putra Bayu Samudra', gender: 'L', status: 'Hadir' },
    { no: 26, nisn: '009812026', nama: 'Rafi Ahmad Fauzi', gender: 'L', jabatan: 'Sie Olahraga', status: 'Hadir' },
    { no: 27, nisn: '009812027', nama: 'Rania Salma Humaira', gender: 'P', status: 'Hadir' },
    { no: 28, nisn: '009812028', nama: 'Satria Dewa Bramantyo', gender: 'L', status: 'Hadir' },
    { no: 29, nisn: '009812029', nama: 'Syahla Kamila', gender: 'P', status: 'Hadir' },
    { no: 30, nisn: '009812030', nama: 'Taufiq Hidayatulloh', gender: 'L', status: 'Hadir' },
    { no: 31, nisn: '009812031', nama: 'Vina Aulia Rahma', gender: 'P', status: 'Hadir' },
    { no: 32, nisn: '009812032', nama: 'Zahra Amalia Ramadhani', gender: 'P', jabatan: 'Sekretaris 2', status: 'Hadir' }
  ],
  jadwal: {
    senin: [
      { jam: '07.00 - 07.45', mapel: 'Upacara Bendera', guru: 'Seluruh Dewan Guru', ruang: 'Lapangan Utama' },
      { jam: '07.45 - 09.05', mapel: 'Matematika', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A' },
      { jam: '09.05 - 09.25', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin' },
      { jam: '09.25 - 10.45', mapel: 'Bahasa Indonesia', guru: 'Siti Aminah, M.Pd.', ruang: 'Ruang 8A' },
      { jam: '10.45 - 12.05', mapel: 'IPA Terpadu (Fisika)', guru: 'Rahmat Hidayat, M.Si.', ruang: 'Lab IPA' },
      { jam: '12.05 - 12.45', mapel: 'Istirahat Kedua & Sholat Dzuhur', guru: '-', ruang: 'Masjid Sekolah' },
      { jam: '12.45 - 14.05', mapel: 'Pendidikan Agama Islam', guru: 'Ustadz Ahmad Fauzan, S.Ag.', ruang: 'Ruang 8A' }
    ],
    selasa: [
      { jam: '07.00 - 08.20', mapel: 'Pendidikan Jasmani (PJOK)', guru: 'Hendra Setiawan, S.Pd.', ruang: 'Lapangan Olahraga' },
      { jam: '08.20 - 09.40', mapel: 'Bahasa Inggris', guru: 'Dewi Lestari, S.Pd.', ruang: 'Ruang 8A' },
      { jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin' },
      { jam: '10.00 - 11.20', mapel: 'Informatika', guru: 'Fajar Nugraha, S.Kom.', ruang: 'Lab Komputer 2' },
      { jam: '11.20 - 12.40', mapel: 'PPKn', guru: 'Drs. Supardi', ruang: 'Ruang 8A' },
      { jam: '12.40 - 13.20', mapel: 'Istirahat Kedua & Sholat', guru: '-', ruang: 'Masjid Sekolah' },
      { jam: '13.20 - 14.40', mapel: 'Prakarya', guru: 'Endang Sulastri, S.Pd.', ruang: 'Ruang Kesenian' }
    ],
    rabu: [
      { jam: '07.00 - 08.20', mapel: 'IPA Terpadu (Biologi)', guru: 'Nurul Hasanah, S.Si.', ruang: 'Ruang 8A' },
      { jam: '08.20 - 09.40', mapel: 'IPS Terpadu (Geografi)', guru: 'Bambang Irawan, M.Pd.', ruang: 'Ruang 8A' },
      { jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin' },
      { jam: '10.00 - 11.20', mapel: 'Matematika', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A' },
      { jam: '11.20 - 12.40', mapel: 'Seni Budaya', guru: 'Tri Wahyuni, S.Sn.', ruang: 'Ruang Musik' },
      { jam: '12.40 - 13.20', mapel: 'Istirahat Kedua & Sholat', guru: '-', ruang: 'Masjid Sekolah' },
      { jam: '13.20 - 14.40', mapel: 'Bahasa Daerah', guru: 'Supriyanto, S.Pd.', ruang: 'Ruang 8A' }
    ],
    kamis: [
      { jam: '07.00 - 08.20', mapel: 'Bahasa Indonesia', guru: 'Siti Aminah, M.Pd.', ruang: 'Ruang 8A' },
      { jam: '08.20 - 09.40', mapel: 'Bahasa Inggris', guru: 'Dewi Lestari, S.Pd.', ruang: 'Ruang 8A' },
      { jam: '09.40 - 10.00', mapel: 'Istirahat Pertama', guru: '-', ruang: 'Area Kantin' },
      { jam: '10.00 - 11.20', mapel: 'IPS Terpadu (Sejarah)', guru: 'Bambang Irawan, M.Pd.', ruang: 'Ruang 8A' },
      { jam: '11.20 - 12.40', mapel: 'Bimbingan Konseling (BK)', guru: 'Dra. Hj. Nurjanah, M.Pd.', ruang: 'Ruang 8A' },
      { jam: '12.40 - 13.20', mapel: 'Istirahat Kedua & Sholat', guru: '-', ruang: 'Masjid Sekolah' },
      { jam: '13.20 - 14.40', mapel: 'Literasi & Pojok Baca', guru: 'Tim Literasi Sekolah', ruang: 'Perpustakaan' }
    ],
    jumat: [
      { jam: '06.45 - 07.45', mapel: 'Jumat Sehat / Bersih / Rohani', guru: 'Seluruh Pembina', ruang: 'Lapangan Utama' },
      { jam: '07.45 - 09.05', mapel: 'Pendidikan Agama Islam', guru: 'Ustadz Ahmad Fauzan, S.Ag.', ruang: 'Masjid / Ruang 8A' },
      { jam: '09.05 - 09.25', mapel: 'Istirahat', guru: '-', ruang: 'Area Kantin' },
      { jam: '09.25 - 10.45', mapel: 'Matematika Pendalaman', guru: 'Budi Santoso, S.Pd.', ruang: 'Ruang 8A' },
      { jam: '10.45 - 11.15', mapel: 'Persiapan Ibadah Sholat Jumat', guru: '-', ruang: 'Masjid Sekolah' }
    ],
    sabtu: [
      { jam: '07.00 - 08.30', mapel: 'Pengembangan Karakter & Pramuka', guru: 'Kakak Pembina Pramuka', ruang: 'Lapangan Utama' },
      { jam: '08.30 - 10.00', mapel: 'Ekstrakurikuler Pilihan Wajib', guru: 'Instruktur Masing-masing', ruang: 'Sesuai Ekstrakurikuler' },
      { jam: '10.00 - 10.30', mapel: 'Evaluasi Mingguan & Bersih Kelas', guru: 'Pengurus Kelas 8A', ruang: 'Ruang 8A' }
    ]
  },
  piket: {
    senin: {
      anggota: ['Aditya Pratama', 'Aisyah Putri Azzahra', 'Bagas Satria Pratama', 'Cantika Maharani', 'Dimas Aditya Nugraha', 'Fathir Danendra Putra'],
      selesai: true
    },
    selasa: {
      anggota: ['Ahmad Faiz Mubarok', 'Alifia Nurul Hidayah', 'Bintang Ramadhan', 'Daffa Raihan Alfarizi', 'Farhan Dwi Cahyo', 'Genta Arya Kusuma'],
      selesai: false
    },
    rabu: {
      anggota: ['Ananda Bagus Perkasa', 'Annisa Dwi Lestari', 'Hafizah Syakira', 'Kaisar Rayhan', 'Keisha Amanda Putri', 'Latifah Nur Rahma'],
      selesai: false
    },
    kamis: {
      anggota: ['Mahesa Danu Saputra', 'Muhammad Rizky Pratama', 'Mutiara Cinta Kasih', 'Nadhif Arya Putra', 'Nabila Syifa Wardhani', 'Putra Bayu Samudra'],
      selesai: false
    },
    jumat: {
      anggota: ['Rafi Ahmad Fauzi', 'Rania Salma Humaira', 'Satria Dewa Bramantyo', 'Syahla Kamila', 'Taufiq Hidayatulloh', 'Vina Aulia Rahma', 'Zahra Amalia Ramadhani'],
      selesai: false
    }
  },
  tugas: [
    {
      id: 'tg-01',
      mapel: 'Matematika',
      judul: 'Latihan Soal Teorema Pythagoras',
      deskripsi: 'Kerjakan Buku Paket halaman 84 Nomor 1 sampai 10 di buku PR kotak.',
      deadline: '2026-09-30',
      selesai: false,
      prioritas: 'Tinggi'
    },
    {
      id: 'tg-02',
      mapel: 'IPA Terpadu',
      judul: 'Laporan Praktikum Sistem Pernapasan Manusia',
      deskripsi: 'Format laporan: Judul, Tujuan, Alat & Bahan, Langkah Kerja, Analisis Data, dan Kesimpulan. Ditulis tangan rapi.',
      deadline: '2026-10-02',
      selesai: false,
      prioritas: 'Sedang'
    },
    {
      id: 'tg-03',
      mapel: 'Bahasa Indonesia',
      judul: 'Menulis Teks Ulasan Novel/Buku',
      deskripsi: 'Pilih satu buku fiksi yang telah dibaca di perpustakaan sekolah. Buat struktur orientasi, tafsiran, evaluasi, dan rangkuman.',
      deadline: '2026-10-05',
      selesai: false,
      prioritas: 'Sedang'
    },
    {
      id: 'tg-04',
      mapel: 'Bahasa Inggris',
      judul: 'Recount Text Vacation Experience',
      deskripsi: 'Write a short paragraph about your memorable holiday in simple past tense (minimal 100 words).',
      deadline: '2026-09-28',
      selesai: true,
      prioritas: 'Selesai'
    }
  ],
  kas: [
    { id: 'ks-01', tanggal: '2026-09-01', tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-1 (32 Siswa)' },
    { id: 'ks-02', tanggal: '2026-09-03', tipe: 'keluar', kategori: 'Perlengkapan', nominal: 45000, keterangan: 'Beli 2 sapu lantai & 1 serokan plastik' },
    { id: 'ks-03', tanggal: '2026-09-08', tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-2 (32 Siswa)' },
    { id: 'ks-04', tanggal: '2026-09-10', tipe: 'keluar', kategori: 'ATK Kelas', nominal: 35000, keterangan: 'Isi ulang spidol whiteboard hitam dan biru' },
    { id: 'ks-05', tanggal: '2026-09-15', tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-3 (32 Siswa)' },
    { id: 'ks-06', tanggal: '2026-09-18', tipe: 'keluar', kategori: 'Fotokopi', nominal: 28000, keterangan: 'Fotokopi kisi-kisi asesmen tengah semester' },
    { id: 'ks-07', tanggal: '2026-09-22', tipe: 'masuk', kategori: 'Iuran Kas', nominal: 160000, keterangan: 'Iuran Kas Minggu ke-4 (32 Siswa)' },
    { id: 'ks-08', tanggal: '2026-09-24', tipe: 'keluar', kategori: 'Dekorasi & P3K', nominal: 50000, keterangan: 'Beli isi kotak P3K (Minyak kayu putih, betadine, plester) & taplak meja guru' }
  ],
  pengumuman: [
    {
      id: 'pg-01',
      tanggal: '2026-09-26',
      judul: 'Penilaian Tengah Semester (PTS) Ganjil',
      isi: 'PTS akan dilaksanakan mulai tanggal 12 Oktober 2026. Seluruh siswa diharapkan melengkapi catatan dan menyelesaikan tugas tertunggak.'
    },
    {
      id: 'pg-02',
      tanggal: '2026-09-24',
      judul: 'Pengecekan Kerapian Seragam dan Atribut',
      isi: 'Mulai hari Senin depan, tata tertib pemakaian topi, dasi, ikat pinggang sekolah, serta kaos kaki putih di atas mata kaki akan diperiksa ketat saat upacara.'
    }
  ]
};

class Store {
  constructor() {
    this.data = this.load();
    this.listeners = [];
  }

  load() {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (stored) {
        return JSON.parse(stored);
      }
    } catch (e) {
      console.warn('Gagal memuat dari storage:', e);
    }
    return JSON.parse(JSON.stringify(DEFAULT_DATA));
  }

  save() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(this.data));
      this.notify();
    } catch (e) {
      console.error('Gagal menyimpan ke storage:', e);
    }
  }

  subscribe(callback) {
    this.listeners.push(callback);
    return () => {
      this.listeners = this.listeners.filter(cb => cb !== callback);
    };
  }

  notify() {
    this.listeners.forEach(cb => cb(this.data));
  }

  resetToDefault() {
    this.data = JSON.parse(JSON.stringify(DEFAULT_DATA));
    this.save();
  }

  exportJSON() {
    return JSON.stringify(this.data, null, 2);
  }

  importJSON(jsonString) {
    try {
      const parsed = JSON.parse(jsonString);
      if (parsed && parsed.info && parsed.siswa && parsed.jadwal) {
        this.data = parsed;
        this.save();
        return true;
      }
    } catch (e) {
      console.error('Format JSON tidak valid:', e);
    }
    return false;
  }

  // Kas Methods
  getSaldoKas() {
    let masuk = 0;
    let keluar = 0;
    (this.data.kas || []).forEach(item => {
      const nom = Number(item.nominal) || 0;
      if (item.tipe === 'masuk') masuk += nom;
      else if (item.tipe === 'keluar') keluar += nom;
    });
    return {
      masuk,
      keluar,
      saldo: masuk - keluar
    };
  }

  addKas(transaksi) {
    const id = 'ks-' + Date.now();
    this.data.kas.unshift({ id, ...transaksi });
    this.save();
  }

  deleteKas(id) {
    this.data.kas = this.data.kas.filter(item => item.id !== id);
    this.save();
  }

  // Tugas Methods
  addTugas(tugas) {
    const id = 'tg-' + Date.now();
    this.data.tugas.unshift({ id, selesai: false, ...tugas });
    this.save();
  }

  toggleTugas(id) {
    const item = this.data.tugas.find(t => t.id === id);
    if (item) {
      item.selesai = !item.selesai;
      this.save();
    }
  }

  deleteTugas(id) {
    this.data.tugas = this.data.tugas.filter(t => t.id !== id);
    this.save();
  }

  // Absensi Methods
  setSiswaStatus(noAbsen, newStatus) {
    const s = this.data.siswa.find(item => item.no === noAbsen);
    if (s) {
      s.status = newStatus;
      this.save();
    }
  }

  getRekapAbsensi() {
    const counts = { Hadir: 0, Sakit: 0, Izin: 0, Alpa: 0 };
    (this.data.siswa || []).forEach(s => {
      const st = s.status || 'Hadir';
      if (counts[st] !== undefined) counts[st]++;
      else counts.Hadir++;
    });
    return counts;
  }

  // Piket Methods
  togglePiketSelesai(hari) {
    if (this.data.piket[hari]) {
      this.data.piket[hari].selesai = !this.data.piket[hari].selesai;
      this.save();
    }
  }
}

// Global Store Instance
window.store = new Store();

// Theme Helper
window.applyTheme = function(theme) {
  if (theme === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    localStorage.setItem(THEME_KEY, 'dark');
  } else {
    document.documentElement.removeAttribute('data-theme');
    localStorage.setItem(THEME_KEY, 'light');
  }
};

window.initTheme = function() {
  const saved = localStorage.getItem(THEME_KEY);
  if (saved === 'dark' || (!saved && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    window.applyTheme('dark');
  } else {
    window.applyTheme('light');
  }
};
