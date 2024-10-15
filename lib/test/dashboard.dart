import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaftarMobil extends StatelessWidget {
  final CollectionReference _mobilCollection =
      FirebaseFirestore.instance.collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Link'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _mobilCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final doc = data.docs[index];
              return ListTile(
                leading: Image.network(doc['image']),
                title: Text(doc['name']),
                subtitle: Text(doc['link']),
                onTap: () {
                  _mobilCollection.doc(doc.id).delete().then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item deleted')),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete item: $error')),
                    );
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
