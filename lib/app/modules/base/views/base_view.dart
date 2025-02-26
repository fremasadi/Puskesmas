import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:puskesmas/app/modules/history/views/history_view.dart';
import 'package:puskesmas/app/modules/home/views/home_view.dart';
import 'package:puskesmas/app/modules/profile/views/profile_view.dart';

import '../../../style/app_color.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeView(),
              HistoryView(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              selectedItemColor: AppColor.primary,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 26.sp),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.medical_information_outlined, size: 26.sp),
                  activeIcon: Icon(Icons.medical_information,
                      size: 26, color: AppColor.primary),
                  label: 'Riwayat',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person_outline, size: 26.sp),
                //   activeIcon: Icon(Icons.person, size: 26.sp),
                //   label: 'Profil',
                // ),
              ],
            ),
          ),
        ));
  }
}
