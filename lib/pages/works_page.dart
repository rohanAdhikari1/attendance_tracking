import 'package:attendance_tracking/controller/works_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorksPage extends StatelessWidget {
  WorksPage({super.key});

  final WorksPageController controller = Get.put(WorksPageController());

  String formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return "N/A";

    try {
      final parts = timeString.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      String period = hour >= 12 ? "PM" : "AM";
      int hour12 = hour % 12 == 0 ? 12 : hour % 12;
      String minuteStr = minute.toString().padLeft(2, '0');
      return "$hour12:$minuteStr $period";
    } catch (e) {
      return timeString; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
         if(!controller.isLoading.value) await controller.checkEnrollment();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.isOnline.value) {
            return  Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: controller.tasks.isEmpty
                        ? const Center(
                      child: Text(
                        'No Any tasks available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ) :
                    ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.tasks[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.amber[900]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Task title with status chip
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (task.isComplete)
                                      Container(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'Completed',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                // Description
                                if (task.description.trim().isNotEmpty)
                                  Text(
                                    task.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                if (task.description.trim().isNotEmpty)
                                  const SizedBox(height: 12),

                                // Action buttons
                                Row(
                                  children: [
                                    if (task.reportId == null)
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () => controller.startWork(task.id),
                                          icon: const Icon(Icons.play_arrow),
                                          label: const Text('Start'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!task.isComplete && task.reportId != null)
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () => controller.endWork(task.reportId!),
                                          icon: const Icon(Icons.check),
                                          label: const Text('Finish'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
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
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: deviceHeight*0.05),
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Text("Please scan site Qr code to proceed the task.",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                        ),
                    textAlign:TextAlign.center),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight*0.04),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 10),
               margin: EdgeInsets.only(bottom: 10),
               child:  Text('WhiteListed Sites:-',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 )),
             ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: controller.enrollments.length,
                  itemBuilder: (context, index) {
                    final enrollment = controller.enrollments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.amber[900]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Company Name
                            Row(
                              children: [
                                Icon(Icons.business, color: Colors.amber[900], size: 22),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    enrollment.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Phone
                            if (enrollment.phone != null && enrollment.phone!.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(Icons.phone, color: Colors.green, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    enrollment.phone!,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),

                            // Address
                            if (enrollment.address1 != null || enrollment.address2 != null) ...[
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on, color: Colors.red, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "${enrollment.address1 ?? ''} ${enrollment.address2 ?? ''}".trim(),
                                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // Remark
                            if (enrollment.remark != null && enrollment.remark!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.note, color: Colors.blueGrey, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      enrollment.remark!,
                                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // Time
                            if (enrollment.startTime != null || enrollment.endTime != null) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.orange, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${formatTime(enrollment.startTime) ?? 'N/A'} - ${formatTime(enrollment.endTime) ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );






        }),
      ),
    );
  }
}
