import 'package:attendance_tracking/controller/inspection_contorller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Inspection extends StatelessWidget {
  Inspection({super.key});

  final InspectionController controller = Get.put(InspectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inspection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                // letterSpacing: 1.0,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.amber[900],
      ),
      body: Obx(() {
        if (controller.webViewController.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            WebViewWidget(controller: controller.webViewController.value!),
            Obx(() {
              if (controller.isLoading.value) {
                return Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Obx(() {
              if (controller.isUploading.value) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.greenAccent),
                        SizedBox(height: 10),
                        Text(
                          'Uploading Photo...',
                          style: TextStyle(color: Colors.amber[900],fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        );
      }),
    );
  }
}
