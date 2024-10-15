import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/auth/sign_in_page.dart';
import 'package:stopwatch_app/screens/home/home_page.dart';
import 'package:stopwatch_app/services/auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            return Home();
          } else {
            return SignInPage();
          }
        });
  }
}
