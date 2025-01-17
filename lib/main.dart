/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/app/controller/product_cart_controller.dart';
import 'package:user/app/controller/service_cart_controller.dart';
import 'package:user/app/helper/init.dart';
import 'package:get/get.dart';
import 'package:user/app/helper/router.dart';
import 'package:user/app/util/constant.dart';
import 'package:user/app/util/theme.dart';
import 'package:user/app/util/translator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: ThemeProvider.appColor));

  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await _initializeFirebase();
  }

  await MainBinding().dependencies();
  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
  } catch (e) {
    if (e is FirebaseException && e.code == 'duplicate-app') {
      // Firebase a déjà été initialisé, ignorer cette erreur
    } else {
      rethrow; // Si l'erreur n'est pas un doublon, la relancer
    }
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ServiceCartController>().getCart();
    Get.find<ProductCartController>().getCart();
    return GetMaterialApp(
      title: AppConstants.appName,
      color: ThemeProvider.appColor,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      initialRoute: AppRouter.splash,
      getPages: AppRouter.routes,
      defaultTransition: Transition.native,
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
    );
  }
}
