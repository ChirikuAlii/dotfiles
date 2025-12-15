# Dotfiles

A personal collection of configuration files (dotfiles) for my development environment. This repository contains setups for the following productivity tools:

- Neovim: The main text editor (using Lua configuration).
- Tmux: A terminal multiplexer for session management.
- Ghostty: A modern terminal emulator (cross-platform).

## Repository Structure

- `nvim/`: The Neovim configuration folder (will be linked to `~/.config/nvim`).
- `tmux/`: Contains `.tmux.conf` (will be linked to `~/.tmux.conf`).
- `ghostty/`: Ghostty configuration for macOS and Linux.
- `setup.sh`: The main installation script.

## How to Use

### 1. Clone Repository

This repository is designed to be placed in a specific path.
**Important**: The `setup.sh` script defaults to `$HOME/1.Code/2.Areas/dotfiles`.

If you clone to that location:
```bash
git clone <URL_REPO> ~/1.Code/2.Areas/dotfiles
cd ~/1.Code/2.Areas/dotfiles
```

*If you saved it to a different location, please edit the `export DOT="..."` line in the `setup.sh` file to match your folder location.*

### 2. Installation (Symlink)

Run the `setup.sh` script to apply the configuration:

```bash
sh setup.sh
```

This script will do the following:
1. Create a symbolic link for **Neovim** in `~/.config/nvim`.
2. Create a symbolic link for **Tmux** in `~/.tmux.conf`.
3. Run the automatic setup for **Ghostty** (detects whether you're using macOS or Linux and selects the appropriate config).