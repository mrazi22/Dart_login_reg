

import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  static const String HOST = "http://192.168.137.1:3000/";

  static const String register = HOST + "register";
  static const String login = HOST + "login";
  static const String uploads = HOST + "uploads/";

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

  //create project
  static Future<Map<String, dynamic>> createProject(
      Map<String, String> body, List<http.MultipartFile> files) async {
    final url = Uri.parse(HOST + "create-project");
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(body);
      request.files.addAll(files);
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      final data = jsonDecode(responseBody.body);
      return data;
    } catch (e) {
      return {'status': 'error', 'message': 'Project creation failed: $e'};
    }
  }

  //get project
  static Future<Map<String, dynamic>> getProjects() async {
    try {
      // Replace 'YOUR_GET_PROJECTS_API_ENDPOINT' with your actual API endpoint.
      final response = await http.get(Uri.parse(HOST + 'get-projects'));

      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object with a 'data' field containing
        // the list of projects.
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        return decodedResponse; // Return the decoded response
      } else {
        // Handle error cases.
        return {'status': 'error', 'message': 'Failed to load projects'};
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors).
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  //delete projects
  static Future<Map<String, dynamic>> deleteProject(String projectId) async {
    try {
      final response = await http.delete(
        Uri.parse(HOST + 'delete-project/$projectId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        return decodedResponse;
      } else {
        return {
          'status': 'error',
          'message': 'Failed to delete project: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

}