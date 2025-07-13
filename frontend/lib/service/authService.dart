
import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/service/storageHelper.dart';

import '../model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Authservice{

  final _authStateController = StreamController<User?>.broadcast();
  
  Stream<User?> get authStateChanges => _authStateController.stream;

  Future<void> login(String username, String password) async {
    print("login");
    final response = await http.post(
      Uri.parse('http://192.168.1.100:8080/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      print(data['user']);
      //storage
      await SecureStorageHelper.setToken(token);
      final user = User.fromJson(data['user']);
      _authStateController.add(user);
      print("added: $user");
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> register(String username, String password) async {
    print("register");
    final response = await http.post(
      Uri.parse('http://192.168.1.100:8080/register'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['user']);
      final user = User.fromJson(data['user']);
      _authStateController.add(user);
      print("added: $user");
    } else {
      throw Exception('Login failed');
    }
  }
}
