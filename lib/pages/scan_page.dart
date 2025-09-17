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
              onDetect: (barcodeCapture) {
                if(controller.isScanning.value) return;
                controller.isScanning.value=true;
                final code = barcodeCapture.barcodes.firstOrNull;
                final String? codeData = code!.rawValue;
                if (codeData != null) {
                  controller.forward(codeData);
                }
              },
            ),

            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    // top-left corner
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 4),
                            left: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                    // top-right corner
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 4),
                            right: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                    // bottom-left corner
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 4),
                            left: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                    // bottom-right corner
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 4),
                            right: BorderSide(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ]
        );
      }
      }),
    );
  }
}
