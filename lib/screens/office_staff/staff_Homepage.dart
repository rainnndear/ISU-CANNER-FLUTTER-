import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';
import 'package:isu_canner/model/user.dart';
import '../../style/custom_app_bar.dart';
import '../../style/custom_drawer.dart';
import '../../style/custom_profile.dart';
import '../office_staff/qr_scanner.dart'; // Import the QR scanner page

class StaffHomepage extends StatefulWidget {
  final User user;

  const StaffHomepage({super.key, required this.user});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {

  void onTabTapped(int index) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaffCustomAppBar(),
      drawer: StaffCustomDrawer(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${widget.user.firstname} ${widget.user.lastname}'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () async {
            // Navigate to the QR Scanner page
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRScannerPage(),
              ),
            );

            // Handle the scanned result (e.g., show a dialog or store in DB)
            if (result != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Scanned QR Code"),
                  content: Text(result),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
          backgroundColor: Colors.grey,
          elevation: 4.0,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            size: 50.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 40,),
              onPressed: () {
                // Handle home press
              },
            ),
            const SizedBox(width: 40), // Space between buttons
            IconButton(
              icon: const Icon(Icons.person, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaffProfile(
                      user: widget.user, // Use the user passed to ClientHomepage
                    ),
                  ),
                );              },
            ),
          ],
        ),
      ),
    );
  }
}
