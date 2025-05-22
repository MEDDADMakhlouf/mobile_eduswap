import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'TimeSwap',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Text('NH', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView for scrollability
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Settings Header
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Section
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to a dedicated Edit Profile screen
                        Navigator.pushNamed(context, '/edit_profile');
                      },
                    ),
                    const Divider(height: 0, indent: 72, endIndent: 16), // Divider below Edit Profile
                    ListTile(
                      leading: const Icon(Icons.lock, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Change Password',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to Change Password screen
                        Navigator.pushNamed(context, '/change_password');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Configuration Section
              Text(
                'Configuration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Notification Settings',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to Notification Settings screen
                        Navigator.pushNamed(context, '/notification_settings');
                      },
                    ),
                    const Divider(height: 0, indent: 72, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.color_lens, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Theme',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Row( // Use a Row for text and icon for current theme
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('System', style: TextStyle(color: Colors.grey[600])), // Example: Show current theme
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                      onTap: () {
                        // Show theme selection dialog or navigate to theme settings
                        _showThemeSelectionDialog(context);
                      },
                    ),
                    const Divider(height: 0, indent: 72, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.language, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Language',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Row( // Use a Row for text and icon for current language
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('English', style: TextStyle(color: Colors.grey[600])), // Example: Show current language
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                      onTap: () {
                        // Show language selection dialog or navigate to language settings
                        _showLanguageSelectionDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Other Settings / About Section (Optional)
              Text(
                'Other',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'About TimeSwap',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to an About screen
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                    const Divider(height: 0, indent: 72, endIndent: 16),
                     ListTile(
                      leading: const Icon(Icons.security, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to Privacy Policy screen
                        Navigator.pushNamed(context, '/privacy_policy');
                      },
                    ),
                    const Divider(height: 0, indent: 72, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.description, color: Color(0xFF1E3A8A)),
                      title: const Text(
                        'Terms of Service',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        // Navigate to Terms of Service screen
                        Navigator.pushNamed(context, '/terms_of_service');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Log Out Button (as a distinct action)
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red), // Use a distinct color for logout
                title: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  // Implement actual logout logic (e.g., clear user session, navigate to login)
                  // For now, just navigate to a placeholder '/logout' route
                  Navigator.pushNamedAndRemoveUntil(context, '/logout', (route) => false);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to show a simple theme selection dialog
  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('System Default'),
                value: 'System',
                groupValue: 'System', // This should come from a state management
                onChanged: (value) {
                  Navigator.pop(context); // Close dialog
                  // Implement theme change
                },
              ),
              RadioListTile<String>(
                title: const Text('Light'),
                value: 'Light',
                groupValue: 'System',
                onChanged: (value) {
                  Navigator.pop(context);
                  // Implement theme change
                },
              ),
              RadioListTile<String>(
                title: const Text('Dark'),
                value: 'Dark',
                groupValue: 'System',
                onChanged: (value) {
                  Navigator.pop(context);
                  // Implement theme change
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to show a simple language selection dialog
  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: 'English', // This should come from a state management
                onChanged: (value) {
                  Navigator.pop(context);
                  // Implement language change
                },
              ),
              RadioListTile<String>(
                title: const Text('العربية'), // Arabic
                value: 'Arabic',
                groupValue: 'English',
                onChanged: (value) {
                  Navigator.pop(context);
                  // Implement language change
                },
              ),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }
}