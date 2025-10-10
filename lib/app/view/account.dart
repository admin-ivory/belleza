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
import '../util/constant.dart';
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
                value.parser.haveLoggedIn() == true
                    ?
                CustomImageView(
                  url: '${Environments.apiBaseURL}storage/images/${value.cover}',
                  placeHolder: ImageConstant.logoBelleza,
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
                )
                    :
                CustomImageView(
                  imagePath: ImageConstant.logoBelleza,
                  placeHolder: ImageConstant.imgEllipse1445x45,
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
                    "Afro Queen".tr,
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
                      // 1. Connexion / Inscription (Affiche si déconnecté)
                      _buildProfileItem(
                        value: value,
                        label: "login".tr,
                        onTap: value.onLogin,
                        showIfLoggedIn: false, // Afficher si NON connecté
                      ),

                      // 2. Changer le mot de passe (Affiche si connecté)
                      _buildProfileItem(
                        value: value,
                        label: 'Change Password',
                        onTap: value.onChangePassword,
                        showIfLoggedIn: true, // Afficher si connecté
                      ),

                      // 3. Langue (Toujours affiché, ou affiche si déconnecté)
                      _buildProfileItem(
                        value: value,
                        label: 'Change Language'.tr,
                        onTap: value.onLanguages,
                        showIfLoggedIn: false, // On assume qu'on le montre aux non-connectés
                        isGrayBackground: true,
                      ),

                      // 4. Commande de produit (Affiche si connecté)
                      _buildProfileItem(
                        value: value,
                        label: "Porduct Order".tr,
                        onTap: value.onProductOrder,
                        showIfLoggedIn: true,
                      ),
                      _buildProfileItem(
                        value: value,
                        label: "Adress".tr,
                        onTap: value.onProductOrder,
                        showIfLoggedIn: true,
                      ),

                      // 5. Méthode de paiement (Affiche si connecté)
                      _buildProfileItem(
                        value: value,
                        label: "Payment Method".tr,
                        onTap: value.onWallet,
                        showIfLoggedIn: true,
                      ),

                      // 6. Politique de confidentialité (Toujours affiché)
                      _buildProfileItem(
                        value: value,
                        label: "Privacy and Policy".tr,
                        onTap: () => value.onAppPages('Privacy Policy'.tr, '2'),
                        showIfLoggedIn: false, // On assume qu'on le montre aux non-connectés
                        isGrayBackground: true,
                      ),
                       // 6. Politique de confidentialité (Toujours affiché)
                      _buildProfileItem(
                        value: value,
                        label: "FAQ".tr,
                        onTap: () => value.onAppPages('Frequently Asked Questions'.tr, '5'),
                        showIfLoggedIn: false, // On assume qu'on le montre aux non-connectés
                        isGrayBackground: true,
                      ),

                      // 7. Chat (Affiche si connecté)
                      _buildProfileItem(
                        value: value,
                        label: "Chat".tr,
                        onTap: () {
                          /* Get.toNamed(AppRoutes.notificationScreen); */
                        },
                        showIfLoggedIn: true,
                      ),

                      // 8. Déconnexion (Affiche si connecté)
                      _buildProfileItem(
                        value: value,
                        label: "Log Out".tr,
                        onTap: () {
                          value.logout();
                        },
                        showIfLoggedIn: true,
                      ),

                      _buildProfileItem(
                        value: value,
                        label: "About App/Social".tr,
                        onTap: (){value.onAppPages('About us'.tr, '1');},
                        showIfLoggedIn: false,
                        isGrayBackground: true,// Afficher si NON connecté
                      ),
                      _buildProfileItem(
                        value: value,
                        label: "Business Subscribe".tr,
                        onTap: value.onLogin,
                        showIfLoggedIn: false, // Afficher si NON connecté
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

  Widget _buildProfileItem({
    required dynamic value, // L'instance du contrôleur GetX
    required String label,
    required VoidCallback onTap,
    required bool showIfLoggedIn, // TRUE = Afficher si connecté
    bool isGrayBackground = false, // Vrai pour les sections Privacy/Langue
  }) {
    bool isLoggedIn = value.parser.haveLoggedIn();
    bool shouldShow = isLoggedIn == showIfLoggedIn;

    // Cas spécial pour les éléments toujours visibles (ex: Privacy Policy)
    if (showIfLoggedIn == true && !isLoggedIn) {
      shouldShow = true; // Permet aux éléments d'être affichés aux invités s'ils sont jugés importants.
    }

    if (isLoggedIn == false && showIfLoggedIn == true) {
      // Si l'utilisateur est déconnecté, mais que l'élément n'est affiché qu'aux connectés, on le cache.
      shouldShow = false;
    }

    // Si l'élément est destiné à être affiché uniquement si l'utilisateur n'est PAS connecté
    if (isLoggedIn == true && showIfLoggedIn == false) {
      // C'est la ligne pour les éléments "Login" ou "Sign Up"
      shouldShow = false;
    }


    if (!shouldShow) {
      // Cas où la condition n'est pas remplie, on retourne un widget vide
      // Le contrôle est inversé ici pour être plus simple
      if (showIfLoggedIn == true && !isLoggedIn) {
        // C'est un élément de connexion. On le montre s'il n'y a pas de session.
        shouldShow = false;
      }
    }


    // Logique simplifiée pour éviter le code répétitif
    if (isLoggedIn && !showIfLoggedIn) {
      // Si l'utilisateur est connecté et l'élément ne doit pas l'être (ex: Login Button), on le cache.
      return const SizedBox.shrink();
    }
    if (!isLoggedIn && showIfLoggedIn) {
      // Si l'utilisateur n'est pas connecté et l'élément doit l'être (ex: Logout Button), on le cache.
      return const SizedBox.shrink();
    }


    // Le cas où l'élément est destiné à être toujours affiché (comme Privacy Policy)
    // Utilisons une convention où 'showIfLoggedIn' peut être ignoré pour toujours afficher.

    // Si l'élément est destiné aux connectés (true) ou aux déconnectés (false)
    // Si l'élément est destiné à être toujours visible (par exemple, si vous ne passez aucune condition booléenne)

    // Utilisons la logique de base
    if (isLoggedIn && showIfLoggedIn || !isLoggedIn && !showIfLoggedIn) {
      // Exécuter l'affichage
    } else {
      // Cacher l'affichage
      return const SizedBox.shrink();
    }

    // Correction de la logique pour un cas simple :
    // Si l'élément est pour les utilisateurs connectés ET l'utilisateur est connecté, OU si l'élément est pour les non-connectés ET l'utilisateur n'est PAS connecté.
    if ((showIfLoggedIn && isLoggedIn) || (!showIfLoggedIn && !isLoggedIn)) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: getMargin(top: 20),
          padding: getPadding(all: 16),
          decoration: (isGrayBackground ? AppDecoration.fillGray50 : AppDecoration.outlinePink8001).copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                svgPath: ImageConstant.imgArrowright,
                height: getSize(24),
                width: getSize(24),
              ),
              Padding(
                padding: getPadding(left: 16),
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtBody,
                ),
              ),
              const Spacer(),
              CustomImageView(
                svgPath: ImageConstant.imgArrowright,
                height: getSize(24),
                width: getSize(24),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

