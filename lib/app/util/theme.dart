/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';

const typeTheme = Typography.whiteMountainView;

class ThemeProvider {
  static const appColor = Color.fromARGB(255, 211, 90, 0);
  static const secondaryAppColor = Color.fromARGB(255, 35, 74, 214);
  static const whiteColor = Colors.white;
  static const blackColor = Color(0xFF000000);
  static const greyColor = Colors.grey;
  static const backgroundColor = Color(0xFFF3F3F3);
  static const orangeColor = Color(0xFFFF9900);
  static const greenColor = Color(0xFF32CD32);
  static const redColor = Color(0xFFFF0000);
  static const transparent = Color.fromARGB(0, 0, 0, 0);
  static const titleStyle = TextStyle(fontFamily: 'bold', fontSize: 14, color: ThemeProvider.whiteColor);
}

TextTheme txtTheme = Typography.whiteMountainView.copyWith(
  bodyLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  bodyMedium: typeTheme.bodyLarge?.copyWith(fontSize: 14),
  displayLarge: typeTheme.bodyLarge?.copyWith(fontSize: 32),
  displayMedium: typeTheme.bodyLarge?.copyWith(fontSize: 28),
  displaySmall: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  headlineMedium: typeTheme.bodyLarge?.copyWith(fontSize: 21),
  headlineSmall: typeTheme.bodyLarge?.copyWith(fontSize: 18),
  titleLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  titleMedium: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  titleSmall: typeTheme.bodyLarge?.copyWith(fontSize: 21),
);

ThemeData light = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.appColor,
    secondaryHeaderColor: ThemeProvider.secondaryAppColor,
    disabledColor: const Color(0xFFBABFC4),
    brightness: Brightness.light,
    hintColor: const Color(0xFF9F9F9F),
    cardColor: ThemeProvider.appColor,
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: ThemeProvider.appColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.light(primary: ThemeProvider.appColor, secondary: ThemeProvider.secondaryAppColor).copyWith(surface: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)));

ThemeData dark = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.blackColor,
    secondaryHeaderColor: const Color(0xFF009f67),
    disabledColor: const Color(0xffa2a7ad),
    brightness: Brightness.dark,
    hintColor: const Color(0xFFbebebe),
    cardColor: Colors.black,
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: ThemeProvider.blackColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.dark(primary: ThemeProvider.blackColor, secondary: Color(0xFFffbd5c)).copyWith(surface: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)));
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
