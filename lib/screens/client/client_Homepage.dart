// lib/pages/client_homepage.dart

import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../style/custom_app_bar.dart';
import '../../style/custom_bottom_navigation.dart';
import '../../style/custom_drawer.dart';
import '../../style/menu_page.dart';
 // Import the new file
import '../../model/user.dart';
import '../../services/logout.dart';

class ClientHomepage extends StatefulWidget {
  final User user;

  const ClientHomepage({Key? key, required this.user}) : super(key: key);

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  bool _isSearching = false; // Controls whether the search bar is visible
  int _selectedIndex = 0; // Track the selected bottom navigation index

  // List of widgets to display for each tab
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildHomePage(), // Home page
      _buildNotificationPage(), // Notification page
      _buildMenuPage(), // Menu page
    ]);
  }

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
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.user.email}!',
                style: const TextStyle(
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
                  const Text('Scan this QR code for user details'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function to build the Notification page content
  Widget _buildNotificationPage() {
    return Center(
      child: Text(
        'Notifications',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Function to build the Menu page content
  Widget _buildMenuPage() {
    return MenuPage(
      onProfileSelected: () {
        // Navigate to Profile page or perform profile action
      },
      onHelpSelected: () {
        // Navigate to Help & Support page or perform help action
      },
      onSettingsSelected: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your actual Settings & Privacy page
        );      },
      onLogoutSelected: () async {
        await logout(context);
      },
    );
  }

  // Function to handle bottom navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClientCustomAppBar(
        isSearching: _isSearching,
        onSearchToggle: (isSearching) {
          setState(() {
            _isSearching = isSearching; // Toggle search bar visibility
          });
        },
      ),
      drawer: ClientCustomDrawer(),
      body: _pages[_selectedIndex], // Display the selected page content
      bottomNavigationBar: ClientCustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
