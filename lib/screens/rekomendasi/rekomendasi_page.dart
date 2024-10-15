import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopwatch_app/shared/constant.dart';

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Rekomendasi'),
      ),
      body: ListView.builder(
        itemCount: recomendationLinks.length,
        itemBuilder: (context, index) {
          final item = recomendationLinks[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                item['image'],
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Text("Error");
                },
              ),
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
