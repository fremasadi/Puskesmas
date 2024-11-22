import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puskesmas/app/routes/app_pages.dart';


class SplashController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skip() {
    Get.offNamed(Routes.LOGIN);
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void enterApp() {
    Get.offNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
