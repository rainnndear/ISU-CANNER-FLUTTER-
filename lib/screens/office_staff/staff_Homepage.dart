import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';
import 'package:isu_canner/model/user.dart';

class StaffHomepage extends StatefulWidget {
  final User user; 

  const StaffHomepage({super.key, required this.user});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.user.email}!'), 
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout(context); 
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${widget.user.firstname} ${widget.user.lastname}'), 
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
