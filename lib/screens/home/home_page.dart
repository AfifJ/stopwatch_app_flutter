import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/anggota/anggota_page.dart';
import 'package:stopwatch_app/screens/favorite/favorite_page.dart';
import 'package:stopwatch_app/screens/help/help_page.dart';
import 'package:stopwatch_app/screens/rekomendasi/rekomendasi_page.dart';
import 'package:stopwatch_app/screens/stopwatch/stopwatch_page.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/shared/themes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> listMenu = [
    {
      'title': 'Daftar Anggota',
      'menu': const AnggotaPage(),
      'icon': Icons.group,
      'description': 'Lihat daftar anggota yang terlibat dalam aplikasi ini',
      'color': Colors.blue,
      'gradient': [Colors.blue.shade700, Colors.blue.shade900]
    },
    {
      'title': 'Stopwatch',
      'menu': const StopwatchPage(),
      'icon': Icons.timer,
      'description': 'Gunakan stopwatch untuk mengukur waktu dengan akurat',
      'color': Colors.orange,
      'gradient': [Colors.orange.shade700, Colors.orange.shade900]
    },
    {
      'title': 'Rekomendasi Situs',
      'menu': const RekomendasiPage(),
      'icon': Icons.recommend,
      'description': 'Lihat rekomendasi situs yang bermanfaat dan terpercaya',
      'color': Colors.green,
      'gradient': [Colors.green.shade700, Colors.green.shade900]
    },
    {
      'title': 'Favorit',
      'menu': const FavoritePage(),
      'icon': Icons.favorite,
      'description': 'Lihat halaman favorit yang telah Anda simpan sebelumnya',
      'color': Colors.red,
      'gradient': [Colors.red.shade700, Colors.red.shade900]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final user = _auth.currentUser();

    return Scaffold(
      body: _buildBody(user),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(user) {
    List<Widget> _widgetOptions = <Widget>[
      _buildHomePage(user),
      HelpPage(),
    ];

    return _widgetOptions.elementAt(_selectedIndex);
  }

  Widget _buildHomePage(user) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildGreetingCard(user),
                const SizedBox(height: 30),
                Expanded(child: _buildMenuList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingCard(user) {
    // final emailUsername = user.email.toString().split('@')[0];
    // final username =
    //     emailUsername[0].toUpperCase() + emailUsername.substring(1);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.rounded),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mulai Aktivitas Anda, ${user.email}.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Pilih menu di bawah untuk memulai",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.rounded),
            ),
            child: Image(
              image: const AssetImage('assets/images/logo.png'),
              height: 60,
              color: AppTheme.primary,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error_outline, size: 40);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: listMenu.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => listMenu[index]['menu'],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: listMenu[index]['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.rounded),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listMenu[index]['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          listMenu[index]['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    listMenu[index]['icon'],
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onTappedItem,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_rounded),
          label: "Bantuan",
        ),
      ],
      selectedItemColor: Colors.blueAccent,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.white,
    );
  }

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
