import 'package:attendance_tracking/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class ScanPageController extends GetxController {
  Location location = Location();
  bool _serviceEnabled=false;
  PermissionStatus? _permissionGranted;
  final locationData = Rx<LocationData?>(null);
  final RxBool isLoading = false.obs;
  final ApiRepository apiRepository= ApiRepository();

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  void requestLocationPermission() async{
    isLoading.value=true;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData.value = await location.getLocation();
    isLoading.value = false;
  }

  Future<void> enrollUser(String uid) async{
    isLoading.value = true;
    if (locationData.value?.latitude != null && locationData.value?.longitude != null) {
      Map<String, dynamic> jsonData = {
        "company_uid": uid,
        "start_at": DateTime.now().toIso8601String(),
        "latitude": locationData.value!.latitude,
        "longitude": locationData.value!.longitude,
      };
      var result = await apiRepository.enrollUser(jsonData);
      if (result['success']) {
        print("Response data: ${result['data']}");
        Get.back();
      } else {
        isLoading.value = false;
      }
    }
  }
}
