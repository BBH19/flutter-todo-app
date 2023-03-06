// ignore_for_file: unused_field, prefer_final_fields

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
    return const SizedBox();
  }
}
