import 'dart:convert';

import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/models/login_response.model.dart';
import 'package:chat_app_flutter/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  bool _authentic = false;
  bool get authentic => this._authentic;
  set authentic(bool auth) {
    this._authentic = auth;
    notifyListeners();
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
      return true;
    } else {
      return false;
    }
  }
}
