// lib/pages/menu_page.dart

import 'package:flutter/material.dart';
import 'Animated_menu_item.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onLogoutSelected;

  const MenuPage({
    super.key,
    required this.onLogoutSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        AnimatedMenuItem(
          title: 'Logout',
          icon: Icons.logout,
          onTap: onLogoutSelected,
        ),
      ],
    );
  }
}
