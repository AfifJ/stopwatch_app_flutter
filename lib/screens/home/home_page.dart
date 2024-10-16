import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/anggota/anggota_page.dart';
import 'package:stopwatch_app/screens/favorite/favorite_page.dart';
import 'package:stopwatch_app/screens/help/help_page.dart';
import 'package:stopwatch_app/screens/rekomendasi/rekomendasi_page.dart';
import 'package:stopwatch_app/screens/stopwatch/stopwatch_page.dart';
import 'package:stopwatch_app/services/auth.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> listMenu = [
    {'title': 'Daftar anggota', 'menu': AnggotaPage(), 'icon': Icons.group},
    {'title': 'Stopwatch', 'menu': StopwatchPage(), 'icon': Icons.timer},
    {
      'title': 'Rekomendasi situs',
      'menu': RekomendasiPage(),
      'icon': Icons.recommend
    },
    {'title': 'Favorit', 'menu': FavoritePage(), 'icon': Icons.favorite}
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
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(user),
            SizedBox(height: 20),
            Expanded(child: _buildMenuList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Text(
              "Logged in as ${user.email}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Image(
          image: AssetImage('assets/images/logo.png'),
          height: 100,
          color: Colors.orange,
          errorBuilder: (context, error, stackTrace) {
            return Text(error.toString());
          },
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: listMenu.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Card(
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: MaterialButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return listMenu[index]['menu'] as Widget;
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      listMenu[index]['icon'] as IconData,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(width: 20),
                    Text(
                      listMenu[index]['title'] as String,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  NavigationBar _buildBottomNavigationBar() {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.help), label: "Help"),
      ],
      onDestinationSelected: _onTappedItem,
      selectedIndex: _selectedIndex,
      indicatorColor: Colors.orange,
    );
  }

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
