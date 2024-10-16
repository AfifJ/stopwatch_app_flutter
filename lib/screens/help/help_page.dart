import 'package:flutter/material.dart';
import 'package:stopwatch_app/services/auth.dart';

class HelpPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  final List<Map<String, String>> helpItems = [
    {
      'title': '1. Daftar Dulu, Bosku!',
      'description':
          'Ini langkah pertama yang super penting. Tanpa daftar, kamu hanya bisa tatap-tatapan sama aplikasi ini. Jadi, tekan tombol "Daftar" kayak kamu lagi ngejar diskon! 🏃‍♂️💨 Isi data diri, pastikan email dan password-nya mantul (mantap betul), terus klik "Submit". Udah deh, kamu resmi jadi anggota VIP kita! 😎',
    },
    {
      'title': '2. Login untuk Akses VIP 🔑',
      'description':
          'Setelah daftar, langsung login dong. Masukkan email dan password yang tadi kamu buat. Jangan salah masukin password, nanti dibilang "wrong password" trus kesel sendiri! Kalau sudah, kamu bakal langsung diangkat jadi raja, eh maksudnya, bisa pakai fitur-fitur keren di aplikasi ini!',
    },
    {
      'title': '3. Pilih Menu Sesuka Hati 🍽️',
      'description':
          'Begitu login, kamu bakal disambut dengan menu-menu yang bikin hidup lebih asyik. Nih, pilihannya:\n- Daftar Anggota: Pengen tahu siapa aja teman-teman sepengguna aplikasi? Klik menu ini, terus cek daftar anggota. Siapa tahu ketemu gebetan... atau utang yang belum lunas. 😏\n- Stopwatch: Buat kamu yang suka tantangan hidup atau cuma pengen ukur waktu buat mie instan, pakai stopwatch ini. Tekan tombol start, terus nunggu deh. Jangan kelamaan nyentuh tombolnya, nanti kaya nunggu chat doi yang gak balas-balas. ⏱️\n- Rekomendasi Situs: Lagi bosen atau butuh pencerahan dari alam internet? Tenang, kita punya daftar situs rekomendasi yang super keren! Klik, dan langsung terbang ke dunia baru. Jangan kaget kalau tiba-tiba lupa waktu ya, seru soalnya! 😜\n- Favorite: Nah, kalau nemu sesuatu yang menurut kamu keren, klik tombol "favorite"! Nanti semua yang kamu simpan bakal nangkring di sini, jadi gampang kalo mau ngelirik lagi pas kangen~ ❤️',
    },
    {
      'title': '4. Enjoy dan Selamat Bergembira! 🎉',
      'description':
          'Sudah selesai? Hah? Cepet amat. Tenang, pakai aplikasi ini gampang banget kok. Kalau bingung, coba tanya sama diri sendiri, "Kenapa bingung ya?" Kalau masih bingung juga, ya coba tanya lagi (atau tanya admin).',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: helpItems.length,
              itemBuilder: (context, index) {
                final item = helpItems[index];
                return _buildHelpCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cara Pakai',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Aplikasi Super Keren Ini! 🎉',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700],
                ),
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Logout',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(Map<String, String> item, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              item['description']!,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLogoutConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Batal'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                Navigator.of(context).pop(true);
                await _auth.signOut();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
