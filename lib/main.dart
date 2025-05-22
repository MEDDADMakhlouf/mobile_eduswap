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
        useMaterial3: true, // Recommended for modern Flutter apps
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

  // List of titles corresponding to your screens
  static final List<String> _screenTitles = <String>[
    'Home',
    'Swap Requests',
    'Notifications',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Helper function to get the app bar title
  String _getAppBarTitle(int index) {
    // Ensure index is within bounds to prevent errors
    if (index >= 0 && index < _screenTitles.length) {
      return _screenTitles[index];
    }
    return 'TimeSwap'; // Default title if index is out of bounds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Colors.white, // Ensures title, icons, etc. are white
        automaticallyImplyLeading: false, // Important to prevent a back button
        title: Text(
          _getAppBarTitle(_selectedIndex), // THIS IS THE ONLY PLACE THE TITLE SHOULD BE DISPLAYED
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Color is handled by foregroundColor
            onPressed: () {
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ],
        elevation: 4, // Add a slight shadow
      ),
      body: _screens[_selectedIndex], // This displays the currently selected screen
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
        unselectedItemColor: Colors.white70, // Added for better visibility of unselected items
        backgroundColor: Color(0xFF1E3A8A),
        type: BottomNavigationBarType.fixed, // Crucial fix for background color
        onTap: _onItemTapped,
      ),
    );
  }
}