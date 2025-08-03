// ignore_for_file: deprecated_member_use

import 'package:attendance_tracking/pages/home_page.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({super.key});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final List<String> workList = [
    'Flooring Completed',
    'Washing Completed',
    'Task Completed',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Work Detail',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        backgroundColor: const Color.fromRGBO(255, 111, 0, 1),
        elevation: 4,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                   Colors.amber[700]!,
                   Colors.amber[700]!,
                  // const Color.fromRGBO(255, 111, 0, 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                for (var work in workList) ...[
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 28),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              work,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.015),
                ],
              ],
            ),
          ),
          SizedBox(height: deviceHeight * 0.03),
          Container(
            width: deviceWidth,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent[700]!,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'You Completed 100% of Your Task Assigned',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
