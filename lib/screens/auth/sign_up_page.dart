import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/auth/sign_in_page.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/models/user_model.dart';
import 'package:stopwatch_app/shared/constant.dart';
import 'package:stopwatch_app/shared/themes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
        _isLoading = true;
      });
      debugPrint("Signing up");
      try {
        if (_password != _confirmPassword) {
          setState(() {
            _errorMessage = "Passwords do not match";
          });
          return;
        }
        final result = await _auth.signUp(_email, _password);
        if (result is String) {
          setState(() {
            _errorMessage = result;
          });
        } else if (result is UserModel) {
          debugPrint("Sign up successful: ${result.email}");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(16),
                titlePadding: EdgeInsets.all(16),
                actionsPadding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text(
                  "Berhasil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  "Berhasil membuat akun, silahkan login dengan akun ini.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                actions: [
                  MaterialButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Buat akun baru",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.mutedTextColor(context)),
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
                        return value!.isEmpty
                            ? "Silahkan masukkan email"
                            : null;
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
                      validator: (value) => value!.isEmpty
                          ? "Silahkan masukkan password"
                          : value.length < 6
                              ? "Password minimal 6"
                              : null,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: textInputDecoration(context).copyWith(
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      obscureText: true,
                      validator: (value) => value!.isEmpty
                          ? "Konfirmasi passwordmu"
                          : value.length < 6
                              ? "Password minimal 6"
                              : null,
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value;
                        });
                      },
                      decoration: textInputDecoration(context).copyWith(
                        labelText: "Konfirmasi Password",
                      ),
                    ),
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
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: AppTheme.primary,
                        onPressed: _isLoading ? null : _signUp,
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
                                "Sign Up",
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
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun?",
                          style: TextStyle(
                              color: AppTheme.mutedTextColor(context)),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0)),
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered) ||
                                    states.contains(WidgetState.pressed)) {
                                  return Colors.black.withOpacity(0.7);
                                }
                                return Colors.black;
                              },
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold),
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
