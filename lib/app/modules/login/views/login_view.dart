import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:puskesmas/app/modules/widgets/input_form_button.dart';
import 'package:puskesmas/app/routes/app_pages.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../../widgets/input_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/img_login.jpg',
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 22.sp,
                fontFamily: 'SemiBold',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: InputTextFormField(
              controller: controller.emailController,
              hint: 'Nomer Bpjs',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InputTextFormField(
              isSecureField: true,
              controller: controller.emailController,
              hint: 'Password',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lupa Password?',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Medium',
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 26.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: InputFormButton(
              titleText: 'Login',
              onClick: () {
                Get.toNamed(Routes.BASE);
              },
            ),
          ),
          SizedBox(
            height: 32.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum Punya akun? ',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'Daftar',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'SemiBold',
                    color: AppColor.primary),
              )
            ],
          )
        ],
      ),
    );
  }
}
