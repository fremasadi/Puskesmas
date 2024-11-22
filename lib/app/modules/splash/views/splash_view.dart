import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../style/app_color.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Stack(
            children: [
              PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  SplashPage(
                    image: 'assets/images/img1.jpg',
                    title: 'Selamat datang di Puskesmas Kediri Kota!',
                    description:
                        'Solusi Terbaik untuk Kesehatan anda',
                  ),
                  SplashPage(
                    image: 'assets/images/img2.jpg',
                    title: 'Dokter Berkualitas',
                    description:
                        'Menyediakan berbagai dokter berkualitas',
                  ),
                  SplashPage(
                    image: 'assets/images/img3.jpg',
                    title: 'Fitur Unggulan',
                    description:
                        'Pesan dokter hanya di aplikasi dengan cepat dan rekap medis',
                  ),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Obx(() {
                  return (controller.currentPage.value == 0 ||
                          controller.currentPage.value == 1)
                      ? TextButton(
                          onPressed: controller.skip,
                          child: Row(
                            children: [
                              Text(
                                'Lewati',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Medium',
                                  color: AppColor.lightgrey,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                    'assets/icons/ic_arrowright.png',
                                    height: 18,
                                    width: 18,
                                    color: AppColor.primary,
                                  )),
                            ],
                          ),
                        )
                      : const SizedBox();
                }),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: Obx(() {
                  return Row(
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? AppColor.primary
                              : AppColor.cream,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Obx(() {
                  if (controller.currentPage.value == 2) {
                    return Container(
                      height: 56.h,
                      width: 144.w,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextButton(
                        onPressed: controller.enterApp,
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'SemiBold',
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Row(
                      children: [
                        if (controller.currentPage.value != 0)
                          GestureDetector(
                            onTap: () {
                              controller.previousPage();
                            },
                            child: Container(
                                height: 56.h,
                                width: 56.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.whiteGrey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Image.asset(
                                    'assets/icons/ic_arrowleft.png',
                                    height: 15,
                                    width: 15,
                                    color: AppColor.primary,
                                  ),
                                )),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.nextPage();
                            },
                            child: Container(
                                height: 56.h,
                                width: 56.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Image.asset(
                                    'assets/icons/ic_arrowright.png',
                                    height: 15,
                                    width: 15,
                                    color: AppColor.white,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const SplashPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.sp),
                child: Image.asset(
                  image,
                  height: 420.h,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontFamily: 'Bold'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Text(
                description,
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
