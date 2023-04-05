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

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  var _popupMenuItemIndex = 0;

  var dateRange = DateTimeRange(
    start: DateTime.now(),
    //brikolage bricoma
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: widget.controller,

        onTap: () async {
          DateTimeRange? picked = await showDateRangePicker(
            context: context,
            initialDateRange: dateRange,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                // ignore: prefer_const_constructors
                colorScheme: ColorScheme.dark(
                  primary: Colors.blueGrey,
                  surface: Colors.white,
                  onSurface: GlobalParams.GlobalColor,
                ),
                dialogBackgroundColor: Colors.black,
              ),
              child: child!,
            ),
          );
          // Text(
          //     "${picked!.start.day}/${picked.start.month}/${picked.start.year}");
          widget.controller.text = picked!.start.toString();
          //"${picked!.start.day} - ${picked.start.month} - ${picked.start.year}";

          if (picked != null) {
            setState(() => {_popupMenuItemIndex = -1, dateRange = picked});
          }
        },
        enabled: widget.enabled ?? true,
        cursorColor: GlobalParams.GlobalColor,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        readOnly: widget.readonly ?? false,
        decoration: WidgetHelper.getDatePickerDecoration(
            widget.labeltext, widget.on_changed_function),
        style: const TextStyle(
            fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'Open Sans'),
        //controller: controller,
      ),
    );
  }
}
