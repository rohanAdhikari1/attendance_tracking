import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveUserData(String token, int id, String fullName, String email, String username, String phone, String address1, String address2) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'id', value: id.toString());
    await _storage.write(key: 'full_name', value: fullName);
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'phone', value: phone);
    await _storage.write(key: 'address1', value: address1);
    await _storage.write(key: 'address2', value: address2);
  }

  Future<Map<String, dynamic>> getUserData() async {
    String? token = await _storage.read(key: 'token');
    String? idString = await _storage.read(key: 'id');
    String? fullName = await _storage.read(key: 'full_name');
    String? email = await _storage.read(key: 'email');
    String? username = await _storage.read(key: 'username');
    String? phone = await _storage.read(key: 'phone');
    String? address1 = await _storage.read(key: 'address1');
    String? address2 = await _storage.read(key: 'address2');

    int id = idString != null ? int.parse(idString) : 0;

    return {
      'token': token ?? '',
      'id': id,
      'full_name': fullName ?? '',
      'email':email??'',
      'username':username??'',
      'phone':phone??'',
      'address1':address1??'',
    };
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'id');
    await _storage.delete(key: 'full_name');
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'phone');
    await _storage.delete(key: 'address1');
    await _storage.delete(key: 'address2');
  }
}
