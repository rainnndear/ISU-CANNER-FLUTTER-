import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  // Constructor (optional)
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Hello, this is a StatelessWidget!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.star,
              color: Colors.blue,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyStatelessWidget(),
  ));
}
