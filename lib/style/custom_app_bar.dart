import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';

class ClientCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final ValueChanged<bool> onSearchToggle; // Callback to handle search toggle

  const ClientCustomAppBar({
    super.key,
    required this.isSearching,
    required this.onSearchToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? const TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0),
        ),
      )
          : const Row(
        children: [
          Icon(
            Icons.group,
            size: 24.0, // Adjust the size as needed
          ),
          SizedBox(width: 8.0), // Space between icon and text
          Text('Client Portal'),
        ],
      ),
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            onSearchToggle(!isSearching); // Toggle search bar visibility
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
