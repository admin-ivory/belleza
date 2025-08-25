/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Belleza

*/
import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:user/app/controller/splash_controller.dart';
import 'package:user/app/env.dart';
import 'package:user/app/helper/router.dart';
import 'package:user/app/util/theme.dart';
import 'package:user/app/util/toast.dart';
import 'package:user/app/view/intro.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
    initConnectivity();
    Get.find<SplashController>().initSharedData();
    _routing();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _routing() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        if (Get.find<SplashController>().getLanguageCode() != '') {
          var locale = Get.find<SplashController>().getLanguageCode();
          Get.updateLocale(Locale(locale));
        } else {
          var locale = Get.find<SplashController>().defaultLanguage.languageCode != '' && Get.find<SplashController>().defaultLanguage.languageCode != ''
              ? Locale(Get.find<SplashController>().defaultLanguage.languageCode.toString())
              : Locale('en'.tr);
          Get.updateLocale(locale);
        }

        if (Get.find<SplashController>().parser.isNewUser() == false) {
          Get.find<SplashController>().parser.saveWelcome(true);
          Get.offNamed(AppRouter.getInitialRoute());
        } else {
          Get.find<SplashController>().parser.saveWelcome(true);
          Get.offNamed(AppRouter.getChooseLocationRoutes());
        }
      } else {
        Get.toNamed(AppRouter.getErrorRoutes());
      }
    });
  }

  Future<void> initConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi));
    if (!hasInternet) {
      showToast('No Internet Connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (value) {
        return Scaffold(
          body: Stack(alignment: AlignmentDirectional.center, children: [
            const Image(image: AssetImage('assets/images/logo_afro.png'), fit: BoxFit.cover, height: double.infinity, width: double.infinity, alignment: Alignment.center),
           // const Positioned(top: 100, child: Image(image: AssetImage('assets/images/logo_white.png'), fit: BoxFit.cover, height: 50, width: 50, alignment: Alignment.center)),
             Positioned(child: const Text(Environments.appName, style: TextStyle(fontSize: 100, color: ThemeProvider.blackColor , fontFamily: 'bold')).animate().fade(duration: GetNumUtils(500).milliseconds).scale(duration: GetNumUtils(500).milliseconds)
             ),
            const Positioned(bottom: 50, child: Center(child: CircularProgressIndicator(color: ThemeProvider.blackColor))),
            Positioned(bottom: 20, child: Center(child: Text('Developed By '.tr + Environments.companyName, style: const TextStyle(color: ThemeProvider.blackColor, fontFamily: 'bold')))),
          ]),
        );

      },
    );
  }
}
