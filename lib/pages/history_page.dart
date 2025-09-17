import 'package:attendance_tracking/pages/detail/history_detail.dart'
    show HistoryDetail;
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final Map<String, dynamic>? enrollData;

  const HistoryPage({super.key,this.enrollData});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      // "2025-09-02 10:59:09": {
      //   "Biratnagar Branch": [
      //     {
      //       "cleaner_id": 1,
      //       "site_id": 1,
      //       "attendance_id": 3,
      //       "task_id": 1,
      //       "finish_time": "2025-09-02 10:59:09",
      //       "site": {"id": 1, "name": "Biratnagar Branch"},
      //       "task": {"id": 1, "name": "Check Task 2"}
      //     }
      //   ]
      // }
    };
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
        height: double.infinity,
        child: ListView(
          children: data.entries.map((dateEntry) {
            String date = dateEntry.key.split(" ")[0]; // only date
            Map<String, dynamic> companies = dateEntry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(12),
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Company List
                ...companies.entries.map((companyEntry) {
                  String companyName = companyEntry.key;
                  List<dynamic> tasks = companyEntry.value;

                  int totalTasks = tasks.length;
                  int finishedTasks = tasks
                      .where((task) => task["finish_time"] != null)
                      .length;

                  return Card(
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Row(
                        children: [
                          Icon(Icons.business, color: Colors.teal),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              companyName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: LinearProgressIndicator(
                          value: totalTasks == 0
                              ? 0
                              : finishedTasks / totalTasks,
                          backgroundColor: Colors.grey.shade200,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.teal),
                        ),
                      ),
                      children: tasks.map((task) {
                        bool finished = task["finish_time"] != null;
                        return ListTile(
                          leading: Icon(
                            finished ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: finished ? Colors.green : Colors.red,
                          ),
                          title: Text(task["task"]["name"]),
                          subtitle: finished
                              ? Text("Finished at ${task["finish_time"]}")
                              : Text("Pending"),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
