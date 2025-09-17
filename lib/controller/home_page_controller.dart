import 'package:attendance_tracking/controller/works_page_controller.dart';
import 'package:attendance_tracking/pages/camera_page.dart';
import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class HomePageController extends GetxController {
  var selectedIndex = 0.obs;
  var isOnline = true.obs;
  final ApiRepository apiRepository = ApiRepository();

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void handleScan() async{
    final result = await Get.toNamed('scan');
    if (result != null) {
      handleScanCallback(result);
    }else{
      Get.snackbar(
        "Error",
        "User terminate the Process",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  void handleScanCallback(String uid) async{
    var sample = await Get.to(()=>CameraPage());
    if (sample == null || sample.isEmpty) {
      Get.snackbar(
        "Cancelled",
        "User cancelled the process.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    var images = sample['images'];
    Position position = sample['position'];
    var file = images.first;
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'company_uid': uid,
        'latitude':position.latitude,
        'longitude':position.longitude,
        'file': await dio.MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      var response = await apiRepository.markAttendance(formData);
      if (response['success'] == true) {
        final WorksPageController worksPageController = Get.find<WorksPageController>();
        worksPageController.checkEnrollment(defaultOnline: !worksPageController.isOnline.value);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      // isLoading.value = false;
    }
  }
}
