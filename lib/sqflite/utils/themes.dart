import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const darks = Color.fromARGB(255, 24, 24, 24);
const darkbg = Color.fromARGB(255, 37, 37, 37);
const primary = Colors.deepPurple;
const primarybg = Colors.white;
const pinkclr = Colors.pink;
const grrenclr = Colors.green;
const red = Colors.red;
const blue = Colors.indigo;
const yellowclr = Colors.orangeAccent;

class Themes {
  static final light = ThemeData(
      backgroundColor: primarybg,
      primaryColor: primary,
      brightness: Brightness.light);
  static final dark = ThemeData(
    backgroundColor: darkbg,
    primaryColor: darks,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      // textStyle: TextStyle(),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey);
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    // textStyle: TextStyle(),
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    // textStyle: TextStyle(),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get headingStyle2 {
  return GoogleFonts.lato(
    // textStyle: TextStyle(),
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get title2 {
  return GoogleFonts.lato(
    // textStyle: TextStyle(),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}
