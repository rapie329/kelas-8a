# Aplikasi Kelas 8A (Flutter iOS Cupertino Edition)

Aplikasi manajemen dan administrasi terpadu untuk Kelas 8A yang dibangun menggunakan **Flutter** dengan komponen murni **iOS Human Interface Guidelines (CupertinoApp)**:
- 100% Menggunakan antarmuka Apple iOS (Cupertino Page Scaffold, Segmented Controls, Inset Grouped Cards, Cupertino Picker & DatePicker, Cupertino Dialogs).
- Menggunakan ikon resmi **CupertinoIcons** (SF Symbols vector clone).
- **Zero Emoji**: Tanpa menggunakan emoji sama sekali.
- Warna lembut khas Apple iOS (`CupertinoColors.systemGroupedBackground`, `activeBlue`, `systemGreen`, `systemOrange`, `systemRed`).
- Otomatis di-compile menjadi file **APK Android Native (`app-release.apk`)** melalui **GitHub Actions** di cloud.

---

## Fitur Lengkap (Paket Komplit)

1. **Beranda / Dashboard Pintar**:
   - Ringkasan cepat saldo kas kelas dan kehadiran siswa hari ini.
   - Jadwal mata pelajaran hari ini (jam, nama guru, ruang/lab).
   - Status piket harian kelas beserta tombol centang pelaksanaan.
   - Tugas/PR terdekat dengan tenggat waktu.
   - Pengumuman resmi dari wali kelas.

2. **Jadwal Pelajaran**:
   - Jadwal lengkap hari Senin sampai Sabtu.
   - Sliding Segmented Control untuk berganti hari dengan cepat.
   - Detail mata pelajaran, waktu, guru, dan ruangan.
   - Regu piket kebersihan pada hari tersebut.

3. **Agenda & Tugas (PR)**:
   - Filter segmented: Semua, Belum Selesai, dan Selesai.
   - Modal sheet iOS untuk menambah tugas baru (mapel, instruksi, deadline picker, prioritas).
   - Centang tugas selesai dan hapus tugas dengan konfirmasi dialog iOS.

4. **Buku Kas Kelas Transparan**:
   - Kartu saldo kas utama (Saldo saat ini, Total pemasukan, Total pengeluaran).
   - Tombol cepat catat pemasukan (`+ Kas Masuk`) dan pengeluaran (`- Pengeluaran`).
   - Filter transaksi: Semua, Pemasukan, Pengeluaran.
   - Riwayat transaksi dengan ikon arah kas dan nominal format Rupiah.

5. **Data Siswa & Rekap Absensi**:
   - Daftar 32 siswa lengkap dengan nomor absen, NISN, jenis kelamin, dan jabatan kepengurusan.
   - Rekap absensi harian (Hadir, Sakit, Izin, Alpa) dengan tombol status cepat (H / S / I / A).
   - Fitur pencarian siswa berdasarkan nama atau nomor absen.

6. **Struktur Organisasi Kelas**:
   - Struktur kepengurusan kelas: Wali Kelas, Ketua, Wakil, Sekretaris, Bendahara, dan Koordinator Seksi (Kebersihan, Keamanan, Keagamaan, Olahraga, Perlengkapan).

7. **Pengaturan & Tampilan**:
   - Pengalihan Mode Gelap (Dark Mode) menggunakan `CupertinoSwitch`.
   - Opsi reset ke data awal kelas dengan `CupertinoAlertDialog`.
   - Informasi aplikasi & sekolah.

---

## Struktur Folder Project

```
kelas-8a/
  .github/
    workflows/
      build-apk.yml       # Cloud compiler APK otomatis di GitHub Actions
  android/                # Konfigurasi project Android & Gradle
  lib/
    main.dart             # Entrypoint CupertinoApp & Tab Scaffold
    data/
      default_data.dart   # Data 32 siswa, jadwal, kas, piket
      kelas_repository.dart # State manager & persistent local storage
    models/               # Data model Siswa, Jadwal, Kas, Tugas, dll.
    views/                # Layar Beranda, Jadwal, Tugas, Kas, Siswa
    widgets/              # IosCard, IosBadge, ModalTambahTugas, ModalTambahKas
  pubspec.yaml            # Konfigurasi dependensi Flutter
```

---

## Cara Push ke GitHub & Dapatkan File APK (.apk)

Karena kamu mengerjakannya di HP lewat Termux, proses compile APK tidak perlu membebani memori HP kamu. GitHub Actions yang akan meng-compile-nya di server cloud gratis:

1. Buat repository baru di akun GitHub kamu (misal bernama `kelas-8a`).
2. Di Termux, jalankan perintah berikut (ganti `USERNAME` dengan username GitHub kamu):

```bash
cd ~/kelas-8a
git add .
git commit -m "feat: aplikasi Kelas 8A versi Flutter Cupertino iOS"
git remote add origin https://github.com/USERNAME/kelas-8a.git
git push -u origin main
```

3. **Mengunduh File APK**:
   - Buka repository kamu di browser atau aplikasi GitHub.
   - Masuk ke tab **Actions**.
   - Klik workflow yang sedang berjalan (*Build Android APK Release*).
   - Tunggu sekitar 2-3 menit hingga proses selesai (centang hijau).
   - Di bagian **Artifacts** di bawah halaman tersebut, klik **Kelas8A-Release-APK** untuk mendownload file `.apk` asli dan siap di-install di HP kamu atau teman-teman sekelas!
