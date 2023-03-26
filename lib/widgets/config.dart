// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, prefer_const_constructors, constant_identifier_names
import 'package:flutter/material.dart';

class GlobalParams {
// api
  static var baseUrl = '';
  static final laravelApi = "http://192.168.1.113:5000/";
// for screens
  static const MainColor = Colors.blue;
  static Color GlobalColor = const Color(0xff7FA7BB);
  static final SecondaryColor = Color(0xFF3E30BC);
  static const lightColor = Color.fromARGB(255, 122, 194, 253);
  static final backgroundColor = Colors.white;
  static final double MainPadding = 20;

  // inventory details card header gradient colors
  static final List<Color> inventoryDetailsCardHeaderGradientColors = [
    Colors.blue,
    Colors.blue,
  ];

  static final String key_domain = "domainame";
  static final String key_domains = "domainames";
  static String key_token = "token";
  static const itemCardTextColor = Colors.white;

  // font sizes
  static const double MainfontSize = 15;
  static const MainfontFamily = "Open Sans";
  static const double itemCardFontSize = 12;
  static const double complexeItemCardFontSize = 12;

  // this value is multiplied by the height of the screen
  static const double itemCardSize = 0.1;
  static const double complexeItemCardSize = 0.11;

  static double getItemCardHeight(Size size) {
    return size.height * GlobalParams.itemCardSize;
  }

  static double getComplexeItemCardHeight(Size size) {
    return size.height * GlobalParams.complexeItemCardSize;
  }

  static Color ItemCardMainColor = Colors.deepOrange.withOpacity(0.8);
  static Color ItemCardSecondaryColor = Color(0xff1C85EE);

  static String devise = "DH";
  static int fractionDigits = 2;
}
