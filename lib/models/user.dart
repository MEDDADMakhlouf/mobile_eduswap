import 'dart:convert';

class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String role;
  final List<String> urls;
  final bool emailNotifications;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.urls,
    required this.emailNotifications,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      // Store the list as a JSON string
      'urls': jsonEncode(urls),
      'emailNotifications': emailNotifications ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      urls: List<String>.from(jsonDecode(map['urls'])),
      emailNotifications: map['emailNotifications'] == 1,
    );
  }

  User copyWith({int? id}) {
    return User(
      id: id ?? this.id,
      username: username,
      email: email,
      password: password,
      phone: phone,
      role: role,
      urls: urls,
      emailNotifications: emailNotifications,
    );
  }
}