import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController{
  var isLoading = false.obs;
  var histories = RxList<Map<String,dynamic>>();
  final ApiRepository apiRepository = ApiRepository();

  @override
  void onReady() {
    super.onReady();
    getHistories();
  }

  Future<void> getHistories() async {
    isLoading.value = true;
    try {
      var response = await apiRepository.fetchWorkHistory();
      if (response['success'] == true) {
        List data = response['data'];
        histories.value = List<Map<String, dynamic>>.from(data);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}