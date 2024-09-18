import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';

class ClientCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final ValueChanged<bool> onSearchToggle; // Callback to handle search toggle

  ClientCustomAppBar({
    Key? key,
    required this.isSearching,
    required this.onSearchToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0),
        ),
      )
          : Row(
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
