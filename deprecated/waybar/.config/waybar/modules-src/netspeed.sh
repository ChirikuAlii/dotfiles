#!/bin/bash

# Auto-detect the active network interface
IFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

if [ -z "$IFACE" ]; then
    echo "{\"text\": \"[  0.00 KB/s ]\", \"tooltip\": \"󰛳 Interface: $IFACE\n Download: 0.00 KB/s\n Upload: 0.00 KB/s\"}"
    exit 1
fi

# Fungsi konversi: dimulai dari KB/s, di bawah itu jadi 0
format_speed() {
    local bytes=$1
    # Jika di bawah 1024 bytes (1 KB), anggap 0
    if [ "$bytes" -lt 1024 ]; then
        echo "0.00 KB/s"
    else
        echo "$bytes" | awk '{
            split("KB/s MB/s GB/s TB/s", unit, " ");
            # Konversi awal ke KB
            val = $1 / 1024;
            i = 1;
            # Cari satuan yang pas
            while(val >= 1024 && i < 4) {
                val /= 1024;
                i++;
            }
            printf "%.2f %s", val, unit[i]
        }'
    fi
}

while true; do
    # Ambil data RX/TX awal
    RX1=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
    TX1=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
    
    sleep 1
    
    # Ambil data RX/TX setelah 1 detik
    RX2=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
    TX2=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
    
    # Hitung selisih bytes
    RX_DIFF=$((RX2 - RX1))
    TX_DIFF=$((TX2 - TX1))
    
    # Format output
    RX_OUT=$(format_speed $RX_DIFF)
    TX_OUT=$(format_speed $TX_DIFF)
    
    echo "{\"text\": \"[  $RX_OUT ]\", \"tooltip\": \"󰛳 Interface: $IFACE\n Download: $RX_OUT\n Upload: $TX_OUT\"}"
done
