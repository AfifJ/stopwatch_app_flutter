import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LinkRekomendasiPage extends StatefulWidget {
  const LinkRekomendasiPage({super.key});

  @override
  State<LinkRekomendasiPage> createState() => _LinkRekomendasiPageState();
}

class _LinkRekomendasiPageState extends State<LinkRekomendasiPage> {
  final List<Map<String, dynamic>> linkRekomendations = [
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
      'image': 'https://go.dev/blog/go-brand/Go-Logo/PNG/Go-Logo_Blue.png',
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
      'image':
          'https://assets.stickpng.com/images/5848152fcef1014c0b5e4967.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Rekomendasi'),
      ),
      body: ListView.builder(
        itemCount: linkRekomendations.length,
        itemBuilder: (context, index) {
          final item = linkRekomendations[index];
          return Card(
            child: ListTile(
              leading: Image.network(item['image'], width: 50, height: 50),
              title: Text(item['name']),
              subtitle: Text(item['link']),
              onTap: () {
                FirebaseFirestore.instance.collection('favorite').add({
                  'id': item['id'],
                  'name': item['name'],
                  'link': item['link'],
                  'image': item['image'],
                  'timestamp': FieldValue.serverTimestamp(),
                });
                // Handle link tap
                // You can use url_launcher package to open the link
              },
            ),
          );
        },
      ),
    );
  }
}
