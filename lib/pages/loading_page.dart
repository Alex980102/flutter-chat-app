import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:chat_app_flutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
              child: Lottie.asset('assets/message-arrow.json', width: 150));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final authenticated = await authService.isLoggedIn();

    if (authenticated) {
      socketService.connect();
      Navigator.pushNamed(context, 'users');
    } else {
      Navigator.pushNamed(context, 'login');
    }
  }
}
