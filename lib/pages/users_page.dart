import 'package:chat_app_flutter/models/user.model.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final users = [
    User(
        email: 'alex.9802@hotmail.com',
        name: 'Alejandro',
        uid: '1',
        online: true),
    User(
        email: 'alex2.9802@hotmail.com',
        name: 'Alejandro2',
        uid: '2',
        online: false),
    User(
        email: 'alex3.9802@hotmail.com',
        name: 'Alejandro3',
        uid: '3',
        online: true)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TODO: Insert name of the user
          title: Text(
            'My name',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => ListTile(
            title: Text(users[i].name),
            leading: CircleAvatar(
              child: Text(users[i].name.substring(0, 2)),
            ),
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: users[i].online ? Colors.green[300] : Colors.red,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          separatorBuilder: (_, i) => Divider(),
          itemCount: users.length,
        ));
  }
}
