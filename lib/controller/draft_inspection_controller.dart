import 'package:attendance_tracking/models/InspectionModel.dart';
import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';

class DraftInspectionController extends GetxController {
  var isLoading = false.obs;
  final ApiRepository apiRepository = ApiRepository();
  var drafts = <InspectionModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getDraftInspections();
  }

  Future<void> getDraftInspections() async {
    isLoading.value = true;
    try {
      var response = await apiRepository.fetchDraftInspections();
      if (response['success'] == true) {
        List data = response['data'];
        drafts.value = data
            .map((json) => InspectionModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void continueDraftInspection() {
    //TODO: Coninue taskInspection With report_ID
  }
}
