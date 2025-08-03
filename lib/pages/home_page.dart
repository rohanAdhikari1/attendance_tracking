import 'package:attendance_tracking/controller/home_page_controller.dart';
import 'package:attendance_tracking/pages/history_page.dart';
import 'package:attendance_tracking/pages/works_page.dart';
import 'package:attendance_tracking/widgets/drawer/attendance_report.dart'
    show AttendanceReport;
import 'package:attendance_tracking/widgets/drawer/myprofile.dart'
    show Myprofile;
import 'package:attendance_tracking/widgets/drawer/site_message.dart'
    show SiteMessage;
import 'package:attendance_tracking/widgets/drawer/unable_to_attend.dart'
    show unableToAttend;
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

  final List<Widget> pages = [WorksPage(), HistoryPage()];
  
 

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 212, 91, 105),
          title: const Center(
            child: Text(
              'Welcome Mr. XYZ',
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
            Padding(
              padding: const EdgeInsets.all(7),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/me.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 91, 105),
                ),
                child: CircleAvatar(
                  radius: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset('assets/images/me.jpg'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Myprofile()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Admin Messages'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SiteMessage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy_sharp),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AttendanceReport(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Leave Application'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const unableToAttend(),
                    ),
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.logout),
              //   title: const Text('Logout'),
              //   onTap: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => const loginPage()),
              //     );
              //   },
              // ),
            ],
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body:
         SafeArea(child: pages[controller.selectedIndex.value]), 
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('scan');
          },
          backgroundColor: Colors.amber[800],
          shape: const CircleBorder(),
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    final color = isSelected ? Colors.amber[800] : Colors.grey;

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
