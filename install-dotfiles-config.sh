#!/bin/bash

# ==========================================
# KONFIGURASI PATH
# ==========================================
DOTFILES="$HOME/1.Code/2.Areas/dotfiles/linux"
LOG_FILE="install-dotfiles-config.log"

# Agar script berhenti jika ada error (safety first)
set -e 

# Fungsi print simpel agar log terbaca enak
log() {
    echo -e "\n\033[1;34m===> $1 \033[0m"
}

# ==========================================
# 5. STOW SISA DOTFILES
# ==========================================

log "Stowing All Dotfiles..."
cd "$DOTFILES"

# List folder yang ingin di-stow (eksplisit lebih aman daripada stow *)
# Sesuaikan list ini dengan folder kamu
STOW_FOLDERS=(
    "btop"
    "Thunar"
    "fontconfig"
    "ghostty-linux"
    "hypr"
    "niri"
    "systemd"
    "wallpapers"
    "waybar"
    "fonts"
)

for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        log "Stowing $folder..."
        stow -v -R -t "$HOME" "$folder"
    fi
done


cd "$DOTFILES/icons"
folder="gruvbox-plus-icon-pack"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

cd "$DOTFILES/scripts"
folder="swaybg-slideshow"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"


cd "$DOTFILES/scripts"
folder="niri-window-title"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

cd "$DOTFILES/scripts"
folder="tmux-sessionizer"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"


cd "$DOTFILES/themes"
folder="config"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"


cd "$DOTFILES/.."
folder="kanata"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

cd "$DOTFILES/.."
folder="neovim"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

cd "$DOTFILES/.."
folder="tmux"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

cd "$DOTFILES/.."
folder="tmuxp"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

# ==========================================
# 6. SELESAI
# ==========================================

log "Instalasi Selesai!"
echo "PENTING: Silakan ganti Theme/Appearance secara manual jika belum sesuai."
echo "Script selesai."


 
