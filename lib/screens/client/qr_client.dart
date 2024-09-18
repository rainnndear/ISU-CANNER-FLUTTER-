import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../model/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../style/custom_profile.dart';



//////////////////CLIENT PROFILE
class ClientQRProfile extends StatefulWidget {
  final User user;

  const ClientQRProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<ClientQRProfile> createState() => _ClientQRProfileState();
}

class _ClientQRProfileState extends State<ClientQRProfile> {
  // Function to build the Home page content
  Widget _buildHomePage() {
    String userDetails = 'Name: ${widget.user.firstname} ${widget.user.lastname}\n'
        'Email: ${widget.user.email}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.user.email}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Transform.translate(
              offset: const Offset(0, -100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello, ${widget.user.firstname} ${widget.user.lastname}'),
                  const SizedBox(height: 20),
                  QrImageView(
                    data: userDetails,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 20),
                  Text('Scan this QR code for user details'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set the background color to green
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 25),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientProfile(
                      user: widget.user, // Use the user passed to ClientHomepage
                    ),
                  ),
                );
              },
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.white), // Customize text style
              ),
            ),
            SizedBox(width: 20), // Spacing between texts
            GestureDetector(
              onTap: () {
                // Navigate to the QR Code page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientQRProfile(
                      user: widget.user, // Use the user passed to ClientHomepage
                    ),
                  ),
                );
              },
              child: Text(
                'QR Code',
                style: TextStyle(fontSize: 18, color: Colors.white), // Customize text style
              ),
            ),
          ],
        ),
      ),
      body: _buildHomePage(), // Display the selected page content
    );
  }
}




