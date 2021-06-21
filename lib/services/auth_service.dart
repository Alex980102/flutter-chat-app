import 'dart:convert';

import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/models/login_response.model.dart';
import 'package:chat_app_flutter/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authentic = false;
  bool get authentic => this._authentic;
  set authentic(bool auth) {
    this._authentic = auth;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    final _storage = await SharedPreferences.getInstance();
    final token = _storage.getString('token') ?? 'Zero';
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = await SharedPreferences.getInstance();
    _storage.remove('token');
  }

  Future<bool> login(String email, String password) async {
    this.authentic = true;
    final data = {'email': email, 'password': password};
    final res = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.authentic = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.user;
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '0';
    final res = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.logOut();
      return false;
    }
  }

  Future _saveToken(String token) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.setString('token', token);
  }

  Future logOut() async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.remove('token');
  }
}
