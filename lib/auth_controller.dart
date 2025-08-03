import 'package:get/get.dart';
import 'package:attendance_tracking/services/user_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = true.obs;
  final userService = UserService();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final userData = await userService.getUserData();
    // isLoggedIn.value = (userData['token']?.isNotEmpty ?? false) &&
    //     (userData['id'] != 0) &&
    //     (userData['full_name']?.isNotEmpty ?? false);
  }
}
