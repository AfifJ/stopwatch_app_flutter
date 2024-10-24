import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch_app/firebase_options.dart';
import 'package:stopwatch_app/screens/wrapper.dart';
import 'package:stopwatch_app/shared/themes.dart';

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
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Stopwatch',
      theme: Theme.of(context).copyWith(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(elevation: 0),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primary),
      ),
      home: Wrapper(),
    );
  }
}
