import 'package:attendance_tracking/pages/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:attendance_tracking/services/user_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = true.obs;
  final userService = UserService();
  var isOnline = true.obs;
  var role =  ''.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    checkLogin();
  }

  Future<void> _checkInitialConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    isOnline.value = connectivityResult.first != ConnectivityResult.none;
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final connectivityResult = results.first;
    isOnline.value=connectivityResult != ConnectivityResult.none;
  }

  Future<void> checkLogin() async {
    final userData = await userService.getUserData();
    isLoggedIn.value = (userData['token']?.isNotEmpty ?? false) &&
        (userData['id'] != 0) &&
        (userData['role']?.isNotEmpty ?? false);
    if (isLoggedIn.value) {
      role.value = userData['role'];
    }
    isLoading.value = false;
  }
}
