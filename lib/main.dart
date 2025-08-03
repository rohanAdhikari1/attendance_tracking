import 'package:attendance_tracking/Pages/Auth/login.dart';
import 'package:attendance_tracking/auth_controller.dart';
import 'package:attendance_tracking/pages/home_page.dart';
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
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/scan', page: () => ScanPage()),
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
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        FlutterNativeSplash.remove();
        return authController.isLoggedIn.value
            ? const HomePage()
            : const Login();
      }
    });
  }
}
