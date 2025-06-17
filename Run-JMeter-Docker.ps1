# Script untuk menjalankan JMeter menggunakan Docker

# Pastikan direktori hasil ada
if (-not (Test-Path -Path "jmeter_results")) {
    New-Item -ItemType Directory -Path "jmeter_results" | Out-Null
}

Write-Host "Menjalankan pengujian JMeter dengan Docker"
Write-Host "==========================================="
Write-Host ""

Write-Host "Memilih jumlah pengguna:"
Write-Host "1. 100 Users"
Write-Host "2. 500 Users"
Write-Host "3. 1000 Users"
Write-Host "4. 5000 Users"
Write-Host "5. 10000 Users"
Write-Host ""

$choice = Read-Host "Masukkan pilihan Anda (1-5)"

$USER_COUNT = 100
$FILENAME = "cargo_tracker_100_users"

switch ($choice) {
    1 {
        $USER_COUNT = 100
        $FILENAME = "cargo_tracker_100_users"
    }
    2 {
        $USER_COUNT = 500
        $FILENAME = "cargo_tracker_500_users"
    }
    3 {
        $USER_COUNT = 1000
        $FILENAME = "cargo_tracker_1000_users"
    }
    4 {
        $USER_COUNT = 5000
        $FILENAME = "cargo_tracker_5000_users"
    }
    5 {
        $USER_COUNT = 10000
        $FILENAME = "cargo_tracker_10000_users"
    }
    default {
        Write-Host "Pilihan tidak valid. Menggunakan default: 100 Users"
    }
}

Write-Host ""
Write-Host "Menjalankan pengujian dengan $USER_COUNT pengguna..."
Write-Host ""

# Mendapatkan IP host
$HOST_IP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Ethernet*" | Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"}).IPAddress
if (-not $HOST_IP) {
    $HOST_IP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Wi-Fi*" | Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"}).IPAddress
}
if (-not $HOST_IP) {
    $HOST_IP = "localhost"
}

# Jalur absolut untuk direktori saat ini dan direktori hasil
$CURRENT_DIR = (Get-Location).Path
$RESULTS_DIR = Join-Path $CURRENT_DIR "jmeter_results"

# Jalankan JMeter menggunakan Docker
docker run --name jmeter-test --rm -v "${CURRENT_DIR}:/jmeter" -v "${RESULTS_DIR}:/results" justb4/jmeter:5.5 `
    -n -t /jmeter/cargotracker_test_plan.jmx `
    -l /results/${FILENAME}_results.jtl `
    -e -o /results/${FILENAME}_report `
    -Jhost=$HOST_IP

Write-Host ""
Write-Host "Pengujian selesai. Hasil disimpan di jmeter_results/${FILENAME}_results.jtl"
Write-Host "Laporan HTML dibuat di jmeter_results/${FILENAME}_report"
Write-Host ""

Read-Host "Tekan Enter untuk keluar"
