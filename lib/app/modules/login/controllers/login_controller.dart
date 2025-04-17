import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/repository/auth_repository.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;
  final authRepo = AuthRepository();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong");
      return;
    }

    isLoading.value = true;

    try {
      final response = await authRepo.login(email, password);

      // Opsional: Akses token dari SharedPreferences kalau mau dicek
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      Get.snackbar("Sukses", response['message']);

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Login Gagal", 'Masukan dengan benar');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
