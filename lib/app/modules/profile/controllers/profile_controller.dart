import 'package:get/get.dart';

import '../../../core/repository/auth_repository.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

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
