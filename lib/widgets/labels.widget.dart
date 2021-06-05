import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String tile;
  final String subtitle;

  const Labels({
    Key? key,
    required this.ruta,
    required this.tile,
    required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            this.subtitle,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              this.tile,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            onDoubleTap: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
    );
  }
}
