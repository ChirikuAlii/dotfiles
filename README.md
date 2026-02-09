# Dotfiles

Personal dotfiles environment di Linux (Arch-based). Repository ini berisi konfigurasi lengkap window manager dan aplikasinya beserta script instalasinya, kedepan akan ditambahkan untuk yang mac os.

## 📦 Packages Overview

### Window Manager & Desktop

- **Niri** - Scrollable-tiling Wayland compositor
- **Hyprlock** - ScreenLock untuk wayland
- **Waybar** - Customizable status bar untuk Wayland
- **Fuzzel** - Application launcher untuk Wayland
- **Rofi** - Application launcher & window switcher (WIP)
- **Wlogout** - Logout menu untuk Wayland (WIP)
- **Swaybg** - Wallpaper manager untuk Wayland
- **Swayidle** - Idle management daemon
- **GNOME** - Desktop environment sebagai DE cadangan (GDM, settings, etc.)

### Utilities

- **Btop** - Resource monitor
- **Fastfetch** - System information tool
- **Fzf** - Fuzzy finder
- **Zoxide** - Smarter cd command
- **Bat** - Cat clone dengan syntax highlighting
- **Gitu** - Terminal UI untuk Git
- **Cliphist** - Clipboard manager untuk Wayland
- **Kanata** - Keyboard remapper (dengan kanata-tray)
- **Sesh** - Tmux session manager
- **Thunar** - File manager dengan plugins
- **Nautilus** - GNOME file manager
- **Pamac** (AUR) - Package manager GUI
- **Flatpak** - Universal package manager
- **Stow** - Symlink manager untuk dotfiles
- **Snapper** - Btrfs snapshot manager
- **UFW** - Firewall
- **ProtonVPN** - VPN client (CLI & Flatpak GUI)
- **Git** - Version control

### Applications

- **Neovim** - Text editor utama dengan konfigurasi Lua
- **Tmux** - Terminal multiplexer untuk session management
- **Tmuxp** - Template manager untuk tmux sessions (YAML-based)
- **Ghostty** - Modern terminal emulator
- **Zsh** - Shell dengan Oh My Zsh framework
- **Obsidian** - Note-taking & knowledge base
- **Windsurf** - AI-powered code editor
- **Neovide** - Neovim GUI
- **Firefox** - Web browser
- **Zen Browser** (Flatpak) - Privacy-focused browser
- **Chrome** (Flatpak) - Google Chrome
- **Bruno** (Flatpak) - API client
- **Spotify** (Flatpak) - Music streaming
- **Telegram** - Messaging app
- **VLC** (Flatpak) - Media player
- **JetBrains Toolbox** (AUR) - IDE manager
- **Base-devel** - Development tools
- **WPS Office** (AUR) - Office suite
- **Papers** - Document viewer
- **Loupe** - Image viewer

### Themes & Fonts

- **Kvantum** - Qt theme engine
- **Gruvbox Plus Icon Pack** - Icon theme
- **Nerd Fonts** - Patched fonts dengan icons
- **ProFont** - Monospace font
- **JetBrains Mono** - Monospace font
- **Adobe Source Han** - CJK fonts
- **Noto Fonts** - Google fonts

## 🚀 Installation (Linux - Arch-based)

### Prerequisites

```bash
# Update system
sudo pacman -Syu
```

### Install

```bash
# 1. Clone repository
git clone <URL_REPO> ~/1.Code/2.Areas/dotfiles
cd ~/1.Code/2.Areas/dotfiles

# 2. Install terminal & shell environment
bash install-term-shell.sh

# 3. Install all packages
bash install-package.sh

# 4. Apply dotfiles configuration
bash install-dotfiles-config.sh
```

### Manual Steps

Jika ingin install step-by-step:

1. **Terminal & Shell** - Install Ghostty, Zsh, Oh My Zsh, Yay, Pamac
2. **Packages** - Install dari official repo, AUR, dan Flatpak
3. **Dotfiles** - Stow semua konfigurasi ke home directory

### Uninstall

```bash
bash uninstall-dotfiles-config.sh
```

## 📝 Notes

- **Linux-focused**: Konfigurasi utama untuk Arch Linux & derivatives
- **macOS**: Belum di-setup (general config only)
- **Path default**: `$HOME/1.Code/2.Areas/dotfiles`
- **Wayland-native**: Sebagian besar tools untuk Wayland compositor

## 🔄 Update Package Lists

```bash
bash update-package-info.sh
```

Script ini akan update list packages yang terinstall ke file txt untuk backup.
