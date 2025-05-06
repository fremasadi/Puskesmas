import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/style/app_color.dart';
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
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Image.asset(
          'assets/images/img_splash.png',
          height: 200.h,
          width: 300.w,
        ),
      ),
    );
  }
}
