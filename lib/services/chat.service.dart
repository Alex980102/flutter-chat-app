import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/models/messages_response.dart';
import 'package:chat_app_flutter/models/user.model.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User userFor;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/messages/$userID'),
      headers: {
        'Content-Type': 'Application/json',
        'x-token': await AuthService.getToken()
      },
    );
    final messageResp = messagesResponseFromJson(resp.body);
    return messageResp.messages;
  }
}
