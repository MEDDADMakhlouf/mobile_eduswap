import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Logging out...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}