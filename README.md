# Aplikasi Kelas 8A (iOS Cupertino Edition)

Aplikasi manajemen dan sistem informasi terpadu untuk Kelas 8A yang dirancang dengan standar desain Apple iOS Human Interface Guidelines (Cupertino theme) dengan palet warna lembut, navigasi tab bar, grouped card views, serta ikon vektor SF Symbols.

---

## Fitur Utama (Paket Komplit)

1. **Beranda & Dashboard Pintar**:
   - Ringkasan saldo kas kelas dan kehadiran siswa hari ini.
   - Penampil jadwal pelajaran hari ini dengan rincian jam dan ruang.
   - Status regu piket kebersihan harian beserta checklist pelaksanaan.
   - Agenda tugas & PR terdekat.
   - Papan pengumuman resmi wali kelas.

2. **Jadwal Pelajaran**:
   - Jadwal lengkap Senin sampai Sabtu.
   - Segmented control untuk berpindah hari dengan cepat.
   - Detail mata pelajaran, waktu belajar, guru pengampu, dan lokasi ruang/lab.
   - Daftar petugas piket harian pada hari terkait.

3. **Agenda & Tugas (PR)**:
   - Filter tugas: Semua, Belum Selesai, dan Selesai.
   - Form tambah tugas baru dengan input mata pelajaran, tenggat waktu (deadline), dan skala prioritas.
   - Fitur centang selesai langsung dari daftar.

4. **Buku Kas Kelas Transparan**:
   - Rekap total pemasukan, pengeluaran, dan saldo kas terkini.
   - Catatan transaksi pemasukan (iuran mingguan, donasi, dana usaha).
   - Catatan pengeluaran (pembelian ATK, alat kebersihan, modul fotokopi, P3K).
   - Filter transaksi dan tombol hapus transaksi.

5. **Data Siswa & Rekap Absensi**:
   - Daftar 32 siswa lengkap dengan nomor absen, NISN, jenis kelamin, dan jabatan kepengurusan.
   - Rekap kehadiran harian (Hadir, Sakit, Izin, Alpa) dengan tombol status cepat (H / S / I / A).
   - Kolom pencarian siswa berdasarkan nama atau nomor absen.

6. **Struktur Organisasi Kelas**:
   - Visual hierarki dewan pengurus kelas: Wali Kelas, Ketua, Wakil Ketua, Sekretaris, Bendahara, dan Koordinator Seksi.

7. **Pengaturan & Cadangan Data (Backup)**:
   - Pengalihan Mode Terang & Gelap (Light / Dark Mode).
   - Ekspor seluruh data kelas ke format file JSON.
   - Impor dan pemulihan data dari file JSON cadangan.
   - Opsi reset ke data awal kelas.

---

## Cara Menjalankan di Termux (Lokal)

Di terminal Termux, masuk ke folder proyek dan jalankan:

```bash
cd ~/kelas-8a
node server.js
```

Buka browser di HP kamu (Chrome / Firefox / Safari) lalu akses:
`http://localhost:3000`

---

## Cara Menghubungkan ke GitHub & Online 24 Jam Gratis

Kamu bisa mengunggah proyek ini ke akun GitHub kamu agar teman-teman sekelas bisa membukanya dari mana saja:

1. Buat repository baru di situs GitHub (misal bernama `kelas-8a`).
2. Di Termux, jalankan perintah berikut (ganti `USERNAME` dengan username GitHub kamu):

```bash
cd ~/kelas-8a
git add .
git commit -m "Inisialisasi aplikasi Kelas 8A versi iOS"
git remote add origin https://github.com/USERNAME/kelas-8a.git
git push -u origin main
```

3. **Mengaktifkan GitHub Pages**:
   - Buka repositori kamu di GitHub via browser.
   - Masuk ke menu **Settings** > **Pages**.
   - Pada bagian **Build and deployment** > **Source**, pilih **GitHub Actions**.
   - Website akan otomatis online dan dapat diakses melalui:
     `https://USERNAME.github.io/kelas-8a/`

---

## Cara Download File APK Android

Repository ini sudah dilengkapi dengan alur otomatis pembuatan file APK (`.github/workflows/build-apk.yml`):

1. Setelah kamu melakukan `git push` ke GitHub, GitHub Actions di cloud akan otomatis memproses dan meng-compile aplikasi menjadi file `.apk` asli.
2. Buka tab **Actions** di repositori GitHub kamu.
3. Klik proses build yang sedang/telah berjalan (*Build Android APK di Cloud*).
4. Di bagian bawah (bagian **Artifacts**), klik **Kelas-8A-Android-App** untuk mendownload file `.apk` dan membagikannya ke teman-teman sekelas.
