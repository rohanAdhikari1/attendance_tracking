import 'package:attendance_tracking/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notifications',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                // letterSpacing: 1.0,
              ),
            ),
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
      body: SafeArea(child: RefreshIndicator(onRefresh: () async{
        if(!controller.isLoading.value) await controller.getNotifications();
      },
        child: Obx((){
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return  Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: controller.notifications.isEmpty
                      ? const Center(
                    child: Text(
                      'No Any Notifications',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ) :
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = controller.notifications[index];

                      final title = notification['data']?['title'] ?? 'No Title';
                      final body = notification['data']?['body'] ?? '';
                      final createdAt = notification['created_at'] ?? '';
                      final isRead = notification['read_at'] != null;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: isRead ? Colors.white : Colors.yellow[50],
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: isRead ? Colors.grey[300]! : Colors.amber[900]!,
                            ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isRead ? Colors.black87 : Colors.amber[900],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                                      color: isRead ? Colors.green : Colors.red,
                                    ),
                                    onPressed: () {
                                      // controller.markAsRead(notification['id']);
                                    },
                                  ),
                                ],
                              ),
                              if (body.isNotEmpty)
                                Html(
                                  data: body,
                                  style: {
                                    "body": Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                    ),
                                    "p": Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                      fontSize: FontSize(14),
                                      color: Colors.black87,
                                    ),
                                    "strong": Style(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  },
                                ),

                              const SizedBox(height: 8),
                              Text(
                                createdAt.toString(),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )

                ),
              ],
            ),
          );
        })
        ,)),
    );
  }
}
