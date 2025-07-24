
import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/service/storageHelper.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;

class Authservice{

  final _authStateController = StreamController<User?>.broadcast();
  
  Stream<User?> get authStateChanges => _authStateController.stream;

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      //storage
      await SecureStorageHelper.setToken(token);
      final user = User.fromJson(data['user']);
      _authStateController.add(user);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['user']);
      _authStateController.add(user);
    } else {
      throw Exception('Login failed');
    }
  }
}
