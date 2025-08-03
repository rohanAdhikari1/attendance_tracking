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
                if(controller.isScanning.value) return;
                controller.isScanning.value=true;
                final code = barcodeCapture.barcodes.firstOrNull;
                final String? codeData = code!.rawValue;
                if (codeData != null) {
                  await controller.enrollUser(codeData);
                }
              },
            ),
            // Positioned(
            //   bottom: 20,
            //   left: 20,
            //   right: 20,
            //   child: SafeArea(
            //     child: Container(
            //       padding: const EdgeInsets.all(12),
            //       decoration: BoxDecoration(
            //         color: Color.fromARGB(180, 0, 0, 0),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               const Text(
            //                 'Latitude: ',
            //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 controller.locationData.value?.latitude?.toString() ?? 'Unknown',
            //                 style: const TextStyle(color: Colors.white),
            //               ),
            //             ],
            //           ),
            //           const SizedBox(height: 4),
            //           Row(
            //             children: [
            //               const Text(
            //                 'Longitude: ',
            //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 controller.locationData.value?.longitude?.toString() ?? 'Unknown',
            //                 style: const TextStyle(color: Colors.white),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ]
        );
      }
      }),
    );
  }
}
