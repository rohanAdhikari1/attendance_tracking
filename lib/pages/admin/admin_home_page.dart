import 'package:attendance_tracking/pages/draft_inspections.dart';
import 'package:attendance_tracking/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final List<String> pageNames = ['Inspections', 'History'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(255, 111, 0, 1),
        title: Center(
          child: Text(
            pageNames[0],
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
        ],),
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
                ],
              ),
            ),
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
      body: SafeArea(child: DraftInspections()),
    );
  }
}
