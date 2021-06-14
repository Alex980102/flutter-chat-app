import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isIOS || Platform.isMacOS) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: <Widget>[
              MaterialButton(
                child: Text('Ok'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => Navigator.pop(context),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ));
}
