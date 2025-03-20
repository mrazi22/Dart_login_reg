

import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  static const String HOST = "http://192.168.137.1:3000/";

  static const String register = HOST + "register";
  static const String login = HOST + "login";

  static Future<Map<String, dynamic>> registerUser({
    required String uid,
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(register);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid,
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'failed': false, 'message': 'Registration failed: $e'};
    }
  }

  // Login function
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(login);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'status': 'error', 'message': 'Login failed: $e'};
    }
  }
}