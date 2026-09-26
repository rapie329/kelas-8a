/**
 * Kelas 8A - Core Application Logic
 * iOS Human Interface Guidelines Architecture
 * Strictly ZERO Emojis
 */

// Utility: Format Currency to IDR
function formatRupiah(amount) {
  return 'Rp ' + Number(amount).toLocaleString('id-ID');
}

// Utility: Format Date string
function formatTanggal(dateStr) {
  if (!dateStr) return '-';
  const parts = dateStr.split('-');
  if (parts.length === 3) {
    const bulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    const bIndex = parseInt(parts[1], 10) - 1;
    return `${parts[2]} ${bulan[bIndex] || parts[1]} ${parts[0]}`;
  }
  return dateStr;
}

// Get current Indonesian day name
function getCurrentDayKey() {
  const dayNames = ['minggu', 'senin', 'selasa', 'rabu', 'kamis', 'jumat', 'sabtu'];
  const dayIdx = new Date().getDay();
  const key = dayNames[dayIdx];
  if (key === 'minggu') return 'senin'; // default fallback for school days
  return key;
}

// Global active states
let currentTab = 'beranda';
let currentJadwalDay = getCurrentDayKey();
let currentTugasFilter = 'semua';
let currentKasFilter = 'semua';
let currentInfoSub = 'absen';
let currentSiswaSearch = '';

// DOM Initialization
document.addEventListener('DOMContentLoaded', () => {
  window.initTheme();
  setupIcons();
  setupEventListeners();
  renderAll();

  // Set today's date in header & inputs
  const today = new Date();
  const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
  const dateStr = today.toLocaleDateString('id-ID', options);
  const dateHeader = document.getElementById('home-date-str');
  if (dateHeader) dateHeader.textContent = dateStr;

  const yyyy = today.getFullYear();
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const dd = String(today.getDate()).padStart(2, '0');
  const todayISO = `${yyyy}-${mm}-${dd}`;
  
  const kasTgl = document.getElementById('kas-input-tanggal');
  if (kasTgl) kasTgl.value = todayISO;
  const tugasDdl = document.getElementById('tugas-input-deadline');
  if (tugasDdl) tugasDdl.value = todayISO;

  // React to store changes
  window.store.subscribe(() => {
    renderAll();
  });
});

// Setup All SF Symbols-style SVG Icons
function setupIcons() {
  const iconMappings = [
    { id: 'nav-icon-container', icon: 'book', size: 22 },
    { id: 'theme-icon-container', icon: 'moon', size: 19 },
    { id: 'add-icon-container', icon: 'plus', size: 20 },
    { id: 'stat-wallet-icon', icon: 'wallet', size: 16 },
    { id: 'stat-users-icon', icon: 'users', size: 16 },
    { id: 'dash-piket-icon', icon: 'broom', size: 16 },
    { id: 'dash-piket-check-icon', icon: 'check', size: 12 },
    { id: 'tab-icon-beranda', icon: 'home', size: 22 },
    { id: 'tab-icon-jadwal', icon: 'calendar', size: 22 },
    { id: 'tab-icon-tugas', icon: 'checklist', size: 22 },
    { id: 'tab-icon-kas', icon: 'wallet', size: 22 },
    { id: 'tab-icon-info', icon: 'person', size: 22 },
    { id: 'icon-tugas-add-btn', icon: 'plus', size: 14 },
    { id: 'kas-inc-icon', icon: 'arrow-down-left', size: 14 },
    { id: 'kas-exp-icon', icon: 'arrow-up-right', size: 14 },
    { id: 'kas-btn-inc-icon', icon: 'plus', size: 16 },
    { id: 'kas-btn-exp-icon', icon: 'arrow-up-right', size: 16 },
    { id: 'search-icon-box', icon: 'search', size: 16 },
    { id: 'set-export-icon', icon: 'exportTray', size: 18 },
    { id: 'set-import-icon', icon: 'importTray', size: 18 },
    { id: 'set-reset-icon', icon: 'trash', size: 18 },
    { id: 'set-chevron-1', icon: 'chevronRight', size: 16 },
    { id: 'set-chevron-2', icon: 'chevronRight', size: 16 },
    { id: 'set-chevron-3', icon: 'chevronRight', size: 16 },
    { id: 'close-modal-tugas-icon', icon: 'xmark', size: 18 },
    { id: 'close-modal-kas-icon', icon: 'xmark', size: 18 }
  ];

  iconMappings.forEach(item => {
    const el = document.getElementById(item.id);
    if (el) {
      el.innerHTML = getIcon(item.icon, item.size);
    }
  });
}

// Master Render Trigger
function renderAll() {
  renderDashboard();
  renderJadwal(currentJadwalDay);
  renderTugas(currentTugasFilter);
  renderKas(currentKasFilter);
  renderSiswa(currentSiswaSearch);
  renderStruktur();
  updateThemeIcon();
}

// TAB NAVIGATION CONTROLLER
function switchTab(tabKey) {
  currentTab = tabKey;
  
  // Hide all views
  document.querySelectorAll('.tab-view').forEach(view => {
    view.classList.add('hidden');
  });

  // Show target view
  const target = document.getElementById(`tab-${tabKey}`);
  if (target) {
    target.classList.remove('hidden');
  }

  // Update tabbar active states
  document.querySelectorAll('.ios-tab-item').forEach(btn => {
    if (btn.getAttribute('data-tab') === tabKey) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  // Update top nav titles
  const titles = {
    beranda: { title: 'Kelas 8A', sub: 'SMP Negeri Unggulan' },
    jadwal: { title: 'Jadwal Pelajaran', sub: 'Semester Genap' },
    tugas: { title: 'Agenda Tugas', sub: 'Daftar PR Aktif' },
    kas: { title: 'Buku Kas', sub: 'Rekap Keuangan' },
    info: { title: 'Data Kelas 8A', sub: '32 Siswa Terdaftar' }
  };

  const navTitle = document.getElementById('ios-nav-title');
  const navSub = document.getElementById('ios-nav-subtext');
  if (navTitle && titles[tabKey]) navTitle.textContent = titles[tabKey].title;
  if (navSub && titles[tabKey]) navSub.textContent = titles[tabKey].sub;

  // Scroll to top
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

// ----------------------------------------------------
// 1. DASHBOARD RENDERER
// ----------------------------------------------------
function renderDashboard() {
  const data = window.store.data;
  const saldoInfo = window.store.getSaldoKas();
  const rekapAbsen = window.store.getRekapAbsensi();

  // Saldo
  const saldoEl = document.getElementById('dash-saldo');
  if (saldoEl) saldoEl.textContent = formatRupiah(saldoInfo.saldo);

  // Kehadiran
  const kehEl = document.getElementById('dash-kehadiran');
  const kehSub = document.getElementById('dash-kehadiran-sub');
  if (kehEl) kehEl.textContent = `${rekapAbsen.Hadir} / 32`;
  if (kehSub) kehSub.textContent = `Sakit: ${rekapAbsen.Sakit} • Izin: ${rekapAbsen.Izin} • Alpa: ${rekapAbsen.Alpa}`;

  // Jadwal Hari Ini
  const todayKey = getCurrentDayKey();
  const jadwalHariIni = data.jadwal[todayKey] || [];
  const jContainer = document.getElementById('dash-jadwal-container');
  if (jContainer) {
    if (jadwalHariIni.length === 0) {
      jContainer.innerHTML = `
        <div class="ios-list-item dense" style="padding: 24px 16px; justify-content: center; text-align: center;">
          <span class="text-sub">Tidak ada jadwal mata pelajaran hari ini.</span>
        </div>`;
    } else {
      let html = '';
      jadwalHariIni.slice(0, 4).forEach((item, idx) => {
        html += `
          <div class="ios-list-item">
            <div style="display: flex; align-items: center;">
              <div class="ios-icon-well blue" style="width: 28px; height: 28px; margin-right: 10px;">
                ${getIcon('book', 15)}
              </div>
              <div>
                <div class="font-semibold" style="font-size: 14px;">${item.mapel}</div>
                <div class="ios-nav-subtext">${item.jam} • ${item.guru}</div>
              </div>
            </div>
            <span class="ios-badge gray">${item.ruang}</span>
          </div>`;
      });
      if (jadwalHariIni.length > 4) {
        html += `
          <div class="ios-list-item dense" style="cursor: pointer; justify-content: center;" onclick="switchTab('jadwal')">
            <span class="text-blue font-semibold" style="font-size: 13px;">+ ${jadwalHariIni.length - 4} Pelajaran Lainnya</span>
          </div>`;
      }
      jContainer.innerHTML = html;
    }
  }

  // Piket Hari Ini
  const piketHariIni = data.piket[todayKey];
  const piketHariEl = document.getElementById('dash-piket-hari');
  const piketBtn = document.getElementById('btn-toggle-dash-piket');
  const piketStatusText = document.getElementById('dash-piket-status-text');
  const piketAnggota = document.getElementById('dash-piket-anggota');

  if (piketHariEl) {
    piketHariEl.textContent = todayKey.charAt(0).toUpperCase() + todayKey.slice(1);
  }

  if (piketHariIni && piketBtn && piketStatusText && piketAnggota) {
    if (piketHariIni.selesai) {
      piketBtn.className = 'ios-badge green';
      piketStatusText.textContent = 'Sudah Piket';
    } else {
      piketBtn.className = 'ios-badge orange';
      piketStatusText.textContent = 'Belum Piket';
    }

    piketBtn.onclick = () => {
      window.store.togglePiketSelesai(todayKey);
    };

    let chipHtml = '';
    (piketHariIni.anggota || []).forEach(name => {
      chipHtml += `<span class="ios-chip" style="font-size: 12px; padding: 4px 10px;">${name}</span>`;
    });
    piketAnggota.innerHTML = chipHtml;
  }

  // Tugas Mendatang
  const tContainer = document.getElementById('dash-tugas-container');
  if (tContainer) {
    const activeTugas = (data.tugas || []).filter(t => !t.selesai);
    if (activeTugas.length === 0) {
      tContainer.innerHTML = `
        <div class="ios-list-item dense" style="padding: 20px 16px; justify-content: center;">
          <span class="text-sub font-semibold" style="font-size: 13px;">Semua tugas telah diselesaikan</span>
        </div>`;
    } else {
      let tHtml = '';
      activeTugas.slice(0, 3).forEach(item => {
        tHtml += `
          <div class="ios-list-item">
            <div style="display: flex; align-items: center;">
              <button class="ios-nav-btn" style="padding: 4px; margin-right: 8px;" onclick="window.store.toggleTugas('${item.id}')">
                ${getIcon('checklist', 18, 'text-sub')}
              </button>
              <div>
                <div class="font-semibold" style="font-size: 14px;">${item.judul}</div>
                <div class="ios-nav-subtext">${item.mapel} • Deadline: ${formatTanggal(item.deadline)}</div>
              </div>
            </div>
            <span class="ios-badge ${item.prioritas === 'Tinggi' ? 'red' : 'blue'}">${item.prioritas}</span>
          </div>`;
      });
      tContainer.innerHTML = tHtml;
    }
  }

  // Pengumuman
  const pContainer = document.getElementById('dash-pengumuman-container');
  if (pContainer) {
    let pHtml = '';
    (data.pengumuman || []).forEach(p => {
      pHtml += `
        <div class="ios-card" style="padding: 14px; margin-bottom: 10px;">
          <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 6px;">
            <div style="display: flex; align-items: center; gap: 6px;">
              <div class="ios-icon-well blue" style="width: 22px; height: 22px; margin-right: 0;">
                ${getIcon('bell', 13)}
              </div>
              <span class="font-semibold" style="font-size: 14px;">${p.judul}</span>
            </div>
            <span class="ios-nav-subtext">${formatTanggal(p.tanggal)}</span>
          </div>
          <div style="font-size: 13px; line-height: 1.45; color: var(--ios-text); opacity: 0.88;">
            ${p.isi}
          </div>
        </div>`;
    });
    pContainer.innerHTML = pHtml;
  }
}

// ----------------------------------------------------
// 2. JADWAL PELAJARAN RENDERER
// ----------------------------------------------------
function renderJadwal(dayKey) {
  currentJadwalDay = dayKey;
  const data = window.store.data;
  const list = data.jadwal[dayKey] || [];
  const container = document.getElementById('jadwal-list-container');
  const titleEl = document.getElementById('jadwal-list-title');

  // Update Segmented Control Buttons
  document.querySelectorAll('#jadwal-day-selector .ios-segment-btn').forEach(btn => {
    if (btn.getAttribute('data-day') === dayKey) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  const dayCapital = dayKey.charAt(0).toUpperCase() + dayKey.slice(1);
  if (titleEl) titleEl.textContent = `Mata Pelajaran Hari ${dayCapital}`;

  if (container) {
    if (list.length === 0) {
      container.innerHTML = `
        <div class="ios-list-item dense" style="padding: 28px 16px; justify-content: center; text-align: center;">
          <span class="text-sub">Tidak ada jadwal mata pelajaran untuk hari ini.</span>
        </div>`;
    } else {
      let html = '';
      list.forEach((item, idx) => {
        html += `
          <div class="ios-list-item">
            <div style="display: flex; align-items: center;">
              <div class="ios-icon-well blue" style="width: 32px; height: 32px;">
                ${getIcon('book', 17)}
              </div>
              <div>
                <div class="font-semibold" style="font-size: 15px;">${item.mapel}</div>
                <div class="ios-nav-subtext">${item.jam} • ${item.guru}</div>
              </div>
            </div>
            <span class="ios-badge gray">${item.ruang}</span>
          </div>`;
      });
      container.innerHTML = html;
    }
  }

  // Piket of this day
  const piketData = data.piket[dayKey];
  const pBox = document.getElementById('jadwal-piket-box');
  const pTitle = document.getElementById('jadwal-piket-title');
  const pBadge = document.getElementById('jadwal-piket-badge');
  const pList = document.getElementById('jadwal-piket-list');

  if (pBox && piketData && pList) {
    pBox.classList.remove('hidden');
    if (pTitle) pTitle.textContent = `Piket Hari ${dayCapital}`;
    if (pBadge) {
      pBadge.className = piketData.selesai ? 'ios-badge green' : 'ios-badge orange';
      pBadge.textContent = piketData.selesai ? 'Selesai' : 'Belum';
    }
    let pChips = '';
    (piketData.anggota || []).forEach(name => {
      pChips += `<span class="ios-chip" style="font-size: 13px;">${name}</span>`;
    });
    pList.innerHTML = pChips;
  } else if (pBox) {
    pBox.classList.add('hidden');
  }
}

// ----------------------------------------------------
// 3. TUGAS / PR RENDERER
// ----------------------------------------------------
function renderTugas(filterKey) {
  currentTugasFilter = filterKey;
  const list = window.store.data.tugas || [];
  const container = document.getElementById('tugas-list-container');

  // Update Segmented Control Buttons
  document.querySelectorAll('#tugas-filter-selector .ios-segment-btn').forEach(btn => {
    if (btn.getAttribute('data-filter') === filterKey) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  let filtered = list;
  if (filterKey === 'belum') {
    filtered = list.filter(t => !t.selesai);
  } else if (filterKey === 'selesai') {
    filtered = list.filter(t => t.selesai);
  }

  if (container) {
    if (filtered.length === 0) {
      container.innerHTML = `
        <div class="ios-list-item dense" style="padding: 32px 16px; justify-content: center; text-align: center;">
          <span class="text-sub">Tidak ada catatan tugas pada filter ini.</span>
        </div>`;
    } else {
      let html = '';
      filtered.forEach(item => {
        const isDone = item.selesai;
        html += `
          <div class="ios-list-item" style="align-items: flex-start; padding: 14px 16px;">
            <div style="display: flex; align-items: flex-start; gap: 10px; flex: 1;">
              <button class="ios-nav-btn" style="padding: 2px; margin-top: 2px;" onclick="window.store.toggleTugas('${item.id}')">
                ${isDone ? getIcon('check', 20, 'text-green') : getIcon('checklist', 20, 'text-sub')}
              </button>
              <div style="flex: 1;">
                <div class="font-semibold ${isDone ? 'text-sub' : ''}" style="font-size: 15px; ${isDone ? 'text-decoration: line-through;' : ''}">
                  ${item.judul}
                </div>
                <div class="ios-nav-subtext mt-1" style="line-height: 1.4;">
                  ${item.deskripsi || 'Tidak ada deskripsi tambahan'}
                </div>
                <div style="display: flex; gap: 6px; margin-top: 8px;">
                  <span class="ios-badge gray">${item.mapel}</span>
                  <span class="ios-badge ${isDone ? 'green' : 'blue'}">Deadline: ${formatTanggal(item.deadline)}</span>
                  <span class="ios-badge ${item.prioritas === 'Tinggi' ? 'red' : 'gray'}">${item.prioritas}</span>
                </div>
              </div>
            </div>
            <button class="ios-nav-btn text-sub" style="padding: 4px;" onclick="deleteTugasConfirm('${item.id}')">
              ${getIcon('trash', 16)}
            </button>
          </div>`;
      });
      container.innerHTML = html;
    }
  }
}

function deleteTugasConfirm(id) {
  if (confirm('Hapus catatan tugas ini?')) {
    window.store.deleteTugas(id);
  }
}

// ----------------------------------------------------
// 4. BUKU KAS RENDERER
// ----------------------------------------------------
function renderKas(filterKey) {
  currentKasFilter = filterKey;
  const saldoInfo = window.store.getSaldoKas();
  const transactions = window.store.data.kas || [];

  // Update Balances
  const totalSaldoEl = document.getElementById('kas-total-saldo');
  const totalMasukEl = document.getElementById('kas-total-masuk');
  const totalKeluarEl = document.getElementById('kas-total-keluar');

  if (totalSaldoEl) totalSaldoEl.textContent = formatRupiah(saldoInfo.saldo);
  if (totalMasukEl) totalMasukEl.textContent = formatRupiah(saldoInfo.masuk);
  if (totalKeluarEl) totalKeluarEl.textContent = formatRupiah(saldoInfo.keluar);

  // Update Segmented Control Buttons
  document.querySelectorAll('#kas-filter-selector .ios-segment-btn').forEach(btn => {
    if (btn.getAttribute('data-filter') === filterKey) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  let filtered = transactions;
  if (filterKey === 'masuk') {
    filtered = transactions.filter(k => k.tipe === 'masuk');
  } else if (filterKey === 'keluar') {
    filtered = transactions.filter(k => k.tipe === 'keluar');
  }

  const container = document.getElementById('kas-list-container');
  if (container) {
    if (filtered.length === 0) {
      container.innerHTML = `
        <div class="ios-list-item dense" style="padding: 32px 16px; justify-content: center; text-align: center;">
          <span class="text-sub">Belum ada riwayat transaksi pada filter ini.</span>
        </div>`;
    } else {
      let html = '';
      filtered.forEach(item => {
        const isMasuk = item.tipe === 'masuk';
        html += `
          <div class="ios-list-item">
            <div style="display: flex; align-items: center;">
              <div class="ios-icon-well ${isMasuk ? 'green' : 'red'}" style="width: 32px; height: 32px;">
                ${isMasuk ? getIcon('arrowDownLeft', 16) : getIcon('arrowUpRight', 16)}
              </div>
              <div>
                <div class="font-semibold" style="font-size: 14px;">${item.keterangan}</div>
                <div class="ios-nav-subtext">${formatTanggal(item.tanggal)} • ${item.kategori}</div>
              </div>
            </div>
            <div style="display: flex; align-items: center; gap: 8px;">
              <div class="font-bold ${isMasuk ? 'text-green' : 'text-red'}" style="font-size: 14px;">
                ${isMasuk ? '+' : '-'} ${formatRupiah(item.nominal)}
              </div>
              <button class="ios-nav-btn text-sub" style="padding: 4px;" onclick="deleteKasConfirm('${item.id}')">
                ${getIcon('trash', 15)}
              </button>
            </div>
          </div>`;
      });
      container.innerHTML = html;
    }
  }
}

function deleteKasConfirm(id) {
  if (confirm('Hapus transaksi ini dari buku kas?')) {
    window.store.deleteKas(id);
  }
}

// ----------------------------------------------------
// 5. DATA SISWA & ABSENSI RENDERER
// ----------------------------------------------------
function renderSiswa(query = '') {
  currentSiswaSearch = query.trim().toLowerCase();
  const siswaList = window.store.data.siswa || [];
  const rekap = window.store.getRekapAbsensi();

  // Update counters
  const cHadir = document.getElementById('count-hadir');
  const cSakit = document.getElementById('count-sakit');
  const cIzin = document.getElementById('count-izin');
  const cAlpa = document.getElementById('count-alpa');
  if (cHadir) cHadir.textContent = rekap.Hadir;
  if (cSakit) cSakit.textContent = rekap.Sakit;
  if (cIzin) cIzin.textContent = rekap.Izin;
  if (cAlpa) cAlpa.textContent = rekap.Alpa;

  let filtered = siswaList;
  if (currentSiswaSearch) {
    filtered = siswaList.filter(s => 
      s.nama.toLowerCase().includes(currentSiswaSearch) || 
      String(s.no).includes(currentSiswaSearch)
    );
  }

  const container = document.getElementById('siswa-list-container');
  if (container) {
    if (filtered.length === 0) {
      container.innerHTML = `
        <div class="ios-list-item dense" style="padding: 24px 16px; justify-content: center;">
          <span class="text-sub">Siswa tidak ditemukan</span>
        </div>`;
    } else {
      let html = '';
      filtered.forEach(s => {
        const status = s.status || 'Hadir';
        html += `
          <div class="ios-list-item" style="padding: 10px 14px;">
            <div style="display: flex; align-items: center; flex: 1;">
              <div class="ios-icon-well gray" style="width: 32px; height: 32px; margin-right: 10px; font-weight: 700; font-size: 13px;">
                ${s.no}
              </div>
              <div>
                <div style="display: flex; align-items: center; gap: 6px;">
                  <span class="font-semibold" style="font-size: 14px;">${s.nama}</span>
                  ${s.jabatan ? `<span class="ios-badge blue" style="font-size: 10px; padding: 1px 6px;">${s.jabatan}</span>` : ''}
                </div>
                <div class="ios-nav-subtext">${s.gender === 'L' ? 'Laki-laki' : 'Perempuan'} • NISN: ${s.nisn}</div>
              </div>
            </div>

            <!-- Attendance Switcher Chips -->
            <div style="display: flex; gap: 4px;">
              <button class="ios-badge ${status === 'Hadir' ? 'green' : 'gray'}" style="cursor: pointer; border: none;" onclick="window.store.setSiswaStatus(${s.no}, 'Hadir')">H</button>
              <button class="ios-badge ${status === 'Sakit' ? 'red' : 'gray'}" style="cursor: pointer; border: none;" onclick="window.store.setSiswaStatus(${s.no}, 'Sakit')">S</button>
              <button class="ios-badge ${status === 'Izin' ? 'orange' : 'gray'}" style="cursor: pointer; border: none;" onclick="window.store.setSiswaStatus(${s.no}, 'Izin')">I</button>
              <button class="ios-badge ${status === 'Alpa' ? 'red' : 'gray'}" style="cursor: pointer; border: none;" onclick="window.store.setSiswaStatus(${s.no}, 'Alpa')">A</button>
            </div>
          </div>`;
      });
      container.innerHTML = html;
    }
  }
}

// ----------------------------------------------------
// 6. STRUKTUR ORGANISASI RENDERER
// ----------------------------------------------------
function renderStruktur() {
  const list = window.store.data.struktur || [];
  const container = document.getElementById('struktur-list-container');
  if (container) {
    let html = '';
    list.forEach(item => {
      html += `
        <div class="ios-list-item">
          <div style="display: flex; align-items: center;">
            <div class="ios-icon-well purple" style="width: 32px; height: 32px;">
              ${getIcon('hierarchy', 17)}
            </div>
            <div>
              <div class="font-semibold" style="font-size: 14px;">${item.nama}</div>
              <div class="ios-nav-subtext">${item.jabatan} • ${item.sub || ''}</div>
            </div>
          </div>
          <span class="ios-badge gray">${item.kontak}</span>
        </div>`;
    });
    container.innerHTML = html;
  }
}

// ----------------------------------------------------
// MODAL CONTROLLERS
// ----------------------------------------------------
function openModalTugas() {
  const modal = document.getElementById('modal-tugas');
  if (modal) modal.classList.add('open');
}

function closeModalTugas() {
  const modal = document.getElementById('modal-tugas');
  if (modal) modal.classList.remove('open');
}

function openModalKas(tipe = 'masuk') {
  const modal = document.getElementById('modal-kas');
  const tipeInput = document.getElementById('kas-input-tipe');
  const titleEl = document.getElementById('modal-kas-title');
  const katSelect = document.getElementById('kas-input-kategori');
  const submitBtn = document.getElementById('kas-submit-btn');

  if (tipeInput) tipeInput.value = tipe;

  if (katSelect) {
    if (tipe === 'masuk') {
      katSelect.innerHTML = `
        <option value="Iuran Kas">Iuran Kas Mingguan</option>
        <option value="Donasi / Sukarela">Donasi / Sukarela</option>
        <option value="Dana Usaha">Dana Usaha Kelas</option>
        <option value="Sisa Kegiatan">Sisa Kegiatan / Kembalian</option>
        <option value="Lainnya">Lainnya</option>
      `;
      if (titleEl) titleEl.textContent = 'Catat Kas Masuk (Pemasukan)';
      if (submitBtn) {
        submitBtn.className = 'ios-button';
        submitBtn.textContent = 'Simpan Pemasukan';
      }
    } else {
      katSelect.innerHTML = `
        <option value="ATK Kelas">ATK Kelas (Spidol/Penghapus)</option>
        <option value="Perlengkapan">Perlengkapan Kebersihan</option>
        <option value="Dekorasi & P3K">Dekorasi Ruang & Obat P3K</option>
        <option value="Fotokopi">Fotokopi Modul / Bahan Ajar</option>
        <option value="Sosial & Jenguk">Dana Sosial & Menjenguk</option>
        <option value="Lainnya">Lainnya</option>
      `;
      if (titleEl) titleEl.textContent = 'Catat Pengeluaran Kas';
      if (submitBtn) {
        submitBtn.className = 'ios-button destructive';
        submitBtn.textContent = 'Simpan Pengeluaran';
      }
    }
  }

  if (modal) modal.classList.add('open');
}

function closeModalKas() {
  const modal = document.getElementById('modal-kas');
  if (modal) modal.classList.remove('open');
}

// ----------------------------------------------------
// THEME & BACKUP CONTROLLERS
// ----------------------------------------------------
function updateThemeIcon() {
  const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
  const iconContainer = document.getElementById('theme-icon-container');
  const switchDark = document.getElementById('switch-dark-mode');
  const themeMeta = document.getElementById('theme-color-meta');

  if (iconContainer) {
    iconContainer.innerHTML = isDark ? getIcon('sun', 19) : getIcon('moon', 19);
  }
  if (switchDark) {
    switchDark.checked = isDark;
  }
  if (themeMeta) {
    themeMeta.setAttribute('content', isDark ? '#000000' : '#F2F2F7');
  }
}

function handleExportData() {
  const jsonStr = window.store.exportJSON();
  const blob = new Blob([jsonStr], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `backup_kelas_8a_${new Date().toISOString().slice(0, 10)}.json`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

function triggerImportData() {
  const input = document.getElementById('file-import-input');
  if (input) input.click();
}

function handleResetData() {
  if (confirm('Apakah kamu yakin ingin mengembalikan seluruh data ke pengaturan awal Kelas 8A?')) {
    window.store.resetToDefault();
    alert('Data berhasil di-reset ke versi awal.');
  }
}

// ----------------------------------------------------
// EVENT LISTENERS SETUP
// ----------------------------------------------------
function setupEventListeners() {
  // Theme Toggle Button in Navbar
  const themeBtn = document.getElementById('btn-theme-toggle');
  if (themeBtn) {
    themeBtn.addEventListener('click', () => {
      const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
      window.applyTheme(isDark ? 'light' : 'dark');
      updateThemeIcon();
    });
  }

  // Dark Mode Switch in Settings
  const switchDark = document.getElementById('switch-dark-mode');
  if (switchDark) {
    switchDark.addEventListener('change', (e) => {
      window.applyTheme(e.target.checked ? 'dark' : 'light');
      updateThemeIcon();
    });
  }

  // Quick Add Button in Navbar
  const quickAddBtn = document.getElementById('btn-quick-add');
  if (quickAddBtn) {
    quickAddBtn.addEventListener('click', () => {
      if (currentTab === 'kas') openModalKas('masuk');
      else openModalTugas();
    });
  }

  // Tabbar Item Clicks
  document.querySelectorAll('.ios-tab-item').forEach(btn => {
    btn.addEventListener('click', () => {
      const tab = btn.getAttribute('data-tab');
      if (tab) switchTab(tab);
    });
  });

  // Day Selector Clicks (Jadwal)
  document.querySelectorAll('#jadwal-day-selector .ios-segment-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const day = btn.getAttribute('data-day');
      if (day) renderJadwal(day);
    });
  });

  // Tugas Filter Clicks
  document.querySelectorAll('#tugas-filter-selector .ios-segment-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const filter = btn.getAttribute('data-filter');
      if (filter) renderTugas(filter);
    });
  });

  // Kas Filter Clicks
  document.querySelectorAll('#kas-filter-selector .ios-segment-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const filter = btn.getAttribute('data-filter');
      if (filter) renderKas(filter);
    });
  });

  // Info Subview Selector Clicks
  document.querySelectorAll('#info-sub-selector .ios-segment-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const sub = btn.getAttribute('data-sub');
      currentInfoSub = sub;
      document.querySelectorAll('#info-sub-selector .ios-segment-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      document.getElementById('subview-absen').classList.toggle('hidden', sub !== 'absen');
      document.getElementById('subview-struktur').classList.toggle('hidden', sub !== 'struktur');
      document.getElementById('subview-pengaturan').classList.toggle('hidden', sub !== 'pengaturan');
    });
  });

  // Student Search Input
  const searchInput = document.getElementById('siswa-search-input');
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      renderSiswa(e.target.value);
    });
  }

  // Form: Tambah Tugas
  const formTugas = document.getElementById('form-tambah-tugas');
  if (formTugas) {
    formTugas.addEventListener('submit', (e) => {
      e.preventDefault();
      const mapel = document.getElementById('tugas-input-mapel').value;
      const judul = document.getElementById('tugas-input-judul').value;
      const deskripsi = document.getElementById('tugas-input-deskripsi').value;
      const deadline = document.getElementById('tugas-input-deadline').value;
      const prioritas = document.getElementById('tugas-input-prioritas').value;

      window.store.addTugas({ mapel, judul, deskripsi, deadline, prioritas });
      formTugas.reset();
      closeModalTugas();
    });
  }

  // Form: Tambah Kas
  const formKas = document.getElementById('form-tambah-kas');
  if (formKas) {
    formKas.addEventListener('submit', (e) => {
      e.preventDefault();
      const tipe = document.getElementById('kas-input-tipe').value;
      const kategori = document.getElementById('kas-input-kategori').value;
      const nominal = Number(document.getElementById('kas-input-nominal').value);
      const keterangan = document.getElementById('kas-input-keterangan').value;
      const tanggal = document.getElementById('kas-input-tanggal').value;

      window.store.addKas({ tipe, kategori, nominal, keterangan, tanggal });
      formKas.reset();
      closeModalKas();
    });
  }

  // File Import Input
  const fileImport = document.getElementById('file-import-input');
  if (fileImport) {
    fileImport.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (event) => {
          const success = window.store.importJSON(event.target.result);
          if (success) {
            alert('Data cadangan berhasil dipulihkan.');
          } else {
            alert('File cadangan tidak valid atau rusak.');
          }
        };
        reader.readAsText(file);
      }
    });
  }
}
