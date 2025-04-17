import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../baseurl.dart';

class AuthRepository {
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Error during registration: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Simpan token ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['token']);

        return {
          'message': responseData['message'],
          'token': responseData['token'],
        };
      } else {
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error during login: ${e.toString()}');
    }
  }
}
