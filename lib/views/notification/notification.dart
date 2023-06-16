// import 'package:chequeproject/widgets/config.dart';
// import 'package:flutter/material.dart';

// class NotificationView extends StatelessWidget {
//   static String Route = '/notification';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         backgroundColor: GlobalParams.GlobalColor,
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 1'),
//             subtitle: Text('This is the content of notification 1.'),
//             // trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 2'),
//             subtitle: Text('This is the content of notification 2.'),
//             //trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 3'),
//             subtitle: Text('This is the content of notification 3.'),
//             //trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 4'),
//             subtitle: Text('This is the content of notification 4.'),
//             //trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 5'),
//             subtitle: Text('This is the content of notification 5.'),
//             //trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage('assets/logo1.png'),
//             ),
//             title: Text('Notification 6'),
//             subtitle: Text('This is the content of notification 6.'),
//             //trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               // Action to perform when notification is tapped
//             },
//           ),
//           // Add more ListTile widgets for additional notifications
//         ],
//       ),
//     );
//   }
// }

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Notification Page'),
// //         backgroundColor: GlobalParams.GlobalColor,
// //       ),
// //       // title: 'Notification Page',
// //       // theme: ThemeData(
// //       //   primarySwatch: GlobalParams.GlobalColor,
// //       // ),
// //       body: NotificationView(),
// //     );
// //   }
// // }

// import 'package:chequeproject/widgets/textfield_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class NotificationView extends StatefulWidget {
//   static String Route = '/notification';
//   @override
//   _NotificationViewState createState() => _NotificationViewState();
// }

// class _NotificationViewState extends State<NotificationView> {
//   late IO.Socket socket;

//   @override
//   void initState() {
//     super.initState();

//     // Create a Socket.IO client instance
//     socket = IO.io('http://127.0.0.1:5000/');

//     // Connect to the Socket.IO server
//     socket.connect();

//     // Set up event listeners
//     socket.on('message', (dataBack) {
//       print("message $dataBack");
//     });
//   }

//   @override
//   void dispose() {
//     // Close the Socket.IO connection
//     socket.disconnect();

//     super.dispose();
//   }

//   void emitEvent() {
//     // Emit events to the server
//     socket.emit('message', DateTime.now().toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Socket.IO Page'),
//       ),
//       body: Center(
//           child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: emitEvent,
//             child: Text('Emit Event'),
//           ),
//         ],
//       )),
//     );
//   }
// }

import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  static String Route = '/notification';

  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Notifications'),
          backgroundColor: GlobalParams.GlobalColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Nombre de notifications
                itemBuilder: (context, index) {
                  return NotificationCard(
                    title: 'Notification $index',
                    subtitle: 'Description de la notification $index',
                    time: 'Il y a 5 minutes', // Heure de la notification
                    isRead: index % 2 == 0
                        ? true
                        : false, // Marquer les notifications impaires comme lues
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isRead ? Colors.grey : GlobalParams.GlobalColor,
        child: const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
