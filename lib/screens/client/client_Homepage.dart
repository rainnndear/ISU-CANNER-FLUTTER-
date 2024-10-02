import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../style/custom_app_bar.dart';
import '../../style/custom_bottom_navigation.dart';
import '../../style/custom_drawer.dart';
import '../../style/menu_page.dart';


import '../../model/user.dart';
import '../../services/logout.dart';

class ClientHomepage extends StatefulWidget {
  final User user;

  const ClientHomepage({super.key, required this.user});

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

  Widget _buildNotificationPage() {
    return const Center(
      child: Text(
        'Notifications',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuPage() {
    return MenuPage( 
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
