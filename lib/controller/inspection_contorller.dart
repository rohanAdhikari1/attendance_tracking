import 'dart:convert';
import 'dart:io';

import 'package:attendance_tracking/pages/camera_page.dart';
import 'package:attendance_tracking/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InspectionController extends GetxController {
  var webViewController = Rxn<WebViewController>();
  final UserService _userService = UserService();
  var isLoading = true.obs;
  var isUploading = false.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async{
    var user = await _userService.getUserData();
    String token = user['token'];
    webViewController.value = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (webViewController.value != null) {
              webViewController.value!.loadRequest(
                Uri.parse(request.url),
                headers: {
                  'Authorization': 'Bearer $token',
                },
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onPageFinished: (url) async{
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            isLoading.value = false;
            hasError.value = true;
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message){
          final Map<String, dynamic> data = jsonDecode(message.message);
          if (data['action'] == 'upload') {
            startUpload(data['record_id']);
          }else if(data['action'] == 'finish'){
            Get.back();
            Get.snackbar(
              "Success",
              "Inspection completed successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: EdgeInsets.all(10),
              duration: Duration(seconds: 3),
            );
          }
        },
      )
      ..loadRequest(Uri.parse("https://sms.westernbreezeau.com/startInspection"),
        headers: {
          'Authorization': 'Bearer $token',
        },);
  }

  void startUpload(int recordId) async{
    isUploading.value = true;
    var result = await Get.to(()=>CameraPage(),arguments: false);
    List<File> files = result["images"] ?? [];
    List<String> filePaths = files.map((file) => base64Encode(file.readAsBytesSync())).toList();
    Position? position = result["position"];
    Map<String, dynamic>? positionMap;
    if (position != null) {
      positionMap = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
    }
    Future.delayed(const Duration(seconds: 3), () {
      isUploading.value = false;
      sendMessageToJS({
        "record_id": recordId,
        "action": "upload_completed",
        "images": filePaths,
        "position": positionMap,
      });
    });
  }

  void sendMessageToJS(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    webViewController.value!.runJavaScript(
        "if (typeof onFlutterMessage === 'function') { onFlutterMessage($jsonString); }"
    );
  }

}
