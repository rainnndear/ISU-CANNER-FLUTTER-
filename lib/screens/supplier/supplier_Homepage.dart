import 'package:flutter/material.dart';
import 'package:isu_canner/services/logout.dart';
import 'package:isu_canner/model/user.dart';

class SupplierHomepage extends StatefulWidget {
  final User user; 

  const SupplierHomepage({super.key, required this.user});

  @override
  State<SupplierHomepage> createState() => _SupplierHomepageState();
}

class _SupplierHomepageState extends State<SupplierHomepage> {
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
