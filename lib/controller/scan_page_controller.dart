import 'package:attendance_tracking/pages/camera_page.dart';
import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';

class ScanPageController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isScanning = false.obs;
  final ApiRepository apiRepository= ApiRepository();

  void forward(String uid) async {
    isLoading.value = true;
    Get.back(result: uid);
  }

}
