import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldUnderlineWidget extends StatelessWidget {
  Color? focusColor;
  AutovalidateMode? valid;
  String? hint;
  var items;
  Widget? suffix;
  IconData icon;
  TextEditingController controller;

  TextFieldUnderlineWidget(
      {Key? key,
      required this.controller,
      required this.icon,
      this.suffix,
      this.valid,
      this.hint,
      this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: GlobalParams.GlobalColor,
      autovalidateMode: valid,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: GlobalParams.GlobalColor),
        prefixIcon: Icon(icon, color: GlobalParams.GlobalColor),
        hintText: hint,
        suffixIcon: suffix,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: GlobalParams.GlobalColor),
        ),
      ),
    );
  }
}
