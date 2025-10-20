/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:user/app/controller/register_controller.dart';
import 'package:user/app/util/theme.dart';
import 'package:get/get.dart';

import '../controller/business_register_controller.dart';
import '../helper/custom_appbar.dart';
import '../util/app_bar/appbar_subtitle_4.dart';
import '../util/app_style.dart';
import '../util/constant.dart';
import '../util/widget/custom_form.dart';
import '../util/widget/custom_image_view.dart';

class BusiRegisterScreen extends StatefulWidget {
  const BusiRegisterScreen({super.key});

  @override
  State<BusiRegisterScreen> createState() => _BusiRegisterScreenState();
}

class _BusiRegisterScreenState extends State<BusiRegisterScreen> {

  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessSignUpController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar:  CustomAppBar(
              height: getVerticalSize(75),
              leadingWidth: getVerticalSize(61),
              leading: CustomImageView(
                  imagePath: ImageConstant.logoBelleza,
                  height: getSize(45),
                  width: getSize(45),
                  margin: getMargin(left: 16, top: 30)),
              title: Padding(
                  padding: getPadding(left: 11, top: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppbarSubtitle4(text: "Belleza Pro".tr),

                      ])),
             ),
          body:  FormBusiness(),
        );
      },
    );
  }
}
