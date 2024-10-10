import 'package:flutter/material.dart';
import 'package:stopwatch_app/services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final _auth = AuthService();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: const InputDecoration(labelText: "email"),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: const InputDecoration(labelText: "password"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("logging in");
                    await _auth.signIn(_email, _password);
                  },
                  child: const Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }
}
