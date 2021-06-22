import 'package:chat_app_flutter/helpers/show_alert.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:chat_app_flutter/widgets/btn_blue.dart';
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.widget.dart';
import 'package:chat_app_flutter/widgets/logo.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
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
                    title: 'Register',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    tile: 'Log in with your acount',
                    subtitle: 'Do you have an acount?',
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
  final nameCtrl = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: 'Name',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
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
            text: 'Create Acount',
            onPressed: authService.authentic
                ? null
                : () async {
                    try {
                      final registerOk = await authService.cretaAcount(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim(),
                      );
                      if (registerOk.containsKey("errors")) {
                        Map _errors = registerOk["errors"];
                        if (_errors.containsKey("email") &&
                            _errors.containsKey("password") &&
                            _errors.containsKey("name")) {
                          return showAlert(
                              context,
                              "Error",
                              registerOk["errors"]["name"]["msg"] +
                                  "\n" +
                                  registerOk["errors"]["email"]["msg"] +
                                  "\n" +
                                  registerOk["errors"]["password"]["msg"]);
                        }
                        if (_errors.containsKey("email") &&
                            _errors.containsKey("name")) {
                          return showAlert(
                              context,
                              "Error",
                              registerOk["errors"]["email"]["msg"] +
                                  "\n" +
                                  registerOk["errors"]["name"]["msg"]);
                        }
                        if (_errors.containsKey("name") &&
                            _errors.containsKey("password")) {
                          return showAlert(
                              context,
                              "Error",
                              registerOk["errors"]["name"]["msg"] +
                                  "\n" +
                                  registerOk["errors"]["password"]["msg"]);
                        }
                        if (_errors.containsKey("email") &&
                            _errors.containsKey("password")) {
                          return showAlert(
                              context,
                              "Error",
                              registerOk["errors"]["email"]["msg"] +
                                  "\n" +
                                  registerOk["errors"]["password"]["msg"]);
                        }
                        if (_errors.containsKey("email")) {
                          return showAlert(context, "Error",
                              registerOk["errors"]["email"]["msg"]);
                        }
                        if (_errors.containsKey("password")) {
                          return showAlert(context, "Error",
                              registerOk["errors"]["password"]["msg"]);
                        }
                      }
                      if (registerOk["ok"]) {
                        return Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        showAlert(
                            context, registerOk["title"], registerOk["msg"]);
                      }
                    } catch (e) {
                      print(e);
                      showAlert(context, 'Error', 'Unknown error');
                    }
                  },
          )
        ],
      ),
    );
  }
}
