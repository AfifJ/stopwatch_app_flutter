import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/shared/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Rekomendasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: recomendationLinks.length,
          itemBuilder: (context, index) {
            final item = recomendationLinks[index];
            return _buildListItem(context, item, user);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, Map<String, dynamic> item, dynamic user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10, top: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red, size: 50);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(item['link'],
                      style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'add_to_favorite') {
                  _addToFavorites(context, item, user);
                } else if (value == 'open_in_browser') {
                  final url = Uri.parse(item['link']);
                  _openInBrowser(url.toString());
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'add_to_favorite',
                    child: Text('Add to Favorite'),
                  ),
                  const PopupMenuItem(
                    value: 'open_in_browser',
                    child: Text('Open in Browser'),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  void _addToFavorites(
      BuildContext context, Map<String, dynamic> item, dynamic user) {
    FirebaseFirestore.instance
        .collection('user_fav')
        .doc(user.uid)
        .collection('favorites')
        .where('id', isEqualTo: item['id'])
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item successfully added')),
        );
        FirebaseFirestore.instance
            .collection('user_fav')
            .doc(user.uid)
            .collection('favorites')
            .add({
          'id': item['id'],
          'name': item['name'],
          'link': item['link'],
          'image': item['image'],
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item already exists in favorites')),
        );
      }
    });
  }

  void _openInBrowser(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
