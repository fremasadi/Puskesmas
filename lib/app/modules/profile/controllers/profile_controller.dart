import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/repository/auth_repository.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  var email = ''.obs;
  var nama_depan = ''.obs;
  var nama_belakang = ''.obs;
  var noHp = ''.obs;
  var tglLahir = ''.obs;
  var jenisKelamin = ''.obs;
  var alamat = ''.obs;
  var kotaProvinsi = ''.obs;
  var negara = ''.obs;
  var kodepos = ''.obs;
  var noBpjs = ''.obs;
  var noNik = ''.obs;
  var foto = ''.obs;

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nama_depan.value = prefs.getString('nama_depan') ?? '';
    nama_belakang.value = prefs.getString('nama_belakang') ?? '';
    email.value = prefs.getString('email') ?? '';
    noHp.value = prefs.getString('no_hp') ?? '';
    tglLahir.value = prefs.getString('tgl_lahir') ?? '';
    jenisKelamin.value = prefs.getString('jenis_kelamin') ?? '';
    alamat.value = prefs.getString('alamat') ?? '';
    kotaProvinsi.value =
        '${prefs.getString('kota') ?? ''}, ${prefs.getString('provinsi') ?? ''}';
    negara.value = prefs.getString('negara') ?? '';
    kodepos.value = prefs.getString('kodepos') ?? '';
    noBpjs.value = prefs.getString('no_bpjs') ?? '';
    noNik.value = prefs.getString('no_nik') ?? '';
    foto.value = prefs.getString('foto') ?? '';
  }

  Future<void> logout() async {
    try {
      await authRepository.logout();
      Get.offAllNamed(Routes.check);
    } catch (e) {
      print('error $e');
      Get.snackbar('Error', 'Gagal logout: $e');
    }
  }
}
