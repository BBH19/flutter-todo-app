import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Size size;
  final void Function(String)? onchanged_function;
  String? value;

  SearchField(
      {Key? key, required this.size, this.onchanged_function, this.value})
      : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController controller;
  late void Function(String)? onchanged_function;
  bool showDeletIcon = false;
  @override
  void initState() {
    showDeletIcon = widget.value != null;
    controller = TextEditingController();
    controller.text = widget.value ?? "";
    onchanged_function = widget.onchanged_function;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.size.height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: GlobalParams.MainPadding),
      padding: EdgeInsets.symmetric(horizontal: GlobalParams.MainPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: TextField(
        onChanged: (String value) {
          if (value.isEmpty) {
            setState(() {
              showDeletIcon = false;
            });
          } else {
            setState(() {
              showDeletIcon = true;
            });
          }
          onchanged_function?.call(value);
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: "Rechercher",
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: showDeletIcon
              ? IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    onchanged_function?.call("");
                    setState(() {
                      showDeletIcon = false;
                      controller.text = "";
                    });
                  },
                )
              : Text(""),
        ),
      ),
    );
  }
}
