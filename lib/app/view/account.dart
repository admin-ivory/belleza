/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/app/controller/account_controller.dart';
import 'package:user/app/util/theme.dart';
import 'package:user/app/env.dart';

import '../helper/custom_appbar.dart';
import '../util/app_bar/appbar_subtitle_4.dart';
import '../util/app_decoration.dart';
import '../util/app_style.dart';
import '../util/widget/custom_icon_button.dart';
import '../util/widget/custom_image_view.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (value) {
        return
         /* Scaffold(
          backgroundColor: Colors.white,
          appBar: value.parser.haveLoggedIn() == true
              ?  CustomAppBar(
              height: getVerticalSize(75),
              leadingWidth: getVerticalSize(61),
              leading: CustomImageView(
                  imagePath: ImageConstant.imgEllipse1445x45,
                  height: getSize(45),
                  width: getSize(45),
                  margin: getMargin(left: 16, top: 30)),
              title: Padding(
                  padding: getPadding(left: 11, top: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppbarSubtitle4(text: "lbl_welcome".tr),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('${value.firstName} ${value.lastName}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextBold22))
                      ])),
            )
         /* AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ThemeProvider.appColor,
                  elevation: 3,
                  toolbarHeight: 180,
                  iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
                  titleSpacing: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FadeInImage(
                                  height: 80,
                                  width: 80,
                                  image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.cover}'),
                                  placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/images/notfound.png', fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('${value.firstName} ${value.lastName}', style: const TextStyle(fontFamily: 'bold', fontSize: 14, color: ThemeProvider.whiteColor)),
                            Text(value.email, style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 10, fontFamily: 'regular')),
                          ],
                        ),
                      ),
                    ],
                  ),
                )*/
              : AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ThemeProvider.appColor,
                  title: Text('Acount'.tr, style: ThemeProvider.titleStyle),
                ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ThemeProvider.whiteColor, boxShadow: const [BoxShadow(color: ThemeProvider.transparent, blurRadius: 5.0)]),
                    child: Column(
                      children: [

                        value.parser.haveLoggedIn() == true ?
                        Container(
                          margin: getMargin(
                            top: 24,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "lbl_profile".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox(),
                        /*InkWell(onTap: () => value.onEdit(), child: _buildList(Icons.account_circle_outlined, 'Edit Profile'.tr)) : const SizedBox(),*/
                        value.parser.haveLoggedIn() == false ? InkWell(onTap: () => value.onLogin(), child: _buildList(Icons.lock_clock_outlined, 'Sign In / Sign Up'.tr)) : const SizedBox(),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onEdit(), child: _buildList(Icons.account_circle_outlined, 'Edit Profile'.tr)) : const SizedBox(),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onProductOrder(), child: _buildList(Icons.add_shopping_cart, 'Product Order'.tr)) : const SizedBox(),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onAddress(), child: _buildList(Icons.location_on_outlined, 'Your Address'.tr)) : const SizedBox(),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onWallet(), child: _buildList(Icons.account_balance_wallet_outlined, 'Wallet'.tr)) : const SizedBox(),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onReferAndEarn(), child: _buildList(Icons.savings_outlined, 'Refer & Earn'.tr)) : const SizedBox(),
                        InkWell(onTap: () => value.onChangePassword(), child: _buildList(Icons.code_rounded, 'Change Password'.tr)),
                        InkWell(onTap: () => value.onLanguages(), child: _buildList(Icons.language_outlined, 'Languages'.tr)),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.onAccountChat(), child: _buildList(Icons.message_outlined, 'Chats'.tr)) : const SizedBox(),
                        InkWell(onTap: () => value.onContactUs(), child: _buildList(Icons.contact_page_outlined, 'Contact Us'.tr)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ThemeProvider.whiteColor, boxShadow: const [BoxShadow(color: ThemeProvider.greyColor, blurRadius: 5.0)]),
                    child: Column(
                      children: [
                        InkWell(onTap: () => value.onAppPages('Frequently Asked Questions'.tr, '5'), child: _buildList(Icons.flag_outlined, 'Frequently Asked Questions'.tr)),
                        InkWell(onTap: () => value.onAppPages('Help'.tr, '6'), child: _buildList(Icons.help_outline, 'Help'.tr)),
                        InkWell(onTap: () => value.onAppPages('Privacy Policy'.tr, '2'), child: _buildList(Icons.security_outlined, 'Privacy Policy'.tr)),
                        InkWell(onTap: () => value.onAppPages('Terms & Conditions'.tr, '3'), child: _buildList(Icons.privacy_tip_outlined, 'Terms & Conditions'.tr)),
                        InkWell(onTap: () => value.onAppPages('About us'.tr, '1'), child: _buildList(Icons.info_outline, 'About'.tr)),
                        value.parser.haveLoggedIn() == true ? InkWell(onTap: () => value.logout(), child: _buildList(Icons.logout, 'Logout'.tr)) : const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );*/
        SafeArea(
          child: Padding(
            padding: getPadding(top: 40, right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse1445x45,
                  height: getSize(
                    100,
                  ),
                  width: getSize(
                    100,
                  ),
                  radius: BorderRadius.circular(
                    getHorizontalSize(
                      50,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 16,
                  ),
                  child: Text(
                    "${value.firstName} ${value.lastName}".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold28,
                  ),
                ),
                Expanded(
                  child: ListView(
                    primary: true,
                    shrinkWrap: false,
                    children: [
                      GestureDetector(
                        onTap: () {
                         value.onLogin();
                        },
                        child:
                        Container(
                          margin: getMargin(
                            top: 24,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "lbl_login".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          value.onChangePassword();
                        },
                        child:
                        Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  'Change Password',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //language
                      GestureDetector(
                        onTap: () {
                          value.onWallet();
                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  'Our Package',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //chat
                      GestureDetector(
                        onTap: () {
                          value.onProductOrder();
                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "Porduct Order".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                       //   Get.toNamed(AppRoutes.paymentOneScreen);
                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "lbl_payment_method".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                        //  Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "msg_privacy_and_policy".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //Get.toNamed(AppRoutes.notificationScreen);
                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "lbl_assistance".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          margin: getMargin(
                            top: 20,
                          ),
                          padding: getPadding(
                            all: 16,
                          ),
                          decoration: AppDecoration.fillGray50.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 16,
                                ),
                                child: Text(
                                  "lbl_log_out".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtBody,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(icn, txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: ThemeProvider.appColor, child: Icon(icn, color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('$txt', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontFamily: 'bold'))),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageConstant {
  static String imgEllipse1445x45 = 'assets/images/img_ellipse14_45x45.png';
  static String imgArrowright = 'assets/images/img_arrowright.svg';
}
