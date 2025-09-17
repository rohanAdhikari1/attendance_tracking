import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraPageController extends GetxController {
  CameraController? cameraController;
  var isCameraReady = false.obs;
  var capturedImages = <File>[].obs;
  var currentPosition = Rxn<Position>();
  var currentDateTime = ''.obs;
  var isFrontCamera = false.obs;

   bool singleMode = true;
   var previewing = false.obs;
   var lastCapturedPhoto = Rxn<File>();

   @override
   void onInit() {
     super.onInit();
     updateDateTime();
     setMode(single: Get.arguments ?? true);
     initCamera(false);
   }

   void setMode({required bool single}) {
     singleMode = single;
   }

   void toggleCamera() async {
     isFrontCamera.value = !isFrontCamera.value;
     isCameraReady.value = false;
     await cameraController?.dispose();
     await initCamera(isFrontCamera.value);
   }

   void updateDateTime() {
     Future.delayed(const Duration(seconds: 1), () {
       currentDateTime.value = DateTime.now().toString().split('.')[0];
       updateDateTime();
     });
   }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.back();
        Get.snackbar(
          'Permission Denied',
          'Location permission is required to tag photos.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.back();
      Get.snackbar(
        'Permission Denied Forever',
        'Location permission is permanently denied. Enable it in settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> initCamera(bool isFront) async {
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) return;
    final cameras = await availableCameras();
    final selectedCamera = isFront
        ? cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front)
        : cameras.first;
    cameraController = CameraController(selectedCamera,ResolutionPreset.low);
    await cameraController?.initialize();
    isCameraReady.value = true;

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    ).listen((pos) {
      currentPosition.value = pos;
    });
  }

  Future<File> embedTextInImage(XFile file, Position position) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image != null) {
      final font = img.arial14;
      final textColor = img.ColorRgb8(255, 255, 255);
      final int padding = 5;
      final int lineHeight = 16;

      final latLngText = 'Lat:${position.latitude}, Lng:${position.longitude}';
      final now = DateTime.now();
      final dateTimeText = 'Date: ${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} '
          '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}';

      final int latLngY = image.height - padding - (2 * lineHeight);
      final int dateTimeY = image.height - padding - lineHeight;

      img.drawString(
        image,
        font: font,
        x: padding,
        y: latLngY,
        latLngText,
        color: textColor,
      );
      img.drawString(
        image,
        font: font,
        x: padding,
        y: dateTimeY,
        dateTimeText,
        color: textColor,
      );
      final tempDir = await getTemporaryDirectory();
      final newFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await newFile.writeAsBytes(img.encodePng(image));
      return newFile;
    } else {
      return File(file.path);
    }
  }

  Future<void> pauseCamera() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      await cameraController!.pausePreview();
    }
  }

  Future<void> resumeCamera() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      await cameraController!.resumePreview();
    }
  }

  Future<void> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    final XFile file = await cameraController!.takePicture();
    final pos = currentPosition.value;
    if (pos == null) {
      Get.snackbar(
        'Location Not Available',
        'Unable to get current location.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    final File fileWithLocation = await embedTextInImage(file,pos);
    lastCapturedPhoto.value = fileWithLocation;
    previewing.value = true;
    // await pauseCamera();
  }

   void confirmPhoto() async{
     if (lastCapturedPhoto.value != null) {
       capturedImages.add(lastCapturedPhoto.value!);
       lastCapturedPhoto.value = null;
     }
     await resumeCamera();
     previewing.value = false;
     if(singleMode) finishCapture();
   }

   void discardPhoto() async{
     lastCapturedPhoto.value = null;
     previewing.value = false;
     await resumeCamera();
   }

  void finishCapture() {
    Get.back(result: {
      'images': capturedImages,
      'position': currentPosition.value,
    });
  }

  @override
  void onClose() {
    cameraController?.dispose();
    cameraController =null;
    super.onClose();
  }

}
