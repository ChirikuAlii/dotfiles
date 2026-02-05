#!/bin/bash

# ==========================================
# KONFIGURASI PATH
# ==========================================
DOTFILES="$HOME/1.Code/2.Areas/dotfiles/linux"
LOG_FILE="install-term-shell.log"

# Agar script berhenti jika ada error (safety first)
set -e 

# Fungsi print simpel agar log terbaca enak
log() {
    echo -e "\n\033[1;34m===> $1 \033[0m"
}

# ==========================================
# 1. SHELL & PACKAGE MANAGER EKSTERNAL
# ==========================================

log "Menginstall Oh My Zsh..."
# Menggunakan --unattended agar tidak masuk ke shell zsh di tengah script
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh sudah terinstall."
fi

log "Menginstall Linuxbrew (Homebrew)..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Setup path sementara untuk sesi ini
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Linuxbrew sudah terinstall."
fi

# ==========================================
# 2. TERMINAL & INITIAL CONFIG
# ==========================================

log "Menginstall Ghostty..."
# Catatan: Jika Ghostty ada di AUR, pastikan Yay terinstall DULUAN atau gunakan binary.
# Asumsi di sini: Ghostty ada di repo (misal: chaotic-aur) atau install manual binary.
sudo pacman -S --noconfirm --needed ghostty || echo "Gagal install Ghostty via pacman, lewati..."

log "Stow Config: Ghostty & Zsh..."
# Asumsi folder di dotfiles bernama 'ghostty' dan 'zsh'
cd "$DOTFILES"
stow -v -t "$HOME" ghostty-linux
stow -v -t "$HOME" zsh

# ==========================================
# 3. AUR HELPER & GUI
# ==========================================

log "Menginstall Yay (AUR Helper)..."
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$DOTFILES"
else
    echo "Yay sudah terinstall."
fi

log "Menginstall Pamac..."
yay -S --noconfirm pamac-aur

log "Instalasi Selesai!"
echo "next run install-packages"

