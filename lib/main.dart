import 'package:flutter/material.dart';
import 'package:pfc_mobile/pages/login_screen.dart';
import 'package:pfc_mobile/pages/splash_Screen.dart';
import 'package:pfc_mobile/pages/home_screen.dart';
import 'package:pfc_mobile/pages/swap_request_screen.dart';
import 'package:pfc_mobile/pages/notifications_screen.dart';
import 'package:pfc_mobile/pages/logout_screen.dart';
import 'package:pfc_mobile/pages/settings_screen.dart';
import 'package:pfc_mobile/pages/edit_profile_screen.dart';

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
        '/main': (context) => MainScreen(),
        '/logout': (context) => LogoutScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for the bottom navigation bar
  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    SwapRequestScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Swap Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Color(0xFF1E3A8A),
        onTap: _onItemTapped,
      ),
    );
  }
}