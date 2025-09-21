import 'package:attendance_tracking/controller/draft_inspection_controller.dart';
import 'package:attendance_tracking/pages/AppLayout.dart';
import 'package:attendance_tracking/pages/inspection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DraftInspections extends StatelessWidget {
  DraftInspections({super.key});
  final DraftInspectionController controller = Get.put(
    DraftInspectionController(),
  );

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {},
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 25),
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(()=>AppLayout(child: Inspection()));
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    "New Inspection",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[900],
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                    ), // vertical padding
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              // Text("Note: You can also scan QR code to start Inspection."),
              SizedBox(height: deviceHeight*0.03),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
                margin: EdgeInsets.only(bottom: 10),
                child:  Text('Draft Inspections:-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),

            ],
          ),
        );
      }),
    );
  }
}
