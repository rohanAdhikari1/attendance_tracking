import 'package:attendance_tracking/models/Enrollment.dart';
import 'package:attendance_tracking/pages/camera_page.dart';
import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../models/task.dart';
import 'package:dio/dio.dart' as dio;


class WorksPageController extends GetxController {
  var tasks = <Task>[].obs;
  var enrollments = <Enrollment>[].obs;
  var isLoading = false.obs;
  var company = "".obs;
  var isOnline = false.obs;

  final ApiRepository apiRepository = ApiRepository();

  @override
  void onReady() {
    super.onReady();
    checkEnrollment();
  }

  Future<void> checkEnrollment({bool? defaultOnline}) async {
    isLoading.value = true;
    isOnline.value = defaultOnline ?? isOnline.value;
    try {
        var response = await apiRepository.fetchEnrollMentWithTask();
        if (response['success'] == true) {
          List data = response['data'];
          if(response['is_online']){
            tasks.value = data.map((json) => Task.fromJson(json)).toList();
            isOnline.value=true;
          }else{
            enrollments.value = data.map((json) => Enrollment.fromJson(json)).toList();
            isOnline.value=false;
          }
        }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  void startWork(int taskId)async{
    var result = await Get.to(()=>CameraPage(),arguments: false);
    if (result != null) {
      handleStartCameraCallBack(taskId,result);
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

  void endWork(int reportId) async{
    var result = await Get.to(()=>CameraPage(),arguments: false);
    if (result != null) {
      handleFinishCameraCallBack(reportId,result);
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

  void handleStartCameraCallBack(int taskId,dynamic result) async{
    try {
      var images = result['images'];
      Position position = result['position'];
      List<dio.MultipartFile> multipartImages = [];
      for (var file in images) {
        multipartImages.add(
          await dio.MultipartFile.fromFile(
            file.path,
            filename: file.path
                .split('/')
                .last,
          ),
        );
      }
      dio.FormData formData = dio.FormData.fromMap({
        'task_id': taskId,
        'latitude':position.latitude,
        'longitude':position.longitude,
        'files[]': multipartImages,
      });
      var response = await apiRepository.startWork(formData);
      if (response['success'] == true) {
        // checkEnrollment();
        var reportId = response['report_id'];
        Task? task = tasks.firstWhereOrNull((t) => t.id == taskId);
        if (task != null) {
          task.reportId = reportId;
          tasks.refresh();
        }
        Get.snackbar("Success", response['data']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      // isLoading.value = false;
    }
  }

  void handleFinishCameraCallBack(int reportId,dynamic result) async{
    try {
      var images = result['images'];
      Position position = result['position'];
      List<dio.MultipartFile> multipartImages = [];
      for (var file in images) {
        multipartImages.add(
          await dio.MultipartFile.fromFile(
            file.path,
            filename: file.path
                .split('/')
                .last,
          ),
        );
      }
      dio.FormData formData = dio.FormData.fromMap({
        'report_id': reportId,
        'latitude':position.latitude,
        'longitude':position.longitude,
        'files[]': multipartImages,
      });
      var response = await apiRepository.finishWork(formData);
      if (response['success'] == true) {
        // checkEnrollment();
        Task? task = tasks.firstWhereOrNull((t) => t.reportId == reportId);
        if (task != null) {
          task.isComplete = true;
          tasks.refresh();
        }
        Get.snackbar("Success", response['data']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      // isLoading.value = false;
    }
  }

}
