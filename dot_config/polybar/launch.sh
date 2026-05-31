#!/usr/bin/env bash

# 1. Matikan semua instansi polybar yang sedang berjalan
killall -q polybar

# 2. Tunggu sampai proses benar-benar berhenti
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# 3. Luncurkan Polybar menggunakan nama bar "main" dari config.ini
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar berhasil diluncurkan..."
