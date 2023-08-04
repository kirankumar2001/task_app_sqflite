import 'package:flutter/material.dart';
import 'package:revision/sqflite/utils/themes.dart';

class InputText extends StatelessWidget {
  final String title;
  final bool? readOnly;
  final String hint;
  final TextEditingController? textcontroller;
  final Widget? widget;
  const InputText(
      {super.key,
      required this.title,
      required this.hint,
      this.textcontroller,
      this.readOnly,
      this.widget});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Container(
            height: 50,
            width: media.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Center(
                child: TextField(
              readOnly: readOnly!,
              controller: textcontroller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: widget,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: hint),
            )),
          )
        ],
      ),
    );
  }
}
