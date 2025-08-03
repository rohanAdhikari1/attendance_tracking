import 'package:attendance_tracking/data/enums.dart';
import 'package:attendance_tracking/services/user_service.dart';
import 'package:dio/dio.dart';

class AuthService {
  final UserService _userService = UserService();

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.67:8000/api/',
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
        print(response.data);
        String token = response.data['token'];
        int id = response.data['user']?['id'];
        String fullName = response.data['user']?['full_name']??'';
        String username = response.data['user']?['username']??'';
        String email = response.data['user']?['email']??'';
        String phone= response.data['user']?['phone']??'';
        String address1= response.data['user']?['address1']??'';
        String address2= response.data['user']?['address2']??'';
        await _userService.saveUserData(token,id,fullName,email,username,phone,address1,address2);
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
      return {
        'message': e.response?.data['message']?.toString() ?? e.message ?? 'A network error occurred.',
        'type': MessageType.error,
      };
    }catch (e) {
      print(e);
      return {
        'message': 'An error occurred. Please try again later.',
        'type': MessageType.error,
      };
    }
  }
}
