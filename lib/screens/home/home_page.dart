import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/anggota/anggota_page.dart';
import 'package:stopwatch_app/screens/favorite/favorite_page.dart';
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

  final listMenu = [
    {'title': 'Daftar anggota', 'menu': AnggotaPage()},
    {'title': 'Stopwatch', 'menu': StopwatchPage()},
    {
      'title': 'Rekomendasi situs',
      'menu': RekomendasiPage(),
    },
    {'title': 'Favorit', 'menu': FavoritePage()}
  ];

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final user = _auth.currentUser();

    List<Widget> _widgetOptions = <Widget>[
      Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged in as ${user.email}"),
            Expanded(
              child: ListView.builder(
                  itemCount: listMenu.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return listMenu[index]['menu'] as Widget;
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(listMenu[index]['title'] as String),
                            )));
                  }),
            ),
          ],
        ),
      ),
      Center(
        child: MaterialButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text("Log out"),
        ),
      )
    ];

    void _onTappedItem(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.help), label: "Help")
        ],
        onDestinationSelected: _onTappedItem,
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.orange,
      ),
    );
  }
}
