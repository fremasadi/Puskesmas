import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../baseurl.dart';

class UserRepository {
  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    final url = Uri.parse('$baseUrl/pasien/update');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['token'] != null) {
        await prefs.setString('token', responseData['token']);
      }
    } else {
      throw Exception(
        'Gagal update data. Status: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
