import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../baseurl.dart';

class QueueRepository {
  Future<List<dynamic>> getPoliData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/dokter/poli'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']; // asumsi response-nya ada key `data`
      } else {
        throw Exception('Gagal mengambil data poli: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil data poli: $e');
    }
  }

  /// 🔍 Dapatkan daftar dokter berdasarkan ID Poli
  Future<List<dynamic>> getDokterByPoli(int idPoli) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak ditemukan');

      final response = await http.get(
        Uri.parse('$baseUrl/dokter/poli/$idPoli'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']; // asumsi JSON: { "data": [...] }
      } else {
        throw Exception('Gagal mengambil data dokter dari poli $idPoli');
      }
    } catch (e) {
      throw Exception('Error saat mengambil data dokter by poli: $e');
    }
  }

  Future<Map<String, dynamic>> getJadwalDokter(
      int doctorId, String tanggal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak ditemukan');

      final response = await http.get(
        Uri.parse('$baseUrl/dokter/jadwal_dokter/$doctorId/$tanggal'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData; // hasil akan mengandung: doctor_id, date, slots
      } else {
        throw Exception(
            'Gagal mengambil jadwal dokter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil jadwal dokter: $e');
    }
  }

  Future<void> submitQueueData(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/queue'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      // Memeriksa kode status 200 dan 201 sebagai indikasi keberhasilan
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Queue successfully submitted!");
      } else {
        print("Error response: ${response.body}");
        throw Exception('Gagal mengirim data queue: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error saat mengirim data queue: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getQueueData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/queue'), // Ganti endpoint sesuai kebutuhan
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception(
            'Gagal mengambil data antrian (${response.statusCode})');
      }
    } catch (e) {
      print('Error saat fetch queue: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getMedicalRecord(int queueId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak ditemukan');

      final response = await http.get(
        Uri.parse('$baseUrl/queue/history?queue_id=$queueId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final body = json.decode(response.body);
      if (response.statusCode == 200 && body['success'] == true) {
        return body['data'];
      } else {
        throw Exception('Gagal mengambil data rekam medis');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
