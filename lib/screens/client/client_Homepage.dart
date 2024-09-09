import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';
import 'package:isu_canner/model/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClientHomepage extends StatefulWidget {
  final User user;

  const ClientHomepage({super.key, required this.user});

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  @override
  Widget build(BuildContext context) {
    // Combine user details into a string for the QR code
    String userDetails = 'Name: ${widget.user.firstname} ${widget.user.lastname}\n'
        'Email: ${widget.user.email}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.user.email}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${widget.user.firstname} ${widget.user.lastname}'),
            const SizedBox(height: 20),
            // Display the QR code with user details
            QrImageView(
              data: userDetails, // Data to encode in the QR code
              version: QrVersions.auto,
              size: 200.0, // Size of the QR code
            ),
            const SizedBox(height: 20),
            const Text('Scan this QR code for user details'),
          ],
        ),
      ),
    );
  }
}
