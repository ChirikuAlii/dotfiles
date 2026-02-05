#!/bin/bash

# ==========================================
# KONFIGURASI PATH
# ==========================================
DOTFILES="$HOME/1.Code/2.Areas/dotfiles/linux"
LOG_FILE="install-packages.log"

# Agar script berhenti jika ada error (safety first)
set -e 

# Fungsi print simpel agar log terbaca enak
log() {
    echo -e "\n\033[1;34m===> $1 \033[0m"
}


# ==========================================
# 4. INSTALL SISA PAKET (RESTORE)
# ==========================================

log "Restore Paket Official (Arch Repo)..."
cd "$DOTFILES/.."
if [ -f "official_explicit.txt" ]; then
    sudo pacman -S --needed --noconfirm - < official_explicit.txt
fi

log "Restore Paket AUR..."
if [ -f "aur_explicit.txt" ]; then
    yay -S --needed --noconfirm - < aur_explicit.txt
fi

log "Restore Paket Flatpak..."
if [ -f "flathub_packages.txt" ] && command -v flatpak &> /dev/null; then
    xargs -a flathub_packages.txt flatpak install --or-update -y
fi


log "Instalasi Selesai!"
echo "next run install-dotfiles-config"


 
