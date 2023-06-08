import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationView extends StatefulWidget {
  static String Route = '/notification';
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();

    // Create a Socket.IO client instance
    socket = IO.io('http://127.0.0.1:5000/');

    // Connect to the Socket.IO server
    socket.connect();

    // Set up event listeners
    socket.on('message', (dataBack) {
      print("message $dataBack");
    });
  }

  @override
  void dispose() {
    // Close the Socket.IO connection
    socket.disconnect();

    super.dispose();
  }

  void emitEvent() {
    // Emit events to the server
    socket.emit('message', DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket.IO Page'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: emitEvent,
            child: Text('Emit Event'),
          ),
        ],
      )),
    );
  }
}
