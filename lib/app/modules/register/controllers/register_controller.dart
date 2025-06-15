import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/repository/auth_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepo = AuthRepository();
  final formKey = GlobalKey<FormState>(); // Tambahkan form key
  final List<String> provinsiList = [
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'DKI Jakarta',
    'Banten'
  ];

  final Map<String, List<String>> kotaMap = {
    'Jawa Barat': ['Bandung', 'Bogor', 'Bekasi', 'Cimahi', 'Tasikmalaya'],
    'Jawa Tengah': ['Semarang', 'Solo', 'Magelang', 'Pekalongan', 'Tegal'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Madiun', 'Kediri', 'Blitar'],
    'DKI Jakarta': ['Jakarta Pusat', 'Jakarta Selatan', 'Jakarta Timur'],
    'Banten': ['Tangerang', 'Serang', 'Cilegon', 'South Tangerang'],
  };

  var selectedProvinsi = ''.obs;
  var selectedKota = ''.obs;
  var kotaList = <String>[].obs;

  void updateKotaList(String provinsi) {
    selectedProvinsi.value = provinsi;
    selectedKota.value = '';
    kotaList.value = kotaMap[provinsi] ?? [];
    provinsiController.text = provinsi;
  }

  void setKota(String kota) {
    selectedKota.value = kota;
    kotaController.text = kota;
  }

  final namaDepanController = TextEditingController();
  final namaBelakangController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noHpController = TextEditingController();
  final noNikController = TextEditingController();
  final noBpjsController = TextEditingController();

  final tglLahirController = TextEditingController();
  final jenisKelaminController = TextEditingController();
  final alamatController = TextEditingController();
  final negaraController = TextEditingController();
  final provinsiController = TextEditingController();
  final kotaController = TextEditingController();
  final kodeposController = TextEditingController();

  final isLoading = false.obs;

  Future<void> register() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading(true);

      final data = {
        "nama_depan": namaDepanController.text,
        "nama_belakang": namaBelakangController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "no_hp": noHpController.text,
        "tgl_lahir": tglLahirController.text,
        "jenis_kelamin": jenisKelaminController.text,
        "alamat": alamatController.text,
        "negara": "Indonesia",
        "provinsi": provinsiController.text,
        "kota": kotaController.text,
        "kodepos": kodeposController.text,
        "no_nik": noNikController.text,
        "no_bpjs": noBpjsController.text,
      };

      final response = await authRepo.register(data);

      Get.snackbar(
        'Berhasil',
        'Pendaftaran Berhasil',
        snackPosition: SnackPosition.TOP,
      );
      clearForm(); // <-- CLEAR FORM HERE

      // Optional: Navigate to login page after successful registration
      // Get.offAllNamed('/login');
    } catch (e) {
      print('error $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    namaDepanController.clear();
    namaBelakangController.clear();
    emailController.clear();
    passwordController.clear();
    noHpController.clear();
    tglLahirController.clear();
    jenisKelaminController.clear();
    alamatController.clear();
    negaraController.clear();
    provinsiController.clear();
    kotaController.clear();
    kodeposController.clear();
    noNikController.clear();
    noBpjsController.clear();

    // Reset dropdowns
    selectedProvinsi.value = '';
    selectedKota.value = '';
    kotaList.clear();

    // Reset form validation state
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    namaDepanController.dispose();
    namaBelakangController.dispose();
    emailController.dispose();
    passwordController.dispose();
    noHpController.dispose();
    tglLahirController.dispose();
    jenisKelaminController.dispose();
    alamatController.dispose();
    negaraController.dispose();
    provinsiController.dispose();
    kotaController.dispose();
    kodeposController.dispose();
    noBpjsController.dispose();
    noNikController.dispose();
    super.onClose();
  }
}
