import 'package:chat_app_flutter/widgets/btn_blue.dart';
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.widget.dart';
import 'package:chat_app_flutter/widgets/logo.widget.dart';
import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
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
              onPressed: () {
                print(nameCtrl.text);
                print(emailCtrl.text);
                print(passCtrl.text);
              })
        ],
      ),
    );
  }
}
