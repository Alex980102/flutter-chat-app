import 'package:chat_app_flutter/models/user.model.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:chat_app_flutter/services/chat.service.dart';
import 'package:chat_app_flutter/services/socket_service.dart';
import 'package:chat_app_flutter/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final userService = new UserService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<dynamic> users = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.name,
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            // TODO: Disconnect to socket server
            onPressed: () {
              socketService.disconnect();
              AuthService.deleteToken();
              Navigator.restorablePushReplacementNamed(context, 'login');
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    )
                  : Icon(
                      Icons.offline_bolt,
                      color: Colors.red,
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUsers,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue.shade400,
          ),
          child: _listViewUsers(),
        ));
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userListTile(users[i]),
      separatorBuilder: (_, i) => Divider(
        color: Color.fromRGBO(255, 255, 255, 0),
        height: 2,
      ),
      itemCount: users.length,
    );
  }

  Card _userListTile(User user) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Text(user.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: user.online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userFor = user;
          Navigator.pushNamed(context, 'chat');
        },
      ),
    );
  }

  _loadUsers() async {
    this.users = await userService.getUsers();
    setState(() {});
    /* await Future.delayed(Duration(milliseconds: 1000)); */
    _refreshController.refreshCompleted();
  }
}
