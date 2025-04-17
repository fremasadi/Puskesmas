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
              hint: 'Email',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InputTextFormField(
              isSecureField: true,
              controller: controller.passwordController,
              hint: 'Password',
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         'Lupa Password?',
          //         style: TextStyle(
          //           fontSize: 12.sp,
          //           fontFamily: 'Medium',
          //           color: Colors.red,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 12.sp,
          ),
          Obx(() {
            return Center(
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.login,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontFamily: 'SemiBold'),
                      ),
              ),
            );
          }),
          SizedBox(
            height: 12.sp,
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER);
                },
                child: Text(
                  'Daftar',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'SemiBold',
                      color: AppColor.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
