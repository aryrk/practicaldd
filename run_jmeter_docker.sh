#!/bin/bash
# Script untuk menjalankan JMeter menggunakan Docker

# Pastikan direktori hasil ada
mkdir -p jmeter_results

echo "Menjalankan pengujian JMeter dengan Docker"
echo "==========================================="
echo ""

echo "Memilih jumlah pengguna:"
echo "1. 100 Users"
echo "2. 500 Users"
echo "3. 1000 Users"
echo "4. 5000 Users"
echo "5. 10000 Users"
echo ""

read -p "Masukkan pilihan Anda (1-5): " choice

USER_COUNT=100
FILENAME="cargo_tracker_100_users"

case $choice in
  1)
    USER_COUNT=100
    FILENAME="cargo_tracker_100_users"
    ;;
  2)
    USER_COUNT=500
    FILENAME="cargo_tracker_500_users"
    ;;
  3)
    USER_COUNT=1000
    FILENAME="cargo_tracker_1000_users"
    ;;
  4)
    USER_COUNT=5000
    FILENAME="cargo_tracker_5000_users"
    ;;
  5)
    USER_COUNT=10000
    FILENAME="cargo_tracker_10000_users"
    ;;
  *)
    echo "Pilihan tidak valid. Menggunakan default: 100 Users"
    ;;
esac

echo ""
echo "Menjalankan pengujian dengan $USER_COUNT pengguna..."
echo ""

# Jalankan JMeter menggunakan Docker
docker run --name jmeter-test --rm -v "$(pwd):/jmeter" -v "$(pwd)/jmeter_results:/results" justb4/jmeter:5.5 \
  -n -t /jmeter/cargotracker_test_plan.jmx \
  -l /results/${FILENAME}_results.jtl \
  -e -o /results/${FILENAME}_report \
  -Jhost=$(hostname -i)

echo ""
echo "Pengujian selesai. Hasil disimpan di jmeter_results/${FILENAME}_results.jtl"
echo "Laporan HTML dibuat di jmeter_results/${FILENAME}_report"
echo ""
