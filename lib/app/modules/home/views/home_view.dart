import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.defaultSize.height * .1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
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
                        'Fremas adi',
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.sp),
                child: Image.asset(
                  'assets/images/img_slidder.jpg',
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategory',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'SemiBold',
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.grey,
                    ),
                  )
                ],
              ),
            ),
            _categoryCard(),
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategory',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'SemiBold',
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.5),
              ),
              child: Row(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
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
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.list, color: Colors.grey, size: 22.sp),
        ],
      ),
    );
  }
}

class _categoryCard extends StatelessWidget {
  const _categoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.sp),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage('assets/images/img_slidder.jpg'),
          ),
          Text(
            'Dokter gigi',
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
