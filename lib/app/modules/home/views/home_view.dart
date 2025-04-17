import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:puskesmas/app/routes/app_pages.dart';
import 'package:puskesmas/app/style/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> poliList = [
      {'name': 'Poli Gigi & Mulut', 'icon': Icons.medical_services},
      {'name': 'Poli Umum', 'icon': Icons.local_hospital},
      {'name': 'Poli Lansia', 'icon': Icons.child_care},
      {'name': 'Poli Kb & Imunisas', 'icon': Icons.visibility},
    ];

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(Routes.QUEUE),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColor.primary,
          ),
          child: Text(
            'Tambah Antrian',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'SemiBold',
              color: AppColor.white,
            ),
          ),
        ),
      ),
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
                  SizedBox(width: 12.w),
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
                        'Hi, Muti Santoso',
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
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Text(
                'Silakan Pilih Poli',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'SemiBold',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1,
                ),
                itemCount: poliList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColor.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DOCTOR,
                            arguments: poliList[index]['name']);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            poliList[index]['icon'],
                            size: 50.sp,
                            color: AppColor.primary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            poliList[index]['name'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Medium',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
