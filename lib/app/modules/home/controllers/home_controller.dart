import 'package:get/get.dart';
import 'package:puskesmas/app/modules/profile/controllers/profile_controller.dart';

import '../../../core/repository/queue_repository.dart';

class HomeController extends GetxController {
  final queueList = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final profileController = Get.find<ProfileController>();

  final QueueRepository queueRepository = QueueRepository();

  @override
  void onInit() {
    super.onInit();
    fetchQueueHistory();
    profileController.loadUserData();
  }

  Future<void> fetchQueueHistory() async {
    isLoading(true);
    try {
      final result = await queueRepository.getQueueData();
      queueList.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data antrian: $e');
    } finally {
      isLoading(false);
    }
  }

  String getGreting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat pagi';
    } else if (hour < 17) {
      return 'Selamat siang';
    } else {
      return 'Selamat malam';
    }
  }

  final medicalRecord = Rxn<Map<String, dynamic>>();
  final isRecordLoading = false.obs;

  Future<void> fetchMedicalRecord(int queueId) async {
    isRecordLoading(true);
    try {
      final result = await queueRepository.getMedicalRecord(queueId);
      medicalRecord.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil rekam medis: $e');
    } finally {
      isRecordLoading(false);
    }
  }
}
