import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  final String title;
  const logo({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/logo.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
