import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16.0.sp,
                right: 16.sp,
                top: ScreenUtil().statusBarHeight,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: AssetImage(
                      'assets/images/img_profile.jpg',
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.getGreting(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Medium',
                        ),
                      ),
                      Text(
                        'Hi,Muti Santoso',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.settings,
                    size: 28.sp,
                    color: AppColor.primary,
                  )
                ],
              ),
            ),
            _buildSearchBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Text(
                'Daftar Dokter',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'SemiBold',
                ),
              ),
            ),
            widgetDoctor(),
            widgetDoctor(),
            widgetDoctor(),
            widgetDoctor(),
            widgetDoctor(),
          ],
        ),
      ),
    );
  }

  Container widgetDoctor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
            SizedBox(width: 16.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Muti',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    'Poli Umum',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
      margin: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 16.sp),
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 28.sp, color: AppColor.black),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Cari Dokter',
                hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.menu, color: Colors.grey, size: 22.sp),
        ],
      ),
    );
  }
}
