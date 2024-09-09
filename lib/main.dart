import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default colors and styles for the app
        primaryColor: Colors.green, // Primary color for the app
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.green, // Change the cursor color to green
          selectionColor: Colors.greenAccent, // Change the selected text background color
          selectionHandleColor: Colors.green, // Handle color when selecting text
        ),
      ),
      home: isLoggedIn ? const MyApp() : HomeScreen(), // Ensure the correct home screen is shown
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
