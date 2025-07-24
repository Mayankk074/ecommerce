import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Helper class for jwt storage
class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  static Future<void> setToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }
}