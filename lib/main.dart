import 'package:attendance_tracking/Pages/Auth/login.dart';
import 'package:attendance_tracking/auth_controller.dart';
import 'package:attendance_tracking/pages/AppLayout.dart';
import 'package:attendance_tracking/pages/admin/admin_home_page.dart';
import 'package:attendance_tracking/pages/home_page.dart';
import 'package:attendance_tracking/pages/notification_page.dart';
import 'package:attendance_tracking/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const SplashLogic()),
        GetPage(name: '/home', page: () => AppLayout(child: HomePage())),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/scan', page: () => AppLayout(child:ScanPage())),
        GetPage(
          name: '/notification',
          page: () => AppLayout(child: NotificationPage()),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
      ],
      debugShowCheckedModeBanner: false,
      home: SplashLogic(),
    );
  }
}

class SplashLogic extends StatelessWidget {
  const SplashLogic({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else {
        FlutterNativeSplash.remove();
          if (!authController.isLoggedIn.value) {
            return const Login();
          } else {
            switch (authController.role.value) {
              case 'cleaner':
                return const AppLayout(child: HomePage());
              case 'admin':
                return const AppLayout(child:AdminHomePage());
              case 'super_admin':
                return const AppLayout(child:AdminHomePage());
              case 'company_user':
                return const AppLayout(child:AdminHomePage());
              default:
                return const Login();
            }
          }
      }
    });
  }
}
