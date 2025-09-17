import 'package:attendance_tracking/data/enums.dart';
import 'package:attendance_tracking/services/user_service.dart';
import 'package:dio/dio.dart';

class AuthService {
  final UserService _userService = UserService();

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.100.153:8000/api/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<Map<String,dynamic>> login(String login, String password) async {
    try {
      Response response = await _dio.post(
        'login',
        data: {
          'login': login,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        String token = response.data['token'];
        int id = response.data['user']?['id'];
        String role = response.data['role']??'user';
        await _userService.saveUserData(token,id,role);
        return {
          'message': 'Login successful',
          'type': MessageType.success,
        };
      } else {
        return {
          'message': response.data['message'] ?? 'Login failed! Please check your credentials.',
          'type': MessageType.error,
        };
      }
    }  on DioException catch (e){
      print(e.response);
      return {
        'message': e.response?.data['error']?.toString() ?? 'A network error occurred.',
        'type': MessageType.error,
      };
    }catch (e) {
      return {
        'message': 'An error occurred. Please try again later.',
        'type': MessageType.error,
      };
    }
  }
}
