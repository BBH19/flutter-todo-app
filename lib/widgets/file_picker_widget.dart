// ignore_for_file: prefer_final_fields, unused_import, unused_local_variable, must_be_immutable, non_constant_identifier_names, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TestPickerWidget extends StatefulWidget {
  Color? focusColor;
  String labeltext;
  String valuetext;
  bool? readonly;
  bool? enabled;
  TextInputType? keyboardType;
  TextEditingController controller;
  String? Function(String?)? validator;
  List? inputFormatters;
  late void Function()? on_changed_function;
  TestPickerWidget(
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
      this.enabled})
      : super(key: key);
  final Object obj;

  @override
  State<TestPickerWidget> createState() => _TestPickerWidgetState();
}

class _TestPickerWidgetState extends State<TestPickerWidget> { 

  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: widget.controller,
        onTap: () async {
          result = await FilePicker.platform.pickFiles(allowMultiple: true);
          if (result == null) {
            //print("No file selected");
          } else {
            setState(() {});
            result?.files.forEach((element) {
              //print(element.name);
              widget.controller.text = element.name;
            });
          }
        },
        enabled: widget.enabled ?? true,
        cursorColor: GlobalParams.GlobalColor,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        readOnly: widget.readonly ?? false,
        decoration: InputDecoration(
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
                Icons.file_upload,
                size: 20,
              ),
            )),
        style: const TextStyle(
            fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'Open Sans'),
      ),
    );
  }
}
