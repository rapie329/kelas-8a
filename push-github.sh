#!/usr/bin/env bash
set -e

echo "===================================================="
echo "    Setup & Push Otomatis Kelas 8A ke GitHub"
echo "===================================================="
echo ""

# Input username
read -p "Masukkan Username GitHub Anda: " GH_USER
if [ -z "$GH_USER" ]; then
  echo "Username tidak boleh kosong!"
  exit 1
fi

# Input token (hidden input for security)
echo -n "Masukkan GitHub Personal Access Token: "
read -s GH_TOKEN
echo ""

if [ -z "$GH_TOKEN" ]; then
  echo "Token tidak boleh kosong!"
  exit 1
fi

REPO_NAME="kelas-8a"

echo ""
echo "[1/4] Memeriksa / Membuat repository '${REPO_NAME}' di GitHub..."
CREATE_RES=$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer ${GH_TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"${REPO_NAME}\",\"description\":\"Aplikasi Kelas 8A iOS Cupertino (Flutter)\",\"private\":false}")

if [ "$CREATE_RES" -eq 201 ]; then
  echo "Repository '${REPO_NAME}' berhasil dibuat di akun GitHub!"
elif [ "$CREATE_RES" -eq 422 ]; then
  echo "Repository '${REPO_NAME}' sudah ada di akun GitHub (melanjutkan)..."
elif [ "$CREATE_RES" -eq 401 ]; then
  echo "Error: Token GitHub tidak valid atau tidak memiliki izin akses (repo scope)!"
  exit 1
else
  echo "Info status API: ${CREATE_RES} (melanjutkan proses push)..."
fi

echo ""
echo "[2/4] Mengatur remote origin git..."
cd "$(dirname "$0")"
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${REPO_NAME}.git"

echo ""
echo "[3/4] Melakukan push branch main ke GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "[4/4] Mengamankan remote URL lokal..."
# Ganti URL remote agar token tidak tersimpan permanen di file config lokal
git remote set-url origin "https://github.com/${GH_USER}/${REPO_NAME}.git"

echo ""
echo "===================================================="
echo "    BERHASIL! Proyek sudah ter-upload ke GitHub!"
echo "===================================================="
echo ""
echo "Link Repository : https://github.com/${GH_USER}/${REPO_NAME}"
echo "Link Build APK  : https://github.com/${GH_USER}/${REPO_NAME}/actions"
echo ""
echo "GitHub Actions sedang otomatis meng-compile file APK kamu."
echo "Buka link Actions di atas, tunggu sekitar 2-3 menit,"
echo "lalu download file 'Kelas8A-Release-APK' di bagian Artifacts!"
echo "===================================================="
