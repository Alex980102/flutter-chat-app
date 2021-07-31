import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/models/user_response.model.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List> getUsers() async {
    try {
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        },
      );
      final usersResponse = usersResponseFromJson(resp.body);
      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
