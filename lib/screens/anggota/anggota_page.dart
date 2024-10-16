import 'package:flutter/material.dart';

class AnggotaPage extends StatelessWidget {
  const AnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar anggota"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnggotaCard(
              context,
              'https://akcdn.detik.net.id/visual/2024/07/16/spongebob-squarepants_169.png?w=400&q=90',
              'Afif Jamhari',
              '124220018',
              'taken',
              'Turu sambil Ngoding',
            ),
            _buildAnggotaCard(
              context,
              'https://64.media.tumblr.com/f6829093a6ee638026b78c1b76e5b653/tumblr_oujjbmTtDI1ue9zkjo6_500.jpg',
              'Habib Maulana Akbar',
              '124220022',
              'Takenan Batin',
              'Ngoding tapi Turu',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnggotaCard(BuildContext context, String imageUrl, String name,
      String nim, String status, String hobby) {
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.yellow[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'NIM\t\t\t\t\t: $nim',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Status\t: $status',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Hobby\t: $hobby',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
