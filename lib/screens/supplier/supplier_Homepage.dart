import 'package:flutter/material.dart';
import 'package:isu_canner/model/user.dart';

import '../../services/logout.dart';
import '../../style/custom_app_bar.dart';
import '../../style/custom_bottom_navigation.dart';
import '../../style/custom_drawer.dart';
import '../../style/custom_profile.dart';
import '../../style/menu_page.dart';
import '../home_screen.dart';

class SupplierHomepage extends StatefulWidget {
  final User user;

  const SupplierHomepage({super.key, required this.user});

  @override
  State<SupplierHomepage> createState() => _SupplierHomepageState();
}

class _SupplierHomepageState extends State<SupplierHomepage> {
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
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 160.0), // Adjust the padding to move it down from the top
          child: Text(
            'ORDER',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }


  // Function to build the Notification page content
  Widget _buildNotificationPage() {
    return  const Center(
      child: Text(
        'Notifications',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Function to build the Menu page content
// In the ClientHomepage class

// Modify the _buildMenuPage function
  Widget _buildMenuPage() {
    return MenuPage(
      onProfileSelected: () {
        // Pass the user data to ClientProfile
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SupplierProfile(
              user: widget.user, // Use the user passed to ClientHomepage
            ),
          ),
        );
      },
      onHelpSelected: () {
        // Navigate to Help & Support page or perform help action
      },
      onSettingsSelected: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), // Replace with your actual Settings & Privacy page
        );
      },
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
      appBar: SupplierCustomAppBar(
        isSearching: _isSearching,
        onSearchToggle: (isSearching) {
          setState(() {
            _isSearching = isSearching; // Toggle search bar visibility
          });
        },
      ),

      drawer:const SupplierCustomDrawer(),
      body: _pages[_selectedIndex], // Display the selected page content
      bottomNavigationBar: SupplierCustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
