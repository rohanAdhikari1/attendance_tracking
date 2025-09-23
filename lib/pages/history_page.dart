import 'dart:convert';

import 'package:attendance_tracking/controller/history_controller.dart';
import 'package:attendance_tracking/pages/detail/history_detail.dart'
    show HistoryDetail;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class HistoryPage extends StatelessWidget {
  final Map<String, dynamic>? enrollData;
  final HistoryController controller = Get.put(HistoryController());

  HistoryPage({super.key, this.enrollData});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        if(!controller.isLoading.value) await controller.getHistories();
      },
      child: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
            height: double.infinity,
            child: GroupedListView(
              elements: controller.histories,
              useStickyGroupSeparators: true,
              groupBy: (element) => element['finish_date'],
              groupSeparatorBuilder: (value) => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(value, style: TextStyle(color: Colors.amber[900])),
              ),
              itemBuilder: (context, element) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(element['site']?['name']),
                );
              },
              order: GroupedListOrder.ASC,
            ),
          );
        }),
      ),
    );
  }
}
