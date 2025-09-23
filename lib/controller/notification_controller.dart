import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  final ApiRepository apiRepository = ApiRepository();
  var notifications = RxList<Map<String,dynamic>>();

  @override
  void onReady() {
    super.onReady();
    getNotifications();
  }

  Future<void> getNotifications() async {
    isLoading.value = true;
    try {
      var response = await apiRepository.fetchNotifications();
      if (response['success'] == true) {
        List data = response['data'];
        notifications.value = List<Map<String, dynamic>>.from(data);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}