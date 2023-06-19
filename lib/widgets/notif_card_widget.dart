import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

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
