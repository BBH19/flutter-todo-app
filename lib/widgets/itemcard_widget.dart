// ignore_for_file: must_be_immutable
import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/views/cheque_edit.dart';
import 'package:chequeproject/views/cheque_list.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class ItemCard extends StatelessWidget {
  final Size size;
  VoidCallback? onPressed;
  Color? color;
  String? var1;
  String? var2;
  String? var3;
  String? var4;
  String? var5;
  Icon? icon;
  SwipeActionCell? swipeActionCell;
  Widget? indicator;
  Widget? additionalinfowidget;
  Color? textcolor;

  ItemCard({
    Key? key1,
    required this.size,
    this.color = GlobalParams.MainColor,
    this.var1,
    this.var2,
    this.var3,
    this.var4,
    this.var5,
    this.icon,
    this.onPressed,
    this.swipeActionCell,
    this.textcolor = GlobalParams.itemCardTextColor,
    this.indicator,
  }) : super(key: key1);

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    var currentItem = Cheques;
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
              child: SwipeActionCell(
                key: ObjectKey(key),
                backgroundColor: color,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: Alignment.topLeft,
                                  children: [
                                    icon ?? Icon(Icons.add),
                                  ],
                                ),
                              ]),

                          // WidgetSpan(child: icon),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              indicator ?? const Text(""),
                              Text(
                                var4 ?? "",
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: GlobalParams.itemCardFontSize,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: GlobalParams.MainfontFamily),
                              ),
                              Text(
                                var5 ?? "",
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
        ));
    //);
  }
}
