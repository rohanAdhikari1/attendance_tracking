import 'package:attendance_tracking/controller/home_page_controller.dart';
import 'package:attendance_tracking/pages/history_page.dart';
import 'package:attendance_tracking/pages/works_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final AppController appController = Get.put(AppController());

  final HomePageController controller = Get.put(HomePageController());

  final List<Widget> pages = [
    WorksPage(),
    HistoryPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: pages[controller.selectedIndex.value],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Get.toNamed('scan');
        },
        backgroundColor: Colors.amber[800],
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        elevation: 10,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabIcon(Icons.work, 'Works', 0),
              const SizedBox(width: 40), // space for FAB
              _buildTabIcon(Icons.history, 'History', 1),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildTabIcon(IconData icon, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? Colors.amber[800] : Colors.grey;

    return Expanded(child:  InkWell(
      onTap: () => controller.changeTabIndex(index),
      splashColor: Colors.amber[100],
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    ));
  }
}
