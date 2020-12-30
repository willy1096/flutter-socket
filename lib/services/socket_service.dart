import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;


  SocketService(){
    this._initConfig();
  }

  void _initConfig(){

    this._socket = IO.io('http://localhost:3000/', <String, dynamic>{
      'timeout': 1000,
      'reconnectDelay': 3000,
      'transports': ['websocket'],
      'upgrade': false,
      'autoConnect': true,
    });

   

    this._socket.onConnect((_){
       print('connect');
       this._serverStatus = ServerStatus.Online;
       notifyListeners();
    });
    
    socket.onConnectError((data) {
      print("socket connect exception :$data");
    });

    socket.onConnectTimeout((data) {
      print("onConnectTimeout: $data");
    });
    socket.onReconnectError((data) {
      print("onReconnectError: $data");
    });
    
    this._socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });


    
   
  } 

}