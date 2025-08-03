import 'package:attendance_tracking/controller/scan_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});
  final ScanPageController controller = Get.put(ScanPageController());
  final MobileScannerController scannerController = MobileScannerController(
    torchEnabled: false,
    autoZoom: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () {
              scannerController.toggleTorch();
            },
          ),
        ],
      ),
      body:
      Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }else
      {
        return Stack(
          children:[
            MobileScanner(
              controller: scannerController,
              onDetect: (barcodeCapture) async {
                final code = barcodeCapture.barcodes.firstOrNull;
                final String? codeData = code!.rawValue;
                if (codeData != null) {
                  await controller.enrollUser(codeData);
                }
              },
            ),
            Column(children: [
              Row(children: [
                Text('Latitude:-'),
                Text(controller.locationData.value?.latitude?.toString()??''),
              ],),
        Row(children: [
        Text('Longitude:-'),
        Text(controller.locationData.value?.longitude?.toString()??''),
        ],)
            ],)
          ]
        );
      }
      }),
    );
  }
}
