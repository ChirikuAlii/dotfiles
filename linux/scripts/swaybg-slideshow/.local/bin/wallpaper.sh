#!/bin/bash

# Folder tempat koleksi wallpaper kamu
WALL_DIR="$HOME/Pictures/wallpapers/"
cd "$WALL_DIR" || { echo "Gagal masuk ke direktori"; exit 1; }
while true; do
    # Ambil satu file gambar secara acak
    # WALLPAPER=$(find "$WALL_DIR" -type f | shuf -n1)
    WALLPAPER=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n1)
    # Jalankan swaybg di background
    # --mode fill memastikan gambar memenuhi layar
    swaybg -i "$WALLPAPER" -m fill &
    
    # Simpan PID proses swaybg yang baru saja dijalankan
    NEXT_PID=$!

    # Berikan jeda waktu sebelum ganti wallpaper (misal 5 menit)
    sleep 300

    # Matikan proses swaybg sebelumnya agar resource tetap bersih
    # Kita menggunakan pkill untuk memastikan tidak ada swaybg ganda
    pkill swaybg
done
