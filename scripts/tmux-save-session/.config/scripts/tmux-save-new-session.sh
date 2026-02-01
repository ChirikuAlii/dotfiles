#!/bin/zsh

# 1. Minta input dari user
# echo -n "name session: "
name_session=$(tmux display-message -p '#S')

echo -n "start save session :" $name_session
tmuxp freeze --force --yes $name_session 

# tmux display-message "Sukses dibuat sesinya $name_session"
# # 2. Jalankan perintah dan tangkap outputnya
# # Kita gunakan 'eval' agar bisa menjalankan alias atau pipe (|)
# output=$(eval $cmd 2>&1)
#  exit_code=$?
# #input read value nya lakukan command nya 
# # sukses tmux display-message 
# # keluar dari situ 
# # 3. Cek apakah sukses (exit code 0)
# if [ $exit_code -eq 0 ]; then
#     echo "\n✅ SUCCESS!"
#     echo "------------------------------"
#     echo "$output"
#     echo "------------------------------"
#     # Mengirim pesan ke status bar tmux juga sebagai notifikasi
#     tmux display-message "Command '$cmd' sukses dijalankan!"
# else
#     echo "\n❌ FAILED!"
#     echo "------------------------------"
#     echo "$output"
# fi
#
# # 4. Gunakan read agar window tidak langsung tertutup
# echo "\nTekan [Enter] untuk keluar..."
# read
