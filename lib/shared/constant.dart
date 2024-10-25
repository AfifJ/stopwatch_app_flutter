import 'package:flutter/material.dart';
import 'package:stopwatch_app/shared/themes.dart';

final List<Map<String, dynamic>> recomendationLinks = [
  {
    'id': 1,
    'name': 'Flutter',
    'link': 'https://flutter.dev/',
    'image':
        'https://static-00.iconduck.com/assets.00/flutter-icon-1651x2048-ojswpayr.png',
  },
  {
    'id': 2,
    'name': 'Java',
    'link': 'https://www.java.com/en/',
    'image': 'https://cdn-icons-png.flaticon.com/512/5968/5968282.png',
  },
  {
    'id': 3,
    'name': 'PHP',
    'link': 'https://www.php.net/',
    'image': 'https://cdn-icons-png.flaticon.com/512/5968/5968332.png',
  },
  {
    'id': 4,
    'name': 'Laravel',
    'link': 'https://laravel.com/',
    'image':
        'https://static-00.iconduck.com/assets.00/laravel-icon-995x1024-dk77ahh4.png',
  },
  {
    'id': 5,
    'name': 'Dart',
    'link': 'https://dart.dev/',
    'image':
        'https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/dart-programming-language-icon.png',
  },
  {
    'id': 6,
    'name': 'Golang',
    'link': 'https://go.dev/',
    'image':
        'https://w7.pngwing.com/pngs/566/160/png-transparent-golang-hd-logo-thumbnail.png',
  },
  {
    'id': 7,
    'name': 'Vue',
    'link': 'https://vuejs.org/',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Vue.js_Logo_2.svg/1200px-Vue.js_Logo_2.svg.png',
  },
  {
    'id': 8,
    'name': 'React',
    'link': 'https://react.dev/',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png',
  },
  {
    'id': 9,
    'name': 'Javascript',
    'link': 'https://developer.mozilla.org/en-US/docs/Web/JavaScript',
    'image':
        'https://academy.alterra.id/blog/wp-content/uploads/2021/07/Logo-Javascript.png',
  },
  {
    'id': 10,
    'name': 'Python',
    'link': 'https://www.python.org/',
    'image': 'https://assets.stickpng.com/images/5848152fcef1014c0b5e4967.png',
  }
];

final List<Map<String, String>> helpItems = [
  {
    'title': '1. Daftar Dulu!',
    'description':
        'Langkah pertama, tekan "Daftar", isi data diri, dan klik "Submit". Selamat, kamu anggota VIP! 😎',
  },
  {
    'title': '2. Login 🔑',
    'description':
        'Masukkan email dan password yang tadi dibuat. Jangan salah, nanti kesel sendiri! Akses fitur keren langsung!',
  },
  {
    'title': '3. Pilih Menu 🍽️',
    'description':
        'Setelah login, pilih menu:\n- Daftar Anggota: Cek teman-teman pengguna.\n- Stopwatch: Ukur waktu, jangan kelamaan.\n- Rekomendasi Situs: Jelajahi situs keren.\n- Favorite: Simpan yang kamu suka. ❤️',
  },
  {
    'title': '4. Enjoy! 🎉',
    'description': 'Sudah selesai? Gampang kan? Kalau bingung, tanya admin.',
  },
];

/*  {
    'title': '1. Daftar Dulu!',
    'description':
      'Langkah pertama, tekan "Daftar", isi data diri, dan klik "Submit". Selamat, kamu anggota VIP! 😎',
    },
    {
    'title': '2. Login 🔑',
    'description':
      'Masukkan email dan password yang tadi dibuat. Jangan salah, nanti kesel sendiri! Akses fitur keren langsung!',
    },
    {
    'title': '3. Pilih Menu 🍽️',
    'description':
      'Setelah login, pilih menu:\n- Daftar Anggota: Cek teman-teman pengguna.\n- Stopwatch: Ukur waktu, jangan kelamaan.\n- Rekomendasi Situs: Jelajahi situs keren.\n- Favorite: Simpan yang kamu suka. ❤️',
    },
    {
    'title': '4. Enjoy! 🎉',
    'description':
      'Sudah selesai? Gampang kan? Kalau bingung, tanya admin.',
    }, */

InputDecoration textInputDecoration(BuildContext context) => InputDecoration(
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
        borderSide: BorderSide(color: AppTheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
        borderSide: BorderSide(color: AppTheme.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
        borderSide: BorderSide(color: AppTheme.danger),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : const Color.fromARGB(244, 235, 235, 235),
      floatingLabelStyle: TextStyle(
          fontSize: 20,
          height: 1.5,
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(244, 224, 224, 224)
              : Colors.grey[900],
          fontWeight: FontWeight.bold),
    );
