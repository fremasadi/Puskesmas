import 'package:get/get.dart';

class HomeController extends GetxController {
  String getGreting() {
    final date = DateTime.now().hour;

    if (date < 12) {
      return "Selamat Pagi";
    } else if (date < 15) {
      return "Selamat Siang";
    } else if (date < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }
}
