import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckloginView extends StatefulWidget {
  const CheckloginView({super.key});

  @override
  State<CheckloginView> createState() => _CheckloginViewState();
}

class _CheckloginViewState extends State<CheckloginView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await Future.delayed(const Duration(seconds: 2)); // Biar kayak splash 😎

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/splash');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
