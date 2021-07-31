import 'package:chat_app_flutter/global/environment.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  void connect() async {
    final token = await AuthService.getToken();

    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

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
