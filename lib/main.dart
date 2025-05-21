import 'package:flutter/material.dart';
import 'package:pfc_mobile/pages/login_screen.dart';
import 'package:pfc_mobile/pages/splash_Screen.dart';
import 'package:pfc_mobile/pages/home_screen.dart';
import 'package:pfc_mobile/pages/swap_request_screen.dart';
import 'package:pfc_mobile/pages/notifications_screen.dart';
import 'package:pfc_mobile/pages/logout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeSwap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/swap_request': (context) => SwapRequestScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/logout': (context) => LogoutScreen(),
      },
    );
  }
}