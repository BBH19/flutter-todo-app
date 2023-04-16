// ignore_for_file: prefer_final_fields, unused_import, must_be_immutable, non_constant_identifier_names

import 'package:chequeproject/utils/widgect_helper.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatefulWidget {
  Color? focusColor;
  String labeltext;
  String valuetext;
  bool? readonly;
  bool? enabled;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  List? inputFormatters;
  final Function(DateTime)? onChanged;
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
      this.onChanged,
      this.enabled})
      : super(key: key);
  final Object obj;

  void Function()? get on_changed_function => null;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  var _popupMenuItemIndex = 0;

  var selectedDate = DateTime.now();

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: widget.controller,
        onTap: () async {
          final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              selectedDate = picked;
              widget.controller.text = formatter.format(selectedDate);
            });
            if (widget.onChanged != null) {
              widget.onChanged!(selectedDate);
            }
          }
        },
        enabled: widget.enabled ?? true,
        cursorColor: GlobalParams.GlobalColor,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        readOnly: widget.readonly ?? false,
        decoration: WidgetHelper.getDatePickerDecoration(
          widget.labeltext,
          widget.on_changed_function,
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          fontFamily: 'Open Sans',
        ),
      ),
    );
  }
}
