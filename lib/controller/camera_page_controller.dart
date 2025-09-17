import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;

class CameraControllerX extends GetxController {
  late CameraController cameraController;
  var isCameraReady = false.obs;
  var capturedImages = <File>[].obs;
  bool isMultiple = false;

  Future<void> initCamera(bool multiple) async {
    isMultiple = multiple;
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    cameraController = CameraController(firstCamera,ResolutionPreset.high);
    await cameraController?.initialize();
    isCameraReady.value = true;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }

  Future<File> embedLocationInImage(XFile file) async {
    final position = await getCurrentLocation();
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    if (image != null) {
      img.drawString(
        image,
        img.arial_24,
        10,
        10,
        'Lat:${position.latitude}, Lng:${position.longitude}',
      );
      final tempDir = await getTemporaryDirectory();
      final newFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await newFile.writeAsBytes(img.encodePng(image));
      return newFile;
    } else {
      return File(file.path);
    }
  }

  Future<void> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    final XFile file = await cameraController!.takePicture();
    final File fileWithLocation = await embedLocationInImage(file);

    if (isMultiple) {
      capturedImages.add(fileWithLocation);
    } else {
      capturedImages.value = [fileWithLocation];
    }
  }

  void finishCapture() {
    Get.back(result: capturedImages);
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
