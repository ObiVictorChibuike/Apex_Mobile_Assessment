
import 'package:flutter/material.dart';
import 'color_palette.dart';

class AppTheme{
  static const MaterialColor materialColor = MaterialColor(
      0xff000103,
      <int, Color>{
        50: Color(0xff000410),
        100: Color(0xff00030E),
        200: Color(0xff00030C),
        300: Color(0xff00020B),
        400: Color(0xff000209),
        500: Color(0xff000208),
        600: Color(0xff000106),
        700: Color(0xff000105),
        800: Color(0xff000103),
      }
  );
  static ThemeData applicationTheme(){
    return ThemeData(
      primarySwatch: materialColor,
      fontFamily: "KumbhSans",
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff6DE7B4),
      ),
      errorColor: Colors.red,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: kWhite,
          selectionColor: kWhite,
          selectionHandleColor: kWhite
      ),
    );
  }

  phoneNumberFieldInputDecoration({required BuildContext context}){
    return InputDecoration(
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: "Phone Number",
      hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff868484), fontSize: 16),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.7)
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.7)
      ),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.7)
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.7)
      ),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.7)
      ),
      fillColor: kDarkBackGroundColor,
      filled: true, isDense: true,
      contentPadding: const EdgeInsets.all(15),
    );
  }
}