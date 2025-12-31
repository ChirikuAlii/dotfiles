## Dotfiles
A personal collection of configuration files (dotfiles) for my development environment. This repository contains setups for the following productivity tools:

- Neovim: The main text editor (using Lua configuration).
- Tmux: A terminal multiplexer for session management.
- Ghostty: A modern terminal emulator (cross-platform).
- Tmuxp : Plugin tmux to handle session and create template each session using yaml

#### Development Note 
This dotfiles collection is a constantly evolving project. As the development area expands, this configuration will be updated and improved.

#### Next To Do 
Create installation scripts for Software Development Kits (SDKs) like Java, Flutter, and other tools to simplify onboarding on new machines.

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

### 2. Installation (Stow)

Run the `setup.sh` script to apply the configuration:

```bash
sh setup.sh
```

This script will do the following:
1. Create a stow for **Neovim** in `~/.config/nvim`.
2. Create a stow for **Tmux** in `~/.tmux.conf`.
3. Run the setup for **Ghostty** (Selects the appropriate config whether you're using macOS or Linux).
4. Create a stow for **Tmuxp** in `~/.tmuxp`
