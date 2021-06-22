import 'package:chat_app_flutter/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  void connect() {
    /* Dart Client */

    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true
    });
/*     _socket = IO.io('https://flutter-socket-server22.herokuapp.com/', {
      'transports': ['websocket'],
      'autoConnect': true
    }); */

    _socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /* _socket.on('nuevo-mensaje', (payload) {
      print('==== Nuevo Mensaje ====');
      print("Nombre: " + payload['nombre']);
      print("Edad: " + payload['edad'].toString());
    }); */
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
