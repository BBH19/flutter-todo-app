// ignore_for_file: prefer_final_fields, unused_import

import 'package:chequeproject/utils/widgect_helper.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
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
  DatePickerWidget(
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
  TextEditingController datePickerCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: datePickerCtrl,
        onTap: () async {
          DateTime date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());
          date = (await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100)))!;
          datePickerCtrl.text = date.toString();
        },
        enabled: enabled ?? true,
        cursorColor: GlobalParams.GlobalColor,
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readonly ?? false,
        decoration: WidgetHelper.getDatePickerDecoration(
            labeltext, on_changed_function),
        style: const TextStyle(
            fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'Open Sans'),
        //controller: controller,
      ),
    );
  }
}
