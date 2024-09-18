import 'package:flutter/material.dart';

class ClientCustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_open_sharp),
            title: Text('ACTIONS'),
            onTap: () {
              // Handle the tap here
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('MANAGE ACCOUNT'),
            onTap: () {
              // Handle the tap here
            },
          ),
          // Template section with dropdown
          ExpansionTile(
            leading: Icon(Icons.content_copy),
            title: Text('TEMPLATE'),
            children: <Widget>[
              ListTile(
                title: Text('Template 1'),
                onTap: () {
                  // Handle the tap for Template 1
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Template 2'),
                onTap: () {
                  // Handle the tap for Template 2
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Add more ListTiles for additional templates
            ],
          ),
          ListTile(
            leading: Icon(Icons.fact_check),
            title: Text('TRACK DOCUMENT'),
            onTap: () {
              // Handle the tap here
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('TRANSACTION HISTORY'),
            onTap: () {
              // Handle the tap here
            },
          ),
          // Add more ListTiles for other drawer options
        ],
      ),
    );
  }
}
