import 'package:flutter/material.dart';
import 'package:revision/sqflite/utils/themes.dart';

class Elevated extends StatelessWidget {
  final String label;
  final Function()? onTap;
  Elevated({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(color: primarybg),
          ),
          style:
              ButtonStyle(backgroundColor: MaterialStatePropertyAll(primary)),
        ));
  }
}
