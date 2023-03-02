import 'package:chequeproject/widgets/homebutton_widget.dart';
import 'package:chequeproject/main.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  static List<ButtonOption> visibleOptions = [];

  DashboardItemView(
    List<ButtonOption> options, {
    Key? key,
  }) : super(key: key) {
    visibleOptions =
        options.where((element) => element.isVisible != false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const ScrollPhysics(),
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 4.1),
      children: List.generate(visibleOptions.length, (index) {
        var bOption = visibleOptions[index];
        return HomeButton(buttonOption: bOption);
      }),
    );
  }
}
