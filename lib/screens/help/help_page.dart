import 'package:flutter/material.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/shared/constant.dart';
import 'package:stopwatch_app/shared/themes.dart';

class HelpPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: helpItems.length,
                itemBuilder: (context, index) {
                  final item = helpItems[index];
                  return _buildHelpCard(context, item, theme, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cara Pakai',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Aplikasi Super Keren Ini! 🎉',
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _buildLogoutButton(context, theme),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Pelajari cara menggunakan fitur-fitur aplikasi ini dengan panduan berikut:',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.getTextColor(context).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme) {
    return ElevatedButton.icon(
      onPressed: () => _showLogoutConfirmationDialog(context, theme),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.danger,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.rounded),
        ),
      ),
      icon: const Icon(Icons.logout, size: 20),
      label: const Text(
        'Logout',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHelpCard(BuildContext context, Map<String, String> item,
      ThemeData theme, int index) {
    final List<IconData> icons = [
      Icons.timer,
      Icons.group,
      Icons.favorite,
      Icons.recommend,
      Icons.help,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: AppTheme.primary,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.rounded),
                  ),
                  child: Icon(
                    icons[index % icons.length],
                    color: AppTheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description']!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.getTextColor(context).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(
      BuildContext context, ThemeData theme) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.rounded),
        ),
        title: Text(
          'Konfirmasi Logout',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari aplikasi?',
          style: theme.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Batal',
              style: TextStyle(color: AppTheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.rounded),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _auth.signOut();
    }
  }
}
