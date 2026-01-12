# ✨ Aplikasi Luckydraw

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Dart Analyzer](https://img.shields.io/badge/Dart%20Analyzer-Enabled-blue?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/guides/language/analysis-options)
[![Tests](https://img.shields.io/badge/Tests-Included-success?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/docs/testing)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-orange?style=for-the-badge)](https://flutter.dev/multi-platform)

> Aplikasi multi-platform ini dikembangkan menggunakan Flutter, dirancang untuk mengelola dan menjalankan undian berhadiah (luckydraw) dengan antarmuka pengguna yang menarik, serta mendukung berbagai hadiah.

---

## ✨ Fitur Utama

*   **Undian Berhadiah Interaktif:** Fungsionalitas inti untuk menjalankan undian berhadiah, memungkinkan pengguna untuk berinteraksi dan melihat hasil secara real-time.
*   **Dukungan Multi-Platform:** Dibangun dengan Flutter, aplikasi ini dapat berjalan secara _native_ di Android, iOS, Web, Windows, macOS, dan Linux dari satu basis kode.
*   **Tampilan Hadiah Dinamis:** Mendukung visualisasi berbagai jenis hadiah, seperti jam tangan mewah, pakaian, atau sepatu olahraga, dengan aset gambar yang telah disediakan.
*   **Antarmuka Pengguna Modern:** Menggunakan kerangka kerja UI Flutter untuk menciptakan pengalaman pengguna yang responsif dan estetis.
*   **Struktur Proyek Terorganisir:** Organisasi kode yang jelas, memisahkan logika aplikasi utama dari konfigurasi spesifik platform.
*   **Kode yang Dapat Diuji:** Mencakup _widget tests_ untuk memastikan stabilitas dan fungsionalitas komponen UI aplikasi.

## 🛠️ Tumpukan Teknologi

| Kategori            | Teknologi             | Catatan                                        |
| :------------------ | :-------------------- | :--------------------------------------------- |
| **Kerangka Kerja UI** | Flutter               | Untuk pengembangan aplikasi multi-platform.    |
| **Bahasa Pemrograman** | Dart                  | Bahasa utama untuk logika aplikasi Flutter.    |
| **Manajemen Paket** | Dart `pub`            | Digunakan untuk mengelola dependensi proyek.   |
| **Linter & Analisis** | Dart Analyzer         | Memastikan kualitas dan konsistensi kode.      |
| **Pengujian**       | Flutter Test          | Untuk _unit_ dan _widget testing_.             |
| **Target Platform** | Android, iOS, Web, Windows, macOS, Linux | Dukungan luas untuk berbagai sistem operasi. |

## 🏛️ Tinjauan Arsitektur

Aplikasi Luckydraw ini mengikuti arsitektur standar Flutter, berfokus pada pendekatan _client-side_ yang reaktif dan berbasis _widget_. Ini adalah aplikasi mandiri yang dirancang untuk memberikan pengalaman pengguna yang kaya dan konsisten di berbagai platform tanpa dependensi backend eksplisit yang teridentifikasi. Struktur `lib/app` dan `lib/main.dart` menunjukkan titik masuk utama untuk logika dan UI aplikasi, sedangkan direktori spesifik platform (seperti `android`, `ios`, `web`, `windows`, `linux`, `macos`) berisi konfigurasi dan _runner_ yang diperlukan untuk kompilasi _native_.

## 🚀 Memulai

Ikuti langkah-langkah di bawah ini untuk menyiapkan dan menjalankan proyek ini di lingkungan pengembangan lokal Anda.

### Prasyarat

Pastikan Anda telah menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install) dengan benar.

### Instalasi

1.  **Kloning repositori:**

    ```bash
    git clone https://github.com/Nandz-0/aplikasi_luckydraw.git
    ```

2.  **Masuk ke direktori proyek:**

    ```bash
    cd aplikasi_luckydraw
    ```

3.  **Instal dependensi:**
    Perintah ini akan mengunduh semua paket yang diperlukan yang tercantum dalam `pubspec.yaml`.

    ```bash
    flutter pub get
    ```

4.  **Jalankan aplikasi:**
    Aplikasi akan diluncurkan di perangkat atau emulator yang tersedia.

    ```bash
    flutter run
    ```

## 📂 Struktur File

```
/
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── android                                 # Konfigurasi dan file proyek untuk target platform Android.
│   ├── .gitignore
│   └── app
│       └── src
│           ├── debug
│           ├── main
│           │   ├── AndroidManifest.xml
│           │   ├── kotlin                  # Kode Kotlin untuk integrasi Android.
│           │   └── res                     # Sumber daya Android (gambar, layout, dll.).
│           └── profile
├── assets                                  # Berkas aset statis seperti gambar.
│   └── images                              # Gambar hadiah untuk undian.
├── ios                                     # Konfigurasi dan file proyek untuk target platform iOS.
│   ├── .gitignore
│   ├── Flutter
│   ├── Runner.xcodeproj
│   ├── Runner.xcworkspace
│   └── Runner                              # Kode Swift dan sumber daya untuk integrasi iOS.
├── lib                                     # Kode sumber utama aplikasi Flutter (Dart).
│   ├── app                                 # Modul atau fitur aplikasi inti.
│   └── main.dart                           # Titik masuk utama aplikasi.
├── linux                                   # Konfigurasi dan file proyek untuk target platform Linux.
│   ├── .gitignore
│   └── flutter
├── macos                                   # Konfigurasi dan file proyek untuk target platform macOS.
│   ├── .gitignore
│   └── Flutter
├── pubspec.lock
├── pubspec.yaml                            # File konfigurasi proyek Flutter dan manajemen dependensi.
├── test                                    # Berkas pengujian unit dan widget.
│   └── widget_test.dart                    # Contoh tes widget.
├── web                                     # Konfigurasi dan file proyek untuk target platform Web.
│   ├── favicon.png
│   ├── icons
│   ├── index.html
│   └── manifest.json
└── windows                                 # Konfigurasi dan file proyek untuk target platform Windows.
    ├── .gitignore
    └── flutter
```
