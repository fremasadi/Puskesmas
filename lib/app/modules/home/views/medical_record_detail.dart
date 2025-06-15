import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/style/app_color.dart';

class MedicalRecordDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const MedicalRecordDetailPage({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Rekam Medis',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            _buildHeaderCard(),
            SizedBox(height: 16.h),

            // Payment Info Card
            _buildPaymentCard(),
            SizedBox(height: 16.h),

            // Medical Info Card
            _buildMedicalInfoCard(),
            SizedBox(height: 16.h),

            // Medicines Card
            _buildMedicinesCard(),
            SizedBox(height: 16.h),

            // Lab Results
            _buildLabResultsCard(),
            SizedBox(height: 16.h),

            // Urinalysis
            _buildUrinalysisCard(),
            SizedBox(height: 16.h),

            // Blood Test
            _buildBloodTestCard(),
            SizedBox(height: 16.h),

            // Serology
            _buildSerologyCard(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColor.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Tanggal Pemeriksaan',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              data['medical_record']['tgl_periksa'] ?? '-',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Card(
      elevation: 3,
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.payment, color: Colors.green, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Informasi Pembayaran',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoRow('Pembayaran', data['jenis_pembayaran'] ?? '-'),
            SizedBox(height: 8.h),
            _buildInfoRow('Total Biaya', formatCurrency(data['total']) ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalInfoCard() {
    return Card(
      elevation: 3,
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services, color: Colors.blue, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Informasi Medis',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
                'Diagnosis', data['medical_record']['diagnosis'] ?? '-'),
            SizedBox(height: 8.h),
            _buildInfoRow('Resep', data['medical_record']['resep'] ?? '-'),
            SizedBox(height: 8.h),
            _buildInfoRow('Catatan Medis',
                data['medical_record']['catatan_medis'] ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicinesCard() {
    final medicines = data['medicines'] as List<dynamic>? ?? [];

    return Card(
      elevation: 3,
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medication, color: Colors.teal, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Obat yang Diresepkan',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (medicines.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  'Tidak ada obat yang diresepkan',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: medicines.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Icon(
                            Icons.medical_services_outlined,
                            color: Colors.teal,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medicine['name'] ?? 'Nama obat tidak tersedia',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Harga: ${formatCurrency(medicine['price']) ?? '-'}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabResultsCard() {
    return Card(
      color: AppColor.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bloodtype, color: Colors.red, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Pemeriksaan Darah',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildLabGrid([
              {
                'label': 'Gula Darah Acak',
                'value': data['medical_record']['gula_darah_acak']
              },
              {
                'label': 'Gula Darah Puasa',
                'value': data['medical_record']['gula_darah_puasa']
              },
              {
                'label': 'Gula Darah 2J PP',
                'value': data['medical_record']['gula_darah_2jm_pp']
              },
              {
                'label': 'Analisa Lemak',
                'value': data['medical_record']['analisa_lemak']
              },
              {
                'label': 'Cholesterol',
                'value': data['medical_record']['cholesterol']
              },
              {
                'label': 'Trigliserida',
                'value': data['medical_record']['trigliserida']
              },
              {'label': 'HDL', 'value': data['medical_record']['hdl']},
              {'label': 'LDL', 'value': data['medical_record']['ldl']},
              {
                'label': 'Asam Urat',
                'value': data['medical_record']['asam_urat']
              },
              {'label': 'BUN', 'value': data['medical_record']['bun']},
              {
                'label': 'Creatinin',
                'value': data['medical_record']['creatinin']
              },
              {'label': 'SGOT', 'value': data['medical_record']['sgot']},
              {'label': 'SGPT', 'value': data['medical_record']['sgpt']},
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildUrinalysisCard() {
    return Card(
      elevation: 3,
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_hospital, color: Colors.orange, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Urinalisa',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildLabGrid([
              {'label': 'Warna', 'value': data['medical_record']['warna']},
              {'label': 'pH', 'value': data['medical_record']['ph']},
              {
                'label': 'Berat Jenis',
                'value': data['medical_record']['berat_jenis']
              },
              {'label': 'Reduksi', 'value': data['medical_record']['reduksi']},
              {'label': 'Protein', 'value': data['medical_record']['protein']},
              {
                'label': 'Bilirubin',
                'value': data['medical_record']['bilirubin']
              },
              {
                'label': 'Urobilinogen',
                'value': data['medical_record']['urobilinogen']
              },
              {'label': 'Nitrit', 'value': data['medical_record']['nitrit']},
              {'label': 'Keton', 'value': data['medical_record']['keton']},
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodTestCard() {
    return Card(
      elevation: 3,
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Darah Lengkap',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildLabGrid([
              {
                'label': 'Hemoglobin',
                'value': data['medical_record']['hemoglobin']
              },
              {
                'label': 'Leukosit',
                'value': data['medical_record']['leukosit']
              },
              {
                'label': 'Erytrosit',
                'value': data['medical_record']['erytrosit']
              },
              {
                'label': 'Trombosit',
                'value': data['medical_record']['trombosit']
              },
              {'label': 'PCV', 'value': data['medical_record']['pcv']},
              {'label': 'DIF', 'value': data['medical_record']['dif']},
              {
                'label': 'Bleeding Time',
                'value': data['medical_record']['bleeding_time']
              },
              {
                'label': 'Clotting Time',
                'value': data['medical_record']['clotting_time']
              },
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSerologyCard() {
    return Card(
      color: AppColor.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.science, color: Colors.purple, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Serologi',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildLabGrid([
              {
                'label': 'Salmonella O',
                'value': data['medical_record']['salmonella_o']
              },
              {
                'label': 'Salmonella H',
                'value': data['medical_record']['salmonella_h']
              },
              {
                'label': 'Salmonella P.A',
                'value': data['medical_record']['salmonella_p_a']
              },
              {
                'label': 'Salmonella P.B',
                'value': data['medical_record']['salmonella_p_b']
              },
              {'label': 'HbsAg', 'value': data['medical_record']['hbsag']},
              {'label': 'VDRL', 'value': data['medical_record']['vdrl']},
              {
                'label': 'Plano Test',
                'value': data['medical_record']['plano_test']
              },
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ': ',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item['label'],
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                item['value']?.toString() ?? '-',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  String? formatCurrency(dynamic value) {
    if (value == null) return null;
    // Implement your currency formatting here
    return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
