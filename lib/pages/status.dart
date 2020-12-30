import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class  StatusPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var socketService = Provider.of<SocketService>(context);
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Server Status: ${socketService.serverStatus}')
        ],
      ),
    );
  }
}