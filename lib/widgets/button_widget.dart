// ignore_for_file: deprecated_member_use

import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  Color? button_color;
  double? width;
  double? fontSize;
  ButtonWidget(
      {Key? key,
      required this.size,
      required this.onPressed,
      required this.text,
      this.button_color,
      this.width,
      this.fontSize = 16})
      : super(key: key);

  final Size size;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(widget.width ?? 240, 40),
            primary: widget.button_color ?? GlobalParams.GlobalColor),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
