import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';

class DraftInspectionController extends GetxController {
  var isLoading = false.obs;
  final ApiRepository apiRepository = ApiRepository();

  @override
  void onReady() {
    super.onReady();
    getDraftInspections();
  }

  Future<void> getDraftInspections() async {
    isLoading.value = true;
    try {
      // var response = await apiRepository.fetchEnrollMentWithTask();
      // if (response['success'] == true) {
      //   List data = response['data'];
      //   if(response['is_online']){
      //     tasks.value = data.map((json) => Task.fromJson(json)).toList();
      //     isOnline.value=true;
      //   }else{
      //     enrollments.value = data.map((json) => Enrollment.fromJson(json)).toList();
      //     isOnline.value=false;
      //   }
      // }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void continueDraftInspection(){
    //TODO: Coninue taskInspection With report_ID
  }
}