import 'package:attendance_tracking/controller/home_page_controller.dart';
import 'package:attendance_tracking/pages/AppLayout.dart';
import 'package:attendance_tracking/pages/history_page.dart';
import 'package:attendance_tracking/pages/inspection.dart';
import 'package:attendance_tracking/pages/works_page.dart';
import 'package:attendance_tracking/services/user_service.dart';
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
  final List<String> pageNames = ['Available Work', 'Work History'];


  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromRGBO(255, 111, 0, 1),
              title: Center(
                child: Text(
                  pageNames[controller.selectedIndex.value],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(onPressed: () {
                  Get.toNamed('notification');
                }, icon: Icon(Icons.notifications))
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.amber[900],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.amber[900],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(
                                'assets/images/default_avatar.png'),
                          ),
                        ),
                        //     SizedBox(height: 15),
                        // Text(
                        //   pageNames[controller.selectedIndex.value],
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 21,
                        //     letterSpacing: 1.0,
                        //   ),)
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.play_arrow),
                    title: const Text('Start Inspection'),
                    onTap: () {
                      Get.to(()=>AppLayout(child: Inspection()));
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.file_copy_sharp),
                  //   title: const Text('Report'),
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const AttendanceReport(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.block),
                  //   title: const Text('Leave Application'),
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const unableToAttend(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red,),
                    title: const Text(
                        'Logout', style: TextStyle(color: Colors.red)),
                    onTap: () async {
                      UserService user = UserService();
                      await user.clearUserData();
                      Get.offAllNamed('/login');
                    },
                  ),
                ],
              ),
            ),
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body:
            SafeArea(child:
            Obx(() {
              return controller.selectedIndex.value==1?HistoryPage():WorksPage();
            }
            )),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.handleScan();
              },
              backgroundColor: Colors.amber[800],
              shape: const CircleBorder(),
              child: const Icon(Icons.qr_code_scanner, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerDocked,
            bottomNavigationBar: BottomAppBar(
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
                    const SizedBox(width: 40),
                    _buildTabIcon(Icons.history, 'History', 1),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildTabIcon(IconData icon, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? Colors.amber[900] : Colors.grey;

    return Expanded(
      child: InkWell(
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
      ),
    );
  }
}
