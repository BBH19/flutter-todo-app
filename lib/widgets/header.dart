import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget child;
  final Size size;
  Header({Key? key, required this.size, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      child: Stack(
        children: [
          Container(
              height: size.height * 0.15 - 27,
              width: double.infinity,
              padding: EdgeInsets.only(
                left: GlobalParams.MainPadding,
                right: GlobalParams.MainPadding,
              ),
              decoration: BoxDecoration(
                  color: GlobalParams.GlobalColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ))),
          Positioned(bottom: 0, left: 0, right: 0, child: child)
        ],
      ),
    );
  }
}
