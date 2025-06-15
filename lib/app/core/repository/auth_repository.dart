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
        final prefs = await SharedPreferences.getInstance();

        // Simpan token
        await prefs.setString('token', responseData['token']);

        // Simpan data user
        final user = responseData['user'];
        await prefs.setInt('user_id', user['id']);
        await prefs.setString('nama_depan', user['nama_depan']);
        await prefs.setString('nama_belakang', user['nama_belakang']);
        await prefs.setString('email', user['email']);
        await prefs.setString('role', user['role']);
        await prefs.setString('no_hp', user['no_hp']);
        await prefs.setString('tgl_lahir', user['tgl_lahir']);
        await prefs.setString('jenis_kelamin', user['jenis_kelamin']);
        await prefs.setString('alamat', user['alamat']);
        await prefs.setString('negara', user['negara']);
        await prefs.setString('provinsi', user['provinsi']);
        await prefs.setString('kota', user['kota']);
        await prefs.setString('kodepos', user['kodepos']);
        await prefs.setString('no_nik', user['no_nik']);
        await prefs.setString('no_bpjs', user['no_bpjs']);

        // Optional: foto bisa null
        if (user['foto'] != null) {
          await prefs.setString('foto', user['foto']);
        }
        print(responseData['token']);

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

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak ditemukan');

      final url = Uri.parse('$baseUrl/auth/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await prefs.clear(); // 🧼 Bersihkan semua data setelah berhasil
      } else {
        throw Exception(
          'Logout gagal. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
