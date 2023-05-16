import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
class DetailsCard extends StatelessWidget {
  String? key_;
  String? value;
  Widget? child;
  Widget? rightchild;
  double? minwidth;
  Icon? icon_key;
  Icon? icon_value;
  // ignore: use_key_in_widget_constructors
  DetailsCard(
      {this.key_,
      this.value,
      this.child,
      this.rightchild,
      this.minwidth,
      this.icon_key,
      this.icon_value}): assert(
          ((icon_key != null || key_ != null) && (icon_value != null || value != null || child != null)),
          'One of the parameters must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      minLeadingWidth: minwidth ?? 110,
      leading: (key_ ==null ? icon_key :  Text(key_!,
          style: const TextStyle(
              fontFamily: GlobalParams.MainfontFamily,
              fontWeight: FontWeight.w800))),
      title: (value ==null ? (Container(
                        alignment: Alignment.centerLeft,
                        child: icon_value))
                       : Text(
        value!,
        style: const TextStyle(
            fontFamily: GlobalParams.MainfontFamily,
            fontWeight: FontWeight.w400))
      ),
      subtitle: child,
      trailing: rightchild,
    ));
  }
}
