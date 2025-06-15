import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/modules/profile/views/edit_profile_view.dart';
import '../../../style/app_color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 28.sp,
                      color: AppColor.black,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Data Pengguna',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.black,
                      fontFamily: 'Medium',
                    ),
                  )
                ],
              ),
            ), // Avatar dan Nama
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: AppColor.primary.withOpacity(0.2),
                    child: Icon(Icons.person,
                        size: 40.sp, color: AppColor.primary),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => Text(
                      '${controller.nama_depan.value} ${controller.nama_belakang.value}')),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Data langsung ditulis di UI
            Obx(() => infoItem('No Bpjs', controller.noBpjs.value)),
            Obx(() => infoItem('No Nik', controller.noNik.value)),
            Obx(() => infoItem('Email', controller.email.value)),
            Obx(() => infoItem('No. HP', controller.noHp.value)),
            Obx(() => infoItem('Tanggal Lahir', controller.tglLahir.value)),
            Obx(() => infoItem(
                  'Jenis Kelamin',
                  controller.jenisKelamin.value == 'L'
                      ? 'Laki-laki'
                      : controller.jenisKelamin.value == 'P'
                          ? 'Perempuan'
                          : controller.jenisKelamin.value,
                )),
            Obx(() => infoItem('Alamat', controller.alamat.value)),
            Obx(() =>
                infoItem('Kota & Provinsi', controller.kotaProvinsi.value)),
            Obx(() => infoItem('Negara', controller.negara.value)),
            Obx(() => infoItem('Kode Pos', controller.kodepos.value)),

            SizedBox(height: 12.h),

            // Tombol Logout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(EditProfileView());
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                      label:
                          Text('Edit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: EdgeInsets.symmetric(vertical: 12.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w), // Jarak antar tombol
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.logout(),
                      icon: Icon(Icons.logout, color: Colors.white),
                      label:
                          Text('Logout', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 12.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 12.h,
            )
          ],
        ),
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp),
          ),
          Divider(),
        ],
      ),
    );
  }
}
