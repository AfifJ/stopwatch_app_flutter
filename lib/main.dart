import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/firebase_options.dart';
import 'package:stopwatch_app/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter test',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 16),
          displayLarge: TextStyle(fontSize: 16),
          displayMedium: TextStyle(fontSize: 16),
          displaySmall: TextStyle(fontSize: 16),
          labelLarge: TextStyle(fontSize: 16),
          labelMedium: TextStyle(fontSize: 16),
          labelSmall: TextStyle(fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Wrapper(),
    );
  }
}
