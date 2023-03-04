import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/datepicker_widget.dart';
import 'package:chequeproject/widgets/dropdown_widget.dart';
import 'package:chequeproject/widgets/file_picker_widget.dart';
import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  TextEditingController dateinput = TextEditingController();
  var dateRange = DateTime.now();

  int _index = 0;
  List<bool> hide = [false, true];

  StepperType stepperType = StepperType.horizontal;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox();
  }
}
