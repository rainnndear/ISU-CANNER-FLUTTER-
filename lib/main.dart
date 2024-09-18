import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

/// Request necessary storage permissions
Future<void> _requestPermissions() async {
  // Request storage permission
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  // Request manage external storage permission for Android 11 and above
  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }
}

/// Main function, ensures initialization and permission handling
Future<void> main() async {
  // Ensure Flutter bindings are initialized before making calls to platform plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handler for Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // Optionally, log this error to an external service like Firebase Crashlytics
  };

  try {
    // Initialize SharedPreferences to check if user is logged in
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Request necessary permissions (storage and manage external storage)
    await _requestPermissions();

    // Run the app with the appropriate home screen based on login state
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const MyApp() : HomeScreen(),
      ),
    );
  } catch (error, stackTrace) {
    // Catch and log any errors during initialization
    print('An error occurred during startup: $error');
    print('Stack trace: $stackTrace');
    // Handle the error, potentially navigate to an error screen or log it externally
  }
}

/// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
