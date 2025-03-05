import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String getGreting() {
    final date = DateTime.now().hour;

    if (date < 12) {
      return "Selamat Pagi";
    } else if (date < 15) {
      return "Selamat Siang";
    } else if (date < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  var poliList = [
    {'name': 'Poli Gigi', 'icon': Icons.medical_services},
    {'name': 'Poli Umum', 'icon': Icons.local_hospital},
    {'name': 'Poli Anak', 'icon': Icons.child_care},
    {'name': 'Poli Mata', 'icon': Icons.visibility},
    {'name': 'Poli Kandungan', 'icon': Icons.pregnant_woman},
    {'name': 'Poli Saraf', 'icon': Icons.psychology},
  ].obs;

  void goToPoliDetail(String poliName) {
    Get.snackbar("Poli Dipilih", "Anda memilih $poliName");
  }
}
