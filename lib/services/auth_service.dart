import 'dart:convert';

import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/models/login_response.model.dart';
import 'package:chat_app_flutter/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  bool _authentic = false;
  final _storage = FlutterSecureStorage();
  bool get authentic => this._authentic;
  set authentic(bool auth) {
    this._authentic = auth;
    notifyListeners();
  }

  /// **Getters** and **Setter** for the static form
  static Future getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.authentic = true;
    final data = {'email': email, 'password': password};
    final res = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(res.body);
    this.authentic = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.user;
      // TODO: Guardar token en lugar seguro
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future cretaAcount(String name, String email, String password) async {
    try {
      this.authentic = true;
      final data = {'name': name, 'email': email, 'password': password};
      final res = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      print(res.body);
      this.authentic = false;
      final response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final loginResponse = loginResponseFromJson(res.body);
        this.user = loginResponse.user;
        await this._saveToken(loginResponse.token);
        return response;
      }
      if (res.statusCode == 400) {
        return response;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final res = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});
    print(res.body);

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
