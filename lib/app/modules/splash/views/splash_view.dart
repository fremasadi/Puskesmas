import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/modules/widgets/input_form_button.dart';
import 'package:puskesmas/app/routes/app_pages.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().statusBarHeight, horizontal: 35.sp),
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40.r),
                )),
            child: Column(
              children: [
                // Animated fade in text
                FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: Text(
                    'SIKEMAS',
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontFamily: 'SemiBold',
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                // Animated slide in image
                SlideTransition(
                  position: controller.slideAnimation,
                  child: Image.asset(
                    'assets/images/img_splash.png',
                    height: 200.h,
                    width: 300.w,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().statusBarHeight),
          // Animated fade in text
          FadeTransition(
            opacity: controller.fadeAnimation,
            child: Text(
              'Sistem Informasi Pelayanan Puskesmas Kota Kediri',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'SemiBold',
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Animated fade in description
          FadeTransition(
            opacity: controller.fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Melayani dengan sepenuh hati, memberikan pelayanan kesehatan terbaik dan profesional untuk seluruh masyarakat Kota Kediri.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Regular',
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().statusBarHeight),
          // Animated scale in button
          ScaleTransition(
            scale: controller.scaleAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().statusBarHeight * 2,
              ),
              child: InputFormButton(
                titleText: 'Mulai Yuk',
                onClick: () {
                  Get.toNamed(Routes.LOGIN);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
