import 'package:flutter/material.dart';
import 'package:isu_canner/screens/home_screen.dart';
import '../../style/custom_app_bar.dart';
import '../../style/custom_bottom_navigation.dart';
import '../../style/custom_drawer.dart'; // Ensure this import is present
import '../../style/custom_profile.dart';
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

  // Function to build the Home page content
  Widget _buildHomePage() {
    return const Center(
      child: Text(
        'Home page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
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
            builder: (context) => ClientProfile(
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
          MaterialPageRoute(builder: (context) =>  const HomeScreen()), // Replace with your actual Settings & Privacy page
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
      appBar: ClientCustomAppBar(
        isSearching: _isSearching,
        onSearchToggle: (isSearching) {
          setState(() {
            _isSearching = isSearching; // Toggle search bar visibility
          });
        },
      ),
      // Use the drawer property of Scaffold to show the custom drawer
      drawer: const ClientCustomDrawer(),

      body: _pages[_selectedIndex], // Display the selected page content
      bottomNavigationBar: ClientCustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
