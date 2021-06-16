import 'package:chat_app_flutter/helpers/show_alert.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:chat_app_flutter/widgets/btn_blue.dart';
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.widget.dart';
import 'package:chat_app_flutter/widgets/logo.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  logo(
                    title: 'Log In',
                  ),
                  _Form(),
                  Labels(
                    subtitle: 'Do not have an account',
                    tile: 'Create an acount',
                    ruta: 'register',
                  ),
                  Text(
                    'terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
    primary: Colors.amber,
    elevation: 2,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2))),
  );
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),
          /* ElevatedButton(
            style: style,
            onPressed: () {},
            child: Text('Hola'),
          ), */
          BlueButton(
              text: 'Log In',
              onPressed: authService.authentic
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());
                      if (loginOk) {
                        // TODO: Navegar a otra pantalla y navegar a los sockets
                        Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        // TODO: Mostrar alerta
                        showAlert(
                            context,
                            'There was a problem trying to login ',
                            'Check your email and password or create an account.');
                      }
                    })
        ],
      ),
    );
  }
}
