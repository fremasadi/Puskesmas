import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/repository/queue_repository.dart';

class QueueController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final tglPeriksaController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final keteranganController = TextEditingController();
  final isLoading = false.obs;

  // Reactive properties for text values
  final tglPeriksaText = RxString(''); // Make this observable
  final startTimeText = ''.obs;
  final endTimeText = ''.obs;

  // Other reactive properties
  final selectedPoliId = Rx<int?>(null);
  var selectedDoctorId = Rxn<int>(); // bukan cuma int atau RxInt
  final polis = <Map<String, dynamic>>[].obs;
  final doctors = <Map<String, dynamic>>[].obs;
  final jadwalSlots = <Map<String, dynamic>>[].obs;

  final QueueRepository queueRepository = QueueRepository();

  @override
  void onInit() {
    super.onInit();
    fetchPoliList();

    // Listener manual
    tglPeriksaController.addListener(() {
      tglPeriksaText.value = tglPeriksaController.text;
    });

    startTimeController.addListener(() {
      startTimeText.value = startTimeController.text;
    });

    endTimeController.addListener(() {
      endTimeText.value = endTimeController.text;
    });

    // 🔥 Tambahkan listener reaktif agar fetch slot saat dokter/tanggal berubah
    everAll([selectedDoctorId, tglPeriksaText], (_) {
      if (selectedDoctorId.value != null && tglPeriksaText.value.isNotEmpty) {
        fetchJadwalDokter();
      }
    });
  }

  @override
  void onClose() {
    // Hapus listener saat controller dihapus
    startTimeController.dispose();
    endTimeController.dispose();
    tglPeriksaController.dispose();
    keteranganController.dispose();
    super.onClose();
  }

  Future<void> fetchPoliList() async {
    try {
      final result = await queueRepository.getPoliData();
      polis.assignAll(result.cast<Map<String, dynamic>>());
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data poli: $e');
    }
  }

  Future<void> onPoliChanged(int idPoli) async {
    try {
      selectedPoliId.value = idPoli;
      selectedDoctorId.value = null; // reset dokter
      // Reset jadwal saat dokter berubah
      jadwalSlots.clear();
      startTimeController.clear();
      endTimeController.clear();

      final result = await queueRepository.getDokterByPoli(idPoli);
      doctors.assignAll(result.cast<Map<String, dynamic>>());
      update(); // <--- INI TAMBAHIN
    } catch (e) {
      Get.snackbar('Error', 'Gagal ambil dokter: $e');
    }
  }

  void onDoctorChanged(int? doctorId) {
    selectedDoctorId.value = doctorId;

    // Reset slot & waktu saat ganti dokter
    startTimeController.clear();
    endTimeController.clear();
    jadwalSlots.clear();

    // Kalau tanggal sudah dipilih, langsung fetch jadwal baru
    if (tglPeriksaController.text.isNotEmpty && doctorId != null) {
      fetchJadwalDokter();
    }

    update();
  }

  Future<void> fetchJadwalDokter() async {
    tglPeriksaText.value = tglPeriksaController.text;
    isLoading(true);
    try {
      final doctorId = selectedDoctorId.value;
      final tanggal = tglPeriksaController.text;

      if (doctorId == null || tanggal.isEmpty) return;

      final result = await queueRepository.getJadwalDokter(doctorId, tanggal);
      final slots = result['slots'] as List<dynamic>;
      jadwalSlots.assignAll(slots.cast<Map<String, dynamic>>());
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil jadwal: $e');
    } finally {
      isLoading(false);
    }
  }

  void submitForm() async {
    if (selectedDoctorId.value == null) {
      Get.snackbar('Error', 'Please select a doctor first.');
      return;
    }

    if (startTimeController.text.isEmpty || endTimeController.text.isEmpty) {
      Get.snackbar('Error', 'Silahkan pilih waktu kunjungan.');
      return;
    }

    final data = {
      "doctor_id": selectedDoctorId.value,
      "tgl_periksa": tglPeriksaController.text,
      "start_time": startTimeController.text,
      "end_time": endTimeController.text,
      "keterangan": keteranganController.text,
    };

    // Debugging: Print the data to verify its correctness
    print('Form data: $data');

    // Calling the repository to submit the data
    try {
      await queueRepository.submitQueueData(data);
      Get.snackbar(
        'Sukses',
        'Pendaftaran berhasil dikirim!',
        backgroundColor: Colors.green[100],
        colorText: Colors.black87,
        duration: const Duration(seconds: 3),
      );

      // Reset form setelah berhasil
      _resetForm();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Gagal mengirim data pendaftaran. Silahkan coba lagi.',
        backgroundColor: Colors.red[100],
        colorText: Colors.black87,
      );
    }
  }

  void _resetForm() {
    selectedPoliId.value = null;
    selectedDoctorId.value = null;
    tglPeriksaController.clear();
    startTimeController.clear();
    endTimeController.clear();
    keteranganController.clear();
    jadwalSlots.clear();
    update();
  }
}
