// ignore_for_file: non_constant_identifier_names

import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/stepper_widget.dart';
import 'package:flutter/material.dart';

class AddChequeView extends StatefulWidget {
  static String Route = '/add';
  const AddChequeView({super.key});
  @override
  State<AddChequeView> createState() => _AddChequeViewState();
}

class _AddChequeViewState extends State<AddChequeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalParams.backgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: GlobalParams.GlobalColor,
          elevation: 0,
          title: const Text(
            "Nouveau Cheque  ",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 19,
                fontFamily: 'Open Sans'),
          )),
      body: StepperWidget(),
    );
  }
}
