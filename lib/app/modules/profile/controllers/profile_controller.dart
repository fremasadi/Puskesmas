import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/repository/auth_repository.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  var email = ''.obs;
  var noHp = ''.obs;
  var tglLahir = ''.obs;
  var jenisKelamin = ''.obs;
  var alamat = ''.obs;
  var kotaProvinsi = ''.obs;
  var negara = ''.obs;
  var kodepos = ''.obs;

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? '';
    noHp.value = prefs.getString('no_hp') ?? '';
    tglLahir.value = prefs.getString('tgl_lahir') ?? '';
    jenisKelamin.value = prefs.getString('jenis_kelamin') ?? '';
    alamat.value = prefs.getString('alamat') ?? '';
    kotaProvinsi.value =
        '${prefs.getString('kota') ?? ''}, ${prefs.getString('provinsi') ?? ''}';
    negara.value = prefs.getString('negara') ?? '';
    kodepos.value = prefs.getString('kodepos') ?? '';
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
