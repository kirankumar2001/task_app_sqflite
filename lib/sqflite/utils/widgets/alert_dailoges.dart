import 'package:flutter/material.dart';
import 'package:revision/sqflite/utils/themes.dart';

class AlertDailoges extends StatelessWidget {
  final String? title;
  final String? note;
  final Function()? onPressyes;
  final Function()? onPresscancel;
  AlertDailoges(
      {super.key,
      required this.title,
      required this.note,
      this.onPressyes,
      this.onPresscancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        '$title',
        style: titleStyle,
      ),
      content: Text(
        '$note',
        style: title2,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressyes,
          child: Text(
            'YES',
            style: TextStyle(color: red),
          ),
        ),
        TextButton(
          onPressed: onPresscancel,
          child: Text('NO'),
        ),
      ],
    );
  }
}
