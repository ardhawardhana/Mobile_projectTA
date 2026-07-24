# TPQ Darul Ishlah - Monaqosah 📖

Aplikasi mobile pembelajaran dan evaluasi (monaqosah) berbasis gamifikasi untuk santri TPQ (Taman Pendidikan Al-Qur'an) Darul Ishlah. Aplikasi ini dibangun sebagai Tugas Akhir (TA), dengan tujuan membantu santri belajar dan mengikuti ujian materi keagamaan secara interaktif, sekaligus memberikan sistem poin, level, dan reward untuk meningkatkan motivasi belajar.

## ✨ Fitur Utama

- **Autentikasi Akun** — Registrasi dan login santri menggunakan Firebase Authentication (email & password)
- **Dashboard Santri** — Menampilkan progres belajar, poin, level, dan bintang yang telah dikumpulkan
- **Kuis per Kategori** — Santri dapat mengerjakan kuis/tes berdasarkan kategori materi tertentu
- **Hasil & Penilaian Otomatis** — Skor dihitung otomatis, dengan sistem bintang (1-3 ⭐) berdasarkan pencapaian nilai
- **Tantangan Harian (Daily Challenges)** — Misi harian yang memberikan poin tambahan saat diselesaikan
- **Papan Peringkat (Leaderboard)** — Menampilkan ranking santri berdasarkan poin secara real-time
- **Toko Reward (Reward Shop)** — Santri dapat menukarkan poin yang terkumpul dengan reward tertentu
- **Sistem Level & Progress** — Level santri meningkat secara otomatis berdasarkan akumulasi poin

## 🛠️ Tech Stack

| Kategori | Teknologi |
|---|---|
| Framework | [Flutter](https://flutter.dev/) (Dart) |
| Autentikasi | Firebase Authentication |
| Database | Firebase Realtime Database |
| State Management | StreamBuilder (Flutter native) |
| UI/Font | Google Fonts |
| Visualisasi Data | fl_chart |
| Linting | flutter_lints |

Platform yang didukung: **Android, iOS, Web, Windows, macOS, Linux** (multi-platform Flutter project).

## 📂 Struktur Project

```
lib/
├── data/            # Data dummy/mock untuk keperluan development & testing
├── models/          # Model data (AppUser, QuizQuestion, Reward, TestResult, dll)
├── screens/         # Halaman-halaman UI (login, dashboard, kuis, leaderboard, dll)
├── services/        # Logic komunikasi dengan Firebase (AuthService, DatabaseService)
├── theme/           # Konfigurasi warna, tipografi, dan tema aplikasi
├── widgets/         # Reusable widget/komponen UI
├── firebase_options.dart
└── main.dart         # Entry point aplikasi
```

## 🚀 Cara Instalasi & Menjalankan

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi ^3.12.2 atau lebih baru)
- Akun [Firebase](https://firebase.google.com/) beserta project yang sudah dikonfigurasi
- Android Studio / Xcode (untuk emulator) atau perangkat fisik

### Langkah-langkah

1. **Clone repository**
   ```bash
   git clone https://github.com/ardhawardhana/Mobile_projectTA.git
   cd Mobile_projectTA
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Konfigurasi Firebase**

   Project ini menggunakan Firebase (Authentication & Realtime Database). Untuk menjalankan aplikasi dengan project Firebase kamu sendiri:

   - Install [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup)
   - Jalankan `flutterfire configure` di root project, lalu pilih Firebase project kamu
   - Perintah ini akan otomatis meng-generate ulang file `lib/firebase_options.dart` dan `android/app/google-services.json`
   - Pastikan **Authentication (Email/Password)** dan **Realtime Database** sudah diaktifkan di Firebase Console
   - Pastikan Security Rules Realtime Database sudah dikonfigurasi agar hanya user yang login yang bisa membaca/menulis data (lihat bagian Keamanan di bawah)

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

   Atau untuk platform tertentu:
   ```bash
   flutter run -d chrome     # Web
   flutter run -d windows    # Windows
   ```

5. **Build APK (opsional)**
   ```bash
   flutter build apk --release
   ```

## 🔒 Catatan Keamanan

- API key Firebase yang terdapat pada `firebase_options.dart` bersifat publik by design (bukan secret key) — keamanan data sesungguhnya diatur melalui **Firebase Security Rules**, bukan dengan menyembunyikan API key tersebut.
- Disarankan Security Rules Realtime Database dikonfigurasi agar hanya user yang sudah login (`auth != null`) yang dapat membaca/menulis data, dan setiap user hanya bisa menulis pada datanya sendiri.

## 👥 Kontributor

- **Bisma Arya Wardhana** — Pengembang Utama (Fullstack Mobile Development)

## 📄 Lisensi

Project ini dibuat untuk keperluan akademik (Tugas Akhir) dan bukan untuk tujuan komersial.