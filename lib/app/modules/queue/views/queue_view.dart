import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:puskesmas/app/style/app_color.dart';

import '../controllers/queue_controller.dart';

class QueueView extends GetView<QueueController> {
  const QueueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    'Tambah Antrian',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.black,
                      fontFamily: 'Medium',
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month,
                                color: AppColor.white, size: 32.sp),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pemesanan Antrian',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Silahkan pilih poli, dokter, dan waktu kunjungan Anda',
                                    style: TextStyle(color: AppColor.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Step indicator
                      Row(
                        children: [
                          _buildStepIndicator(1, 'Pilih Poli', true),
                          _buildStepConnector(),
                          GetX<QueueController>(
                            builder: (ctrl) => _buildStepIndicator(
                                2,
                                'Pilih Dokter',
                                ctrl.selectedPoliId.value != null),
                          ),
                          _buildStepConnector(),
                          GetX<QueueController>(
                            builder: (ctrl) => _buildStepIndicator(
                                3,
                                'Pilih Waktu',
                                ctrl.selectedDoctorId.value != null),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Poli selection
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 16.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Poli',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GetX<QueueController>(
                                builder: (ctrl) => ctrl.polis.isNotEmpty
                                    ? DropdownButtonFormField<int>(
                                        dropdownColor: Colors.grey[100],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                        ),
                                        hint: const Text('Pilih Poli Klinik'),
                                        value: ctrl.selectedPoliId.value,
                                        items: ctrl.polis.map((poli) {
                                          return DropdownMenuItem<int>(
                                            value: int.parse(poli['id']),
                                            child: Text(poli['name']),
                                          );
                                        }).toList(),
                                        onChanged: (poliId) {
                                          if (poliId != null) {
                                            ctrl.onPoliChanged(poliId);
                                          }
                                        },
                                      )
                                    : const Center(child: SizedBox()),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Dokter selection
                      GetX<QueueController>(
                        builder: (ctrl) => ctrl.selectedPoliId.value != null
                            ? Card(
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pilih Dokter',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ctrl.doctors.isNotEmpty
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: ctrl.doctors.length,
                                              itemBuilder: (context, index) {
                                                final doctor =
                                                    ctrl.doctors[index];
                                                return Obx(() {
                                                  final isSelected = ctrl
                                                          .selectedDoctorId
                                                          .value ==
                                                      doctor['id'];
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? AppColor.primary
                                                            : Colors.grey[300]!,
                                                        width:
                                                            isSelected ? 2 : 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: isSelected
                                                          ? AppColor.primary
                                                              .withOpacity(0.1)
                                                          : Colors.white,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        final id = doctor['id'];
                                                        ctrl.onDoctorChanged(
                                                            id is String
                                                                ? int.parse(id)
                                                                : id);
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.2),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: AppColor
                                                                        .primary),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 12),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Dr. ${doctor['nama_depan'] ?? ''}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontFamily:
                                                                          'SemiBold',
                                                                      color: isSelected
                                                                          ? AppColor
                                                                              .primary
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                  ),
                                                                  if (doctor[
                                                                          'specialization'] !=
                                                                      null)
                                                                    Text(
                                                                      doctor[
                                                                          'specialization'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey[600]),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (isSelected)
                                                              Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: AppColor
                                                                      .primary),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                            )
                                          : const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                    'Tidak ada dokter yang tersedia'),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Tanggal pemeriksaan
                      GetX<QueueController>(
                        builder: (ctrl) => ctrl.selectedDoctorId.value != null
                            ? Card(
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 16.sp),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pilih Tanggal Pemeriksaan',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: ctrl.tglPeriksaController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                          suffixIcon:
                                              const Icon(Icons.calendar_today),
                                          hintText: 'Pilih Tanggal',
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          final pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 30)),
                                          );

                                          if (pickedDate != null) {
                                            final formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            ctrl.tglPeriksaController.text =
                                                formattedDate;
                                            // Reactive system akan detect ini, tidak perlu fetch manual jika pakai everAll
                                          }
                                        },
                                      ),
                                      // const SizedBox(height: 8),
                                      // TextButton.icon(
                                      //   icon: const Icon(Icons.refresh),
                                      //   label:
                                      //       const Text('Lihat Jadwal Tersedia'),
                                      //   onPressed: () {
                                      //     if (ctrl.tglPeriksaController.text
                                      //         .isNotEmpty) {
                                      //       ctrl.fetchJadwalDokter();
                                      //     } else {
                                      //       Get.snackbar(
                                      //         'Peringatan',
                                      //         'Mohon pilih tanggal terlebih dahulu',
                                      //         backgroundColor:
                                      //             Colors.yellow[100],
                                      //         colorText: Colors.black87,
                                      //       );
                                      //     }
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Jadwal slots - menggunakan custom widget
                      GetX<QueueController>(builder: (ctrl) {
                        print(
                            'Selected Doctor: ${ctrl.selectedDoctorId.value}, Date: ${ctrl.tglPeriksaText.value}');
                        print('Slot count: ${ctrl.jadwalSlots.length}');

                        return ctrl.selectedDoctorId.value != null &&
                                ctrl.tglPeriksaController.text.isNotEmpty
                            ? Card(
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 16.sp),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: JadwalSlotSelector(controller: ctrl),
                                ),
                              )
                            : const SizedBox.shrink();
                      }),

                      // Ubah bagian keterangan dan submit button menjadi GetBuilder
                      GetBuilder<QueueController>(
                          init: controller,
                          builder: (ctrl) {
                            return Column(
                              children: [
                                // Keterangan
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(bottom: 16.sp),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Keluhan',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          controller: ctrl.keteranganController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            hintText:
                                                'Berikan keluhan tambahan jika ada...',
                                          ),
                                          minLines: 3,
                                          maxLines: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ctrl.submitForm();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: Text(
                                      'Kirim Pendaftaran',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: isActive ? AppColor.primary : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isActive ? AppColor.primary : Colors.grey[600],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector() {
    return Container(
      width: 30.w,
      height: 2.h,
      color: Colors.grey[300],
    );
  }
}

class JadwalSlotSelector extends StatelessWidget {
  final QueueController controller;

  const JadwalSlotSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QueueController>(
      init: controller,
      builder: (ctrl) {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ctrl.jadwalSlots.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(Icons.schedule, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Tidak ada jadwal tersedia untuk tanggal ini',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                'Pilih Waktu Kunjungan',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: ctrl.jadwalSlots.length,
              itemBuilder: (context, index) {
                final slot = ctrl.jadwalSlots[index];
                final isBooked = slot['is_booked'] == true;

                final isSelected =
                    ctrl.startTimeController.text == slot['start'] &&
                        ctrl.endTimeController.text == slot['end'];

                return GestureDetector(
                  onTap: isBooked
                      ? null
                      : () {
                          ctrl.startTimeController.text = slot['start'];
                          ctrl.endTimeController.text = slot['end'];
                          ctrl.update();
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.grey[200]
                          : isSelected
                              ? AppColor.primary
                              : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.primary
                            : isBooked
                                ? Colors.grey[400]!
                                : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${slot['start']}',
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isBooked
                              ? Colors.grey
                              : isSelected
                                  ? Colors.white
                                  : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
