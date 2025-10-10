import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color black9007f = fromHex('#7f000000');

  static Color red700 = fromHex('#D93636');

  static Color red600 = fromHex('#E14545');

  static Color green600 = fromHex('#49ac26');

  static Color gray50 = fromHex('#fafafa');

  static Color green500 = fromHex('#3aad64');

  static Color red100 = fromHex('#feccd5');

  static Color black90021 = fromHex('#21000000');

  static Color black90066 = fromHex('#66000000');

  static Color pink8006c = fromHex('#6ca81650');

  static Color yellow500 = fromHex('#f7e632');

  static Color black900 = fromHex('#000000');

  static Color yellow800 = fromHex('#f7a521');

  static Color deepOrange700 = fromHex('#ef3a10');

  static Color gray6006c = fromHex('#6c808080');

  static Color pink800 = fromHex('#a81650');

  static Color gray9000f = fromHex('#0f202020');

  static Color gray600 = fromHex('#808080');

  static Color pink50 = fromHex('#f6e8ee');

  static Color red60001 = fromHex('#f22d42');

  static Color lime600 = fromHex('#a5d631');

  static Color blueGray400 = fromHex('#888888');

  static Color black9000f = fromHex('#0f000000');

  static Color black9000c = fromHex('#0c000000');

  static Color gray300 = fromHex('#e6e6e6');

  static Color gray60028 = fromHex('#28787880');

  static Color gray100 = fromHex('#f5f5f5');

  static Color green60002 = fromHex('#4aa54a');

  static Color green60001 = fromHex('#28a757');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray8004c = fromHex('#4c3c3c43');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
