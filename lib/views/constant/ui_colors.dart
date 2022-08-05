import 'dart:ui';
import 'package:flutter/material.dart';

class UIColors {
  UIColors._();
  static final Color errorMessage = HexColor.fromHex("#F23E3E");
  static final Color inputBackground = HexColor.fromHex("#F3F4F6");
  static final Color labele = HexColor.fromHex("#F2F2FF");
  static final Color borderError = HexColor.fromHex("#F23E3E").withOpacity(0.8);
  static const white = Colors.white;
  static const Color black = Colors.black;
  static final Color colorButton = HexColor.fromHex('#224190');
  static final Color colorBackground = HexColor.fromHex('#696969');
  static final Color defaultColorButton = HexColor.fromHex('#93b2ff');
  static final Color divided = HexColor.fromHex("#FFFFFF");
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}