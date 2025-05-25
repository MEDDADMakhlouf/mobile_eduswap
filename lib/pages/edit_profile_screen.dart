import 'package:flutter/material.dart';
import 'package:pfc_mobile/services/database_services.dart';
import '../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController(text: '123-456-7890');
  final _roleController = TextEditingController(text: 'Professor');
  
  // List to store URLs and their controllers
  List<String> _urls = ['https://example.com'];
  List<TextEditingController> _urlControllers = [
    TextEditingController(text: 'https://example.com')
  ];
  
  bool _emailNotificationsEnabled = true; // Default toggle state

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    for (var controller in _urlControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addUrlField() {
    setState(() {
      _urls.add('');
      _urlControllers.add(TextEditingController());
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Update URLs list with the latest values from controllers
      for (int i = 0; i < _urlControllers.length; i++) {
        _urls[i] = _urlControllers[i].text;
      }

      // Create a User instance from your form data
      final user = User(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        role: _roleController.text,
        urls: _urls,
        emailNotifications: _emailNotificationsEnabled,
      );

      try {
        // Insert user data into your local database
        await DatabaseService.instance.createUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated and saved offline')),
        );
        Navigator.pop(context); // Optionally navigate back
      } catch (error) {
        // If there's an error (e.g., theme-related or DB error), show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
  
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Update your personal information',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),
                // Username Field
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Email Field
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Password Field
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your new password (optional)',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Phone Number Field
                const Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number (optional)',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty && !RegExp(r'^\d{3}-\d{3}-\d{4}$').hasMatch(value)) {
                      return 'Please enter a valid phone number (e.g., 123-456-7890)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Role/Title Field
                const Text(
                  'Role/Title',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _roleController,
                  decoration: InputDecoration(
                    hintText: 'Enter your role (e.g., Professor)',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your role/title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // URLs Section
                const Text(
                  'URLs',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(_urls.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _urlControllers[index],
                        decoration: InputDecoration(
                          hintText: 'Enter a URL (e.g., https://example.com)',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty && !RegExp(r'^https?://').hasMatch(value)) {
                            return 'Please enter a valid URL starting with http:// or https://';
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _addUrlField,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add URL',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Notification Settings Section
                const Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Email Notifications',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Switch(
                      value: _emailNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _emailNotificationsEnabled = value;
                        });
                      },
                      activeColor: const Color(0xFF1E3A8A),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}