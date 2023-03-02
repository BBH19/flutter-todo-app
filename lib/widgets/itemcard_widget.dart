// ignore_for_file: must_be_immutable
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Size size;
  VoidCallback? onPressed;
  Color? color;
  String? var1;
  String? var2;
  String? var3;
  String? var4;
  String? var5;
  Widget? indicator;
  Widget? additionalinfowidget;
  Color? textcolor;

  ItemCard({
    Key? key,
    required this.size,
    this.color = GlobalParams.MainColor,
    this.var1,
    this.var2,
    this.var3,
    this.var4,
    this.var5,
    this.onPressed,
    this.textcolor = GlobalParams.itemCardTextColor,
    this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: var1 ?? "",
      child: InkWell(
        onDoubleTap: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: GlobalParams.getItemCardHeight(size),
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey[300],
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          var1 ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: textcolor,
                              fontSize: GlobalParams.itemCardFontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: GlobalParams.MainfontFamily),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        var2 ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: textcolor,
                            fontSize: GlobalParams.itemCardFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: GlobalParams.MainfontFamily),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        var3 ?? "",
                        style: TextStyle(
                            color: textcolor,
                            fontSize: GlobalParams.itemCardFontSize,
                            fontWeight: FontWeight.w300,
                            fontFamily: GlobalParams.MainfontFamily),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          indicator ?? const Text(""),
                          Text(
                            var4 ?? "",
                            // 'Pr : ${inventoryDetails.singlePrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: textcolor,
                                fontSize: GlobalParams.itemCardFontSize,
                                fontWeight: FontWeight.w300,
                                fontFamily: GlobalParams.MainfontFamily),
                          ),
                          Text(
                            var5 ?? "",
                            //'Qty:${inventoryDetails.qty.toStringAsFixed(3)}',
                            style: TextStyle(
                                color: textcolor,
                                fontSize: GlobalParams.itemCardFontSize,
                                fontWeight: FontWeight.w300,
                                fontFamily: GlobalParams.MainfontFamily),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
