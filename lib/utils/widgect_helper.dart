

import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class WidgetHelper{

   static InputDecoration getDecoration(String label){
    return InputDecoration(
              contentPadding:  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              labelText: label,
              labelStyle:  TextStyle(fontSize: 20, color: GlobalParams.GlobalColor),
              border: OutlineInputBorder(                
              // borderSide: BorderSide(width: 3, color: GlobalParams.GlobalColor),
              borderRadius: BorderRadius.circular(10),
              ),
            );
  }

  static InputDecoration getDecorationColor(String label,void Function()? on_changed_function){
    return  InputDecoration(
            fillColor: Colors.red,
            focusColor: Colors.black,
            labelText: label,
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
              onPressed: on_changed_function,
              icon: const Icon(
                Icons.calendar_month,
                size: 20,
              ),
            )) ;
  }
              
}