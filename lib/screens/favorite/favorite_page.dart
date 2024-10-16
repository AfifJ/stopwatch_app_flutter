// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final AuthService _auth = AuthService();
  late Future<QuerySnapshot> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _loadFavorites();
  }

  Future<QuerySnapshot> _loadFavorites() {
    final user = _auth.currentUser();
    return FirebaseFirestore.instance
        .collection('user_fav')
        .doc(user.uid)
        .collection('favorites')
        .get();
  }

  void _removeFavorite(String docId) {
    final user = _auth.currentUser();
    FirebaseFirestore.instance
        .collection('user_fav')
        .doc(user.uid)
        .collection('favorites')
        .doc(docId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item successfully removed'),
        ),
      );
      setState(() {
        _favoritesFuture = _loadFavorites();
      });
    });
  }

  void _confirmRemoveFavorite(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text(
              'Are you sure you want to remove this item from favorites?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Remove'),
              onPressed: () {
                Navigator.of(context).pop();
                _removeFavorite(docId);
              },
            ),
          ],
        );
      },
    );
  }

  void _openInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the link'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites added.'));
          }

          final favorites = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                child: Text('${favorites.length} favorites'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          favorite['image'],
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error,
                                color: Colors.red, size: 50);
                          },
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(favorite['name'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(favorite['link'],
                                style: const TextStyle(color: Colors.blue)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 10),
                                Text(DateFormat('dd MMM yyyy')
                                    .format(favorite['timestamp'].toDate())),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'remove') {
                              _confirmRemoveFavorite(favorite.id);
                            } else if (value == 'open') {
                              _openInBrowser(favorite['link']);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove from favorite'),
                              ),
                              const PopupMenuItem(
                                value: 'open',
                                child: Text('Open in browser'),
                              ),
                            ];
                          },
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
