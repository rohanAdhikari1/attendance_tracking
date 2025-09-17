import 'dart:io';

import 'package:attendance_tracking/controller/camera_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatelessWidget {

  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraPageController controller = Get.put(CameraPageController());

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isCameraReady.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.previewing.value && controller.lastCapturedPhoto.value != null) {
          return _buildPreview(context, controller.lastCapturedPhoto.value!);
        }

        return Stack(
          children: [
            Center(
              child:CameraPreview(controller.cameraController!),
            ),
            Positioned(
                left: 16,
                bottom: size.height * 0.2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date
                      Text(
                        controller.currentDateTime.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                        ),
                      ),
                      // Location (if available)
                      if (controller.currentPosition.value != null)
                        Text(
                          'Lat: ${controller.currentPosition.value!.latitude}, Lng: ${controller.currentPosition.value!.longitude}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                          ),
                        ),
                    ]),
            ),


            Positioned(
              top: size.height * 0.05,
              right: 20,
              child: Obx(() => FloatingActionButton(
                mini: true,
                backgroundColor: Colors.black54,
                onPressed: controller.toggleCamera,
                child: Icon(
                  controller.isFrontCamera.value
                      ? Icons.flip_camera_ios_rounded
                      : Icons.cameraswitch,
                  color: Colors.white,
                ),
              )),
            ),


            Positioned(
              bottom: 30,
              left: size.width / 2 - 30,
              child: FloatingActionButton(
                onPressed: controller.capturePhoto,
                child: const Icon(Icons.camera),
              ),
            ),

            if (!controller.singleMode)
              Positioned(
                bottom: 30,
                right: 20,
                child: Obx(() {
                  if (controller.capturedImages.isEmpty) return const SizedBox();
                  return FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: controller.finishCapture,
                    child: const Icon(Icons.check),
                  );
                }),
              ),


            if (!controller.singleMode)
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Obx(() => SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.capturedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.file(
                          controller.capturedImages[index],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                )),
              ),

          ],
        );
      }),
    );
  }

  Widget _buildPreview(BuildContext context, File photo) {

    final controller = Get.find<CameraPageController>();

    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(photo, fit: BoxFit.contain),
        ),
        // Reject button
        Positioned(
          bottom: 30,
          left: 40,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: controller.discardPhoto,
            child: const Icon(Icons.close),
          ),
        ),
        // Accept button
        Positioned(
          bottom: 30,
          right: 40,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: controller.confirmPhoto,
            child: const Icon(Icons.check),
          ),
        ),
        // Optional: show number of accepted photos in multiple mode
        if (!controller.singleMode)
          Positioned(
            top: 40,
            left: 20,
            child: Obx(() => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                'Accepted: ${controller.capturedImages.length}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
          ),
      ],
    );
  }
}
