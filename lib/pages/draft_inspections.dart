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
      onRefresh: () async {
        await controller.getDraftInspections();
      },
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
                    Get.to(() => AppLayout(child: Inspection()));
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
              SizedBox(height: deviceHeight * 0.03),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Draft Inspections:-',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: controller.drafts.length,
                  itemBuilder: (context, index) {
                    final draft = controller.drafts[index];
                    final d = DateTime.tryParse(draft.date) ?? DateTime.now();
                    final months = [
                      "Jan",
                      "Feb",
                      "Mar",
                      "Apr",
                      "May",
                      "Jun",
                      "Jul",
                      "Aug",
                      "Sep",
                      "Oct",
                      "Nov",
                      "Dec",
                    ];
                    final formattedDate =
                        "${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}";
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 6.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.amber[900]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // LEFT SIDE → all info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.business,
                                        color: Colors.amber[900],
                                        size: 22,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          draft.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Site name
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 18,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          draft.siteName,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Frequency
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.repeat,
                                        size: 18,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        draft.frequency,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green[800],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            // RIGHT SIDE → Start button (centered vertically)
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[900],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.play_arrow, size: 18),
                              label: const Text("Start"),
                              onPressed: () {
                                // Action to start inspection
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
