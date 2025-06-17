# Petunjuk Penggunaan JMeter untuk Pengujian Beban Aplikasi Cargo Tracker

## Pendahuluan

Dokumen ini berisi petunjuk lengkap untuk melakukan pengujian beban pada aplikasi Cargo Tracker menggunakan Apache JMeter. Pengujian ini dirancang untuk mensimulasikan beberapa skenario beban dengan jumlah pengguna yang berbeda (100, 500, 1000, 5000, dan 10000) untuk mengevaluasi kinerja dan skalabilitas aplikasi.

## Prasyarat

1. Java 8 atau lebih tinggi harus terinstal di komputer Anda
2. Aplikasi Cargo Tracker harus sudah berjalan (semua microservice aktif)
3. Apache JMeter sudah diunduh dan diekstrak

## Struktur File

- `cargotracker_test_plan.jmx` - File test plan JMeter
- `run_jmeter_test.bat` - Script untuk menjalankan satu skenario pengujian
- `run_jmeter_all_scenarios.bat` - Script untuk menjalankan semua skenario pengujian secara berurutan
- `start_jmeter_gui.bat` - Script untuk membuka JMeter dalam mode GUI

## Skenario Pengujian

Test plan ini berisi skenario pengujian yang mewakili proses bisnis utama dalam aplikasi Cargo Tracker:

1. **Book Cargo** - Pemesanan kargo baru dengan detail asal, tujuan, dan tenggat waktu
2. **Find Optimal Route** - Pencarian rute optimal untuk kargo
3. **Register Handling Event** - Mendaftarkan aktivitas penanganan kargo (misalnya: RECEIVE)
4. **Track Cargo** - Melacak status dan lokasi kargo

## Menjalankan Pengujian

### Metode 1: Menggunakan mode GUI

1. Jalankan `start_jmeter_gui.bat`
2. JMeter akan terbuka dengan test plan sudah dimuat
3. Sesuaikan parameter pengujian jika diperlukan
4. Jalankan pengujian dengan mengklik tombol "Start" (panah hijau)

### Metode 2: Menjalankan satu skenario pengujian

1. Jalankan `run_jmeter_test.bat`
2. Pilih jumlah pengguna yang ingin disimulasikan (1-5)
3. Tunggu hingga pengujian selesai
4. Hasil akan disimpan di folder `jmeter_results`

### Metode 3: Menjalankan semua skenario pengujian

1. Jalankan `run_jmeter_all_scenarios.bat`
2. Script akan menjalankan semua skenario pengujian secara berurutan
3. Tunggu hingga semua pengujian selesai (ini bisa memakan waktu yang cukup lama)
4. Hasil untuk setiap skenario akan disimpan di folder `jmeter_results`

## Menafsirkan Hasil

Setelah pengujian selesai, JMeter akan menghasilkan beberapa file:

1. File `.jtl` - Data hasil pengujian mentah
2. Laporan HTML - Laporan visual yang mudah dibaca

Laporan HTML dapat dilihat dengan membuka file `index.html` dalam folder hasil pengujian masing-masing skenario.

Metrik penting yang perlu diperhatikan:

- **Throughput** - Jumlah permintaan per detik yang ditangani oleh sistem
- **Response Time** - Waktu yang dibutuhkan untuk menerima respons dari server
- **Error Rate** - Persentase permintaan yang gagal
- **CPU & Memory Usage** - Penggunaan sumber daya sistem

## Skenario Skalabilitas

Test plan ini menyediakan lima skenario untuk menguji skalabilitas aplikasi:

1. **100 Users**: Beban rendah, cocok untuk pengujian dasar
2. **500 Users**: Beban menengah
3. **1000 Users**: Beban tinggi
4. **5000 Users**: Beban sangat tinggi, cocok untuk stress testing
5. **10000 Users**: Beban ekstrim, untuk menguji batas kemampuan sistem

Setiap skenario menggunakan skenario bisnis yang sama tetapi dengan jumlah pengguna simultan yang berbeda dan waktu ramp-up yang sesuai.

## Tips Pengujian

1. **Mulai dengan beban rendah** - Selalu mulai pengujian dengan 100 pengguna untuk memastikan test plan berjalan dengan baik
2. **Pantau resource sistem** - Pastikan komputer pengujian memiliki sumber daya yang cukup untuk menjalankan pengujian dengan beban tinggi
3. **Sesuaikan ramp-up time** - Untuk pengujian dengan beban tinggi, gunakan waktu ramp-up yang lebih lama untuk menghindari spike
4. **Jalankan dalam mode headless** - Untuk pengujian dengan beban tinggi, selalu gunakan mode non-GUI
5. **Validasi data pengujian** - Pastikan data yang digunakan dalam pengujian valid dan dapat digunakan oleh aplikasi

## Penyesuaian Test Plan

Jika Anda ingin menyesuaikan test plan:

1. Buka JMeter dalam mode GUI
2. Ubah parameter seperti jumlah pengguna, waktu ramp-up, atau loop count
3. Modifikasi HTTP Request untuk menyesuaikan dengan endpoint API yang ingin diuji
4. Tambahkan ekstraksi data atau validasi jika diperlukan
5. Simpan perubahan dan jalankan pengujian

## Contoh Skenario Bisnis Tambahan

Berikut adalah skenario bisnis tambahan yang dapat diimplementasikan:

1. **Change Destination** - Mengubah tujuan kargo yang sudah dipesan
2. **Complete Journey** - Mensimulasikan seluruh perjalanan kargo dari asal ke tujuan
3. **Concurrent Operations** - Menjalankan berbagai operasi secara bersamaan untuk menguji konkurensi
