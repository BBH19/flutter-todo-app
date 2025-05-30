// ignore_for_file: non_constant_identifier_names

import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  Color? focusColor;
  String labeltext;
  String valuetext;
  bool? readonly;
  bool? enabled;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  List? inputFormatters;
  late void Function()? on_changed_function;
  TextEditingController controller;
  TextFieldWidget(
      {Key? key,
      required this.obj,
      required this.labeltext,
      required this.valuetext,
      this.readonly = false,
      this.focusColor = Colors.black,
      required this.controller,
      this.validator,
      this.keyboardType,
      this.inputFormatters,
      this.on_changed_function,
      this.enabled})
      : super(key: key);

  final Object obj;

// love you so much , bzzzf bzzf // love u more babe :*
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: TextFormField(
          enabled: enabled ?? true,
          cursorColor: GlobalParams.GlobalColor,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readonly ?? false,
          controller: controller,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            fillColor: Colors.red,
            focusColor: Colors.black,
            labelText: labeltext,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.5, color: GlobalParams.GlobalColor),
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                fontFamily: 'Open Sans',
                color: GlobalParams.GlobalColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          minLines: 1,
        ));
  }
}
