// ignore_for_file: non_constant_identifier_names

import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class ErrorWithRefreshButtonWidget extends StatelessWidget {
  const ErrorWithRefreshButtonWidget({
    Key? key,
    required this.button_function,
    this.message,
  }) : super(key: key);

  final VoidCallback button_function;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(GlobalParams.MainPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              softWrap: true,
              "An error occurred Please Try Again ",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(message??""),
            FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: button_function,
                child: const Icon(Icons.refresh))
          ],
        ),
      ),
    );
  }
}
