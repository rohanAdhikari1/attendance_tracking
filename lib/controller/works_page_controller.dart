import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class WorksPageController extends GetxController {
  var tasks = <Task>[].obs;
  var isLoading = false.obs;
  var company = "".obs;
  var isEnrolled = false.obs;

  final ApiRepository apiRepository = ApiRepository();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? companyUid = prefs.getString('company_uid');
      company.value = prefs.getString('company_name')??'';
      if (companyUid == null) {
        isEnrolled.value = false;
        company.value = "";
        tasks.clear();
        return;
      }
      isEnrolled.value = true;
      var response = await apiRepository.fetchTasksByCompany(companyUid);
      if (response['success'] == true) {
        List data = response['data'];
        tasks.value = data.map((json) => Task.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch tasks");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
