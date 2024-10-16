import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/auth/sign_up_page.dart';
import 'package:stopwatch_app/services/auth.dart';
import 'package:stopwatch_app/models/user_model.dart';

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
      debugPrint("Signing in");
      try {
        final result = await _auth.signIn(_email, _password);
        if (result is String) {
          setState(() {
            _errorMessage = result;
          });
        } else if (result is UserModel) {
          // Navigate to the next screen or update the UI accordingly
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
              Container(
                padding: const EdgeInsets.only(
                    top: 150, left: 16, right: 16, bottom: 20),
                color: Colors.grey[900],
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Silahkan login dengan akun kamu",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(fontSize: 20),
                      ),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? "Silahkan isi password" : null,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(fontSize: 20),
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
                        color: Colors.yellow[600],
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
                                  color: Colors.black,
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
                        const Text(
                          "Tidak punya akun?",
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered) ||
                                    states.contains(WidgetState.pressed)) {
                                  return Colors.black.withOpacity(
                                      0.7); // Darker color on hover or press
                                }
                                return Colors.black; // Default color
                              },
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.orange[800]),
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
