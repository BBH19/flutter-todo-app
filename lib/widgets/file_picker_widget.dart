// ignore_for_file: prefer_final_fields, unused_import, unused_local_variable, must_be_immutable, non_constant_identifier_names, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TextPickerWidget extends StatefulWidget {
  Color? focusColor;
  String labeltext;
  String valuetext;
  bool? readonly;
  bool? enabled;
  int? maxLines;
  double? height;
  TextInputType? keyboardType;
  TextEditingController controller;
  String? Function(String?)? validator;
  List? inputFormatters;
  late void Function()? on_changed_function;
  TextPickerWidget(
      {Key? key,
      required this.obj,
      required this.labeltext,
      required this.controller,
      required this.valuetext,
      this.readonly = false,
      this.focusColor = Colors.black,
      this.validator,
      this.keyboardType,
      this.inputFormatters,
      this.on_changed_function,
      this.maxLines,
      this.height = 35,
      this.enabled})
      : super(key: key);
  final Object obj;

  @override
  State<TextPickerWidget> createState() => _TestPickerWidgetState();
}

class _TestPickerWidgetState extends State<TextPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        onTap: widget.on_changed_function,
        enabled: widget.enabled ?? true,
        cursorColor: GlobalParams.GlobalColor,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        readOnly: widget.readonly ?? false,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0.01),
            fillColor: Colors.red,
            focusColor: Colors.black,
            labelText: widget.labeltext,
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
            suffixIcon: IconButton(
              onPressed: widget.on_changed_function,
              icon: const Icon(
                Icons.drag_indicator,
                size: 20,
              ),
            )),
        style: const TextStyle(
            fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'Open Sans'),
      ),
    );
  }
}
