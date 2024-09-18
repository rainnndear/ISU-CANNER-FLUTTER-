// lib/pages/menu_page.dart

import 'package:flutter/material.dart';
import 'Animated_menu_item.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onProfileSelected;
  final VoidCallback onHelpSelected;
  final VoidCallback onSettingsSelected;
  final VoidCallback onLogoutSelected;

  const MenuPage({
    Key? key,
    required this.onProfileSelected,
    required this.onHelpSelected,
    required this.onSettingsSelected,
    required this.onLogoutSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        AnimatedMenuItem(
          title: 'Profile',
          icon: Icons.person,
          onTap: onProfileSelected,
        ),
        AnimatedMenuItem(
          title: 'Help & Support',
          icon: Icons.help,
          onTap: onHelpSelected,
        ),
        AnimatedMenuItem(
          title: 'Settings & Privacy',
          icon: Icons.settings,
          onTap: onSettingsSelected,
        ),
        AnimatedMenuItem(
          title: 'Logout',
          icon: Icons.logout,
          onTap: onLogoutSelected,
        ),
      ],
    );
  }
}
