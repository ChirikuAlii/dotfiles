put to .zshenv

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt6ct

install pacman qt6ct qt5ct kvantum

setup flatpak
flatpak install org.kde.KStyle.Kvantum

flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro

gui nya pakai flatseal

install kvantum theme
qt6ct dan qt5ct ganti ke style pakai kvantum
pilih tema nya
