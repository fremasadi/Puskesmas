import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/repository/user_repository.dart';
import '../../../style/app_color.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final controller = Get.find<ProfileController>();

  late TextEditingController namaDepanCtrl;
  late TextEditingController namaBelakangCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController noHpCtrl;
  late TextEditingController tglLahirCtrl;
  late TextEditingController jenisKelaminCtrl;
  late TextEditingController alamatCtrl;
  late TextEditingController kotaProvinsiCtrl;
  late TextEditingController negaraCtrl;
  late TextEditingController kodeposCtrl;
  late TextEditingController noBpjsCtrl;
  late TextEditingController noNikCtrl;

  @override
  void initState() {
    super.initState();
    namaDepanCtrl = TextEditingController(text: controller.nama_depan.value);
    namaBelakangCtrl =
        TextEditingController(text: controller.nama_belakang.value);
    emailCtrl = TextEditingController(text: controller.email.value);
    noHpCtrl = TextEditingController(text: controller.noHp.value);
    tglLahirCtrl = TextEditingController(text: controller.tglLahir.value);
    jenisKelaminCtrl =
        TextEditingController(text: controller.jenisKelamin.value);
    alamatCtrl = TextEditingController(text: controller.alamat.value);
    kotaProvinsiCtrl =
        TextEditingController(text: controller.kotaProvinsi.value);
    negaraCtrl = TextEditingController(text: controller.negara.value);
    kodeposCtrl = TextEditingController(text: controller.kodepos.value);
    noBpjsCtrl = TextEditingController(text: controller.noBpjs.value);
    noNikCtrl = TextEditingController(text: controller.noNik.value);
  }

  Future<void> _saveProfile() async {
    try {
      final userRepo = UserRepository();
      final kotaProvParts = kotaProvinsiCtrl.text.split(',');
      final kota = kotaProvParts[0].trim();
      final provinsi = kotaProvParts.length > 1 ? kotaProvParts[1].trim() : '';

      final data = {
        'nama_depan': namaDepanCtrl.text,
        'nama_belakang': namaBelakangCtrl.text,
        'email': emailCtrl.text,
        'no_hp': noHpCtrl.text,
        'tgl_lahir': tglLahirCtrl.text,
        'jenis_kelamin': jenisKelaminCtrl.text,
        'alamat': alamatCtrl.text,
        'kota': kota,
        'provinsi': provinsi,
        'negara': negaraCtrl.text,
        'kodepos': kodeposCtrl.text,
        'no_bpjs': noBpjsCtrl.text,
        'no_nik': noNikCtrl.text,
      };

      await userRepo.updateUserData(data);

      final prefs = await SharedPreferences.getInstance();
      data.forEach((key, value) {
        prefs.setString(key, value);
      });

      controller.loadUserData(); // Refresh di controller
      Get.back();
      Get.snackbar('Sukses', 'Profil berhasil diperbarui');
    } catch (e) {
      print(e.toString());

      Get.snackbar('Gagal', e.toString());
    }
  }

  Widget buildTextField(String label, TextEditingController ctrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget buildGenderDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: DropdownButtonFormField<String>(
        value: jenisKelaminCtrl.text == 'L' || jenisKelaminCtrl.text == 'P'
            ? jenisKelaminCtrl.text
            : null,
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
          DropdownMenuItem(value: 'P', child: Text('Perempuan')),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              jenisKelaminCtrl.text = value;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildTextField('Nama Depan', namaDepanCtrl),
          buildTextField('Nama Belakang', namaBelakangCtrl),
          buildTextField('Email', emailCtrl),
          buildTextField('No HP', noHpCtrl),
          buildTextField('Tanggal Lahir', tglLahirCtrl),
          buildGenderDropdown(),
          buildTextField('Alamat', alamatCtrl),
          buildTextField('Kota, Provinsi', kotaProvinsiCtrl),
          buildTextField('Negara', negaraCtrl),
          buildTextField('Kode Pos', kodeposCtrl),
          buildTextField('No BPJS', noBpjsCtrl),
          buildTextField('No NIK', noNikCtrl),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.symmetric(vertical: 14.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Simpan Perubahan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
