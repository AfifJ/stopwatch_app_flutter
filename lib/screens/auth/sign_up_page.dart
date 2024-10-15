import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/auth/sign_in_page.dart';
import 'package:stopwatch_app/services/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final _auth = AuthService();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

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
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("signing up");
                    await _auth.signUp(_email, _password);
                  },
                  child: const Text("Sign up")),
              Row(
                children: [
                  Text(
                    "Sudah punya akun?",
                    textAlign: TextAlign.start,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignInPage();
                        }));
                      },
                      child: const Text("Sign In"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
