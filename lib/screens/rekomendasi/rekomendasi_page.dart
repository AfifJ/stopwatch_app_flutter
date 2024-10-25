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
    final theme = Theme.of(context);
    final user = _auth.currentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Rekomendasi'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 60,
                    height: 60,
                    color: theme.colorScheme.surfaceVariant,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.error,
                    size: 40,
                  );
                },
              ),
            ),

            const SizedBox(width: 16),

            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['link'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user_fav')
                      .doc(user.uid)
                      .collection('favorites')
                      .where('id', isEqualTo: item['id'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: theme.colorScheme.error,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('user_fav')
                              .doc(user.uid)
                              .collection('favorites')
                              .where('id', isEqualTo: item['id'])
                              .get()
                              .then((querySnapshot) {
                            for (var doc in querySnapshot.docs) {
                              doc.reference.delete();
                            }

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Removed from favorites'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          });
                        },
                        tooltip: 'Already in favorites',
                      );
                    } else {
                      return IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () => _addToFavorites(context, item, user),
                        tooltip: 'Add to favorites',
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: theme.colorScheme.secondary,
                  ),
                  onPressed: () => _openInBrowser(item['link']),
                  tooltip: 'Open in browser',
                ),
              ],
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
        // Add to favorites
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

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added to favorites'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } else {
        // Show already exists message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Already in favorites'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });
  }

  Future<void> _openInBrowser(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      throw 'Could not launch $url';
    }
  }
}
