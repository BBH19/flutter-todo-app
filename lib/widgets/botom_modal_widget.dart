import 'package:flutter/material.dart';

showCustomizedModalBottom(BuildContext context, Widget children, Size? size) {
  return showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 20,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Container(
          height:
              size != null ? size.height : MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(58, 183, 183, 183),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              children,
            ],
          ),
        );
      });
}
