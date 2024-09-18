import 'package:flutter/material.dart';
import 'package:isu_canner/screens/client/track_document.dart';

import '../services/logout.dart';

class ClientCustomDrawer extends StatelessWidget {
  const ClientCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80), // Set the border radius here
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    width: 80, // Set width
                    height: 80, // Changed height to 160 for better visibility
                    fit: BoxFit.cover, // Maintain aspect ratio
                  ),
                ),
                const SizedBox(height: 10), // Space between the image and the text
                const Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),



          ListTile(
            leading:const Icon(Icons.menu_open_sharp),
            title: const Text('ACTIONS'),
            onTap: () {
              // Handle the tap here
            },
          ),
          ListTile(
            leading:const Icon(Icons.manage_accounts),
            title: const Text('MANAGE ACCOUNT'),
            onTap: () {
              // Handle the tap here
            },
          ),
          // Template section with dropdown
          ExpansionTile(
            leading:const Icon(Icons.content_copy),
            title: const Text('TEMPLATE'),
            children: <Widget>[
              ListTile(
                title: const Text('Template 1'),
                onTap: () {
                  // Handle the tap for Template 1
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Template 2'),
                onTap: () {
                  // Handle the tap for Template 2
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Add more ListTiles for additional templates
            ],
          ),
          ListTile(
            leading: const Icon(Icons.fact_check),
            title: const Text('TRACK DOCUMENT'),
            onTap: () {
              // Navigate to TrackDocumentPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackOrderScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading:const Icon(Icons.history),
            title: const Text('TRANSACTION HISTORY'),
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



class SupplierCustomDrawer extends StatelessWidget {
  const SupplierCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80), // Set the border radius here
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    width: 80, // Set width
                    height: 80, // Changed height to 160 for better visibility
                    fit: BoxFit.cover, // Maintain aspect ratio
                  ),
                ),
                const SizedBox(height: 10), // Space between the image and the text
                const Text(
                  'Company Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),


          ListTile(
            leading: const Icon(Icons.fact_check),
            title: const Text('DEPART SUPPLIES'),
            onTap: () {
              // Navigate to TrackDocumentPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackOrderScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading:const Icon(Icons.history),
            title:const Text('TRANSACTION HISTORY'),
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










class StaffCustomDrawer extends StatelessWidget {
  const StaffCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80), // Set the border radius here
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    width: 80, // Set width
                    height: 80, // Changed height to 160 for better visibility
                    fit: BoxFit.cover, // Maintain aspect ratio
                  ),
                ),
                const SizedBox(height: 10), // Space between the image and the text
                const Text(
                  'Staff Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:const Icon(Icons.notifications_active_sharp, size: 30), // Adjust icon size
            title: const Text('NOTIFICATION'),
            onTap: () {
              // Handle the tap here
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, size: 30), // Adjust icon size
            title:const Text('TRANSACTION HISTORY'),
            onTap: () {
              // Handle the tap here
            },
          ),
          // Template section with dropdown

          ListTile(
            leading:const Icon(Icons.logout, size: 30), // Adjust icon size
            title:const Text('LOG OUT'),
            onTap: () async {
              await logout(context);
            },
          ),
          // Add more ListTiles for other drawer options
        ],
      ),
    );
  }
}
