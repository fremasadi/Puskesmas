import 'dart:convert';
import 'package:http/http.dart' as http;

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
      print('Request Data: ${jsonEncode(data)}'); // Cetak data yang dikirim
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}'); // Cetak response lengkap

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(responseData);
        return responseData;
      } else {
        print('Error Details: ${responseData.toString()}');
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Error during registration: ${e.toString()}');
    }
  }
}
