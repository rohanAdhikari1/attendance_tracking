import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveUserData(String token, int id,String role) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'id', value: id.toString());
    await _storage.write(key: 'role', value: role);
  }

  Future<Map<String, dynamic>> getUserData() async {
    String? token = await _storage.read(key: 'token');
    String? idString = await _storage.read(key: 'id');
    String? role = await _storage.read(key: 'role');
    int id = idString != null ? int.parse(idString) : 0;

    return {
      'token': token ?? '',
      'id': id,
      'role': role
    };
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'id');
    await _storage.delete(key: 'role');
  }
}
