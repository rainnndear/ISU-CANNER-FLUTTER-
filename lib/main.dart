import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MyApp() : const HomeScreen(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
