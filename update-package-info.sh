#!/bin/zsh

brew leaves > brew_packages.txt
pacman -Qenq > extra_packages_explicit.txt
pacman -Qeqm > aur_packages_explicit.txt

# -v : membuang baris yang cocok
# -F : menganggap input sebagai string biasa (bukan regex)
# -f : mengambil list kata dari file2
# Karena bash tidak bisa menulis ke file yang sedang dibaca secara bersamaan, 
# kita gunakan file sementara .

grep -vFf amd_packages.txt extra_packages_explicit.txt > temp.txt && mv temp.txt extra_packages_explicit.txt
grep -vFf nvidia_packages.txt extra_packages_explicit.txt > temp.txt && mv temp.txt extra_packages_explicit.txt
grep -vFf cpu_packages.txt extra_packages_explicit.txt > temp.txt && mv temp.txt extra_packages_explicit.txt
