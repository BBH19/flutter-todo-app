// ignore_for_file: unused_import, unnecessary_const, avoid_print, non_constant_identifier_names

import 'package:chequeproject/main.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:gmsoft_pkg/config/menu.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.buttonOption}) : super(key: key);
  final ButtonOption buttonOption;

  static GenerateMenu(List<ButtonOption> options) {
    return List.generate(options.length, (index) {
      var bOption = options[index];
      return HomeButton(buttonOption: bOption);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.4,
        height: size.height * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: GlobalParams.GlobalColor),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, buttonOption.route);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // ignore: unnecessary_new
                  Icon(
                    buttonOption.iconData,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      buttonOption.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
