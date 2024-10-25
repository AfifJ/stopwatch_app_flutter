import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/home/home_page.dart';
import 'package:stopwatch_app/shared/themes.dart';
import 'package:stopwatch_app/screens/auth/sign_up_page.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/models/user_model.dart';
import 'package:stopwatch_app/shared/constant.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';
  String _email = '';
  String _password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
        _isLoading = true;
      });
      // debugPrint("Signing in");
      try {
        final result = await _auth.signIn(_email, _password);
        if (result is String) {
          setState(() {
            _errorMessage = result;
          });
        } else if (result is UserModel) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Home(); // Replace HomePage with the correct widget
          }));
          debugPrint("Login successful: ${result.email}");
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 96,
              ),
              Image(
                  image: NetworkImage(
                      "https://images.blush.design/694a573ec09c9ed2ea069f5b13d9749e?w=920&auto=compress&cs=srgb"),
                  width: MediaQuery.of(context).size.width * 0.4),
              SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Silahkan login dengan akun kamu",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black.withOpacity(AppTheme.bodyOpacity)
                              : Colors.white.withOpacity(AppTheme.bodyOpacity),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputDecoration(context)
                          .copyWith(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return value!.isEmpty ? "Silahkan isi email" : null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? "Silahkan isi password" : null,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        decoration: textInputDecoration(context)
                            .copyWith(labelText: "Password")),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.red[900],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.red[900]),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        disabledColor: Colors.yellow[50],
                        disabledTextColor: Colors.grey[800],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.rounded),
                        ),
                        color: AppTheme.primary,
                        onPressed: _isLoading ? null : _login,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_isLoading)
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: const CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tidak punya akun?",
                          style: TextStyle(
                            color: Theme.of(context).brightness ==
                                    Brightness.light
                                ? Colors.black.withOpacity(AppTheme.bodyOpacity)
                                : Colors.white
                                    .withOpacity(AppTheme.bodyOpacity),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0)),
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
