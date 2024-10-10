import 'package:flutter/material.dart';
import 'package:stopwatch_app/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final listMenu = [
    'Daftar anggota',
    'Stopwatch',
    'Rekomendasi situs',
    'Favorit'
  ];

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final user = _auth.currentUser();
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged in as ${user!.email!}"),
            MaterialButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text("Log out"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listMenu.length,
                  itemBuilder: (context, index) {
                    return Text(listMenu[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
