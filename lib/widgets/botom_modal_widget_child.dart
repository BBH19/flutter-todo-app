import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class ModalBottomChildWidget extends StatelessWidget {
  const ModalBottomChildWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: GlobalParams.MainPadding,
          left: GlobalParams.MainPadding,
          bottom: GlobalParams.MainPadding / 2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        iconColor: GlobalParams.GlobalColor,
        leading: Icon(icon),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
