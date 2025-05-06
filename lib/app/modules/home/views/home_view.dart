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
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(Routes.QUEUE),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.sp),
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
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.PROFILE);
                    },
                    child: Icon(
                      Icons.settings,
                      size: 28.sp,
                      color: AppColor.primary,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Text(
                'Riwayat Antrian',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'SemiBold',
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.queueList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().screenHeight * .3),
                  child: Center(child: Text('Belum ada riwayat antrian.')),
                );
              }

              return ListView.builder(
                itemCount: controller.queueList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                itemBuilder: (context, index) {
                  final queue = controller.queueList[index];
                  final doctor = queue['doctor'];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.sp),
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. ${doctor?['nama_depan'] ?? '-'} ${doctor?['nama_belakang'] ?? ''}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.sp),
                            Text('Tanggal: ${queue['tgl_periksa']}'),
                            Text(
                                'Waktu: ${queue['start_time']} - ${queue['end_time']}'),
                            Text('Status: ${queue['status']}'),
                            if (queue['keterangan'] != null &&
                                queue['keterangan'].toString().isNotEmpty)
                              Text('Keterangan: ${queue['keterangan']}'),
                          ],
                        ),
                        if (queue['status'] == 'selesai')
                          GestureDetector(
                            onTap: () async {
                              await controller.fetchMedicalRecord(queue['id']);
                              final data = controller.medicalRecord.value;
                              if (data != null) {
                                Get.dialog(AlertDialog(
                                  backgroundColor: AppColor.white,
                                  title: Text('Rekam Medis'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tanggal: ${data['tgl_periksa']}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Diagnosis: ${data['diagnosis']}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Resep: ${data['resep']}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColor.black,
                                          ),
                                          'Catatan Medis: ${data['catatan_medis']}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'Tutup',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColor.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.sp, vertical: 8.sp),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              child: Text(
                                'Rekam Medis',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
