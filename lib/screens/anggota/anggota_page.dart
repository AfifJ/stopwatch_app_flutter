import 'package:flutter/material.dart';

class AnggotaPage extends StatelessWidget {
  const AnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar anggota"),
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Image.network(
              'https://unsplash.it/400/300',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Image.network(
              'https://unsplash.it/400/301',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
