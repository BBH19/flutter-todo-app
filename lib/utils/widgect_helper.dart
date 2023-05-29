// ignore_for_file: non_constant_identifier_names

import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WidgetHelper {
  static InputDecoration getDecoration(String label) {
    return InputDecoration(
      errorStyle: const TextStyle(fontSize: 0.01),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      labelText: label,
      labelStyle: TextStyle(fontSize: 18, color: GlobalParams.GlobalColor),
      border: OutlineInputBorder(
        // borderSide: BorderSide(width: 3, color: GlobalParams.GlobalColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static InputDecoration getDatePickerDecoration(
      String label, void Function()? on_changed_function) {
    return InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.01),
        fillColor: Colors.red,
        focusColor: Colors.black,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: GlobalParams.GlobalColor),
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
          onPressed: on_changed_function,
          icon: const Icon(
            Icons.date_range,
            size: 20,
          ),
        ));
  }

  static InputDecoration getDecorationColor(
      String label, void Function()? on_changed_function) {
    return InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.01),
        fillColor: Colors.red,
        focusColor: Colors.black,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: GlobalParams.GlobalColor),
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
          onPressed: on_changed_function,
          icon: const Icon(
            Icons.calendar_month,
            size: 20,
          ),
        ));
  }

  static LoadingWidget(Size size) {
    return SizedBox(
      height: size.height * 0.5,
      child: Center(
        child: Lottie.asset('assets/loader.json'),
      ),
    );
  }
}
