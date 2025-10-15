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
          appBar:
          CustomAppBar(
              height: getVerticalSize(75),
              leadingWidth: getVerticalSize(61),
              title: Padding(
                  padding: getPadding(left: 11, top: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppbarSubtitle4(text: "Thank You".tr),

                      ])),
              ),
          body:  FormBusiness(),

         /* SingleChildScrollView(

            reverse: true,
            child: Center(
              child: Column(
                children: [
                  Positioned(
                    right: -getSmallDiameter(context) / 3,
                    top: -getSmallDiameter(context) / 3,
                    child: Container(
                      width: getSmallDiameter(context),
                      height: getSmallDiameter(context),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                  ),
                  // Nom du Business (REQUIS)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: value.businessNameTextEditor,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (v) => v!.isEmpty ? 'Le nom du business est requis' : null, // Validation
                          decoration: InputDecoration(
                            labelText: 'Nom du Business (Requis)'.tr,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Prénom (OPTIONNEL)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: value.businessNameTextEditor,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                            validator: (v) => GetUtils.isUsername(v!)
                                ?
                            'Email Pro invalide' :
                            null,decoration: InputDecoration(
                            labelText: 'Prénom (Optionnel)'.tr,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- SÉLECTION DE CATÉGORIE (REQUIS) ---
                 /* Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: value.servedCategoriesList.isEmpty ? null : value.servedCategoriesList,
                      hint: Text('Catégorie de Business (Requis)'.tr),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                      items: value.categoryOptions.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category.tr),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          value.selectedCategory.value = newValue;
                        }
                      },
                      validator: (v) => v == null || v.isEmpty ? 'Veuillez choisir une catégorie' : null,
                    ),
                  ),*/

                  // --- ZONE GÉOGRAPHIQUE (REQUIS) ---
                /*  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: value.selectedZone.value.isEmpty ? null : value.selectedZone.value,
                      hint: Text('Zone Géographique (Requis)'.tr),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                      items: value.zoneOptions.map((String zone) {
                        return DropdownMenuItem<String>(
                          value: zone,
                          child: Text(zone.tr),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          value.selectedCity.value = newValue;
                        }
                      },
                      validator: (v) => v == null || v.isEmpty ? 'Veuillez choisir une zone' : null,
                    ),
                  ),*/

                  // Email Pro (REQUIS)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: value.emailTextEditor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v!.isEmpty || !GetUtils.isEmail(v) ? 'Email Pro invalide' : null,
                          decoration: InputDecoration(
                            labelText: 'Email Pro (Requis)'.tr,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Instagram Pro (OPTIONNEL)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: value.instagramTextEditor, // Supposons que vous avez un TextEditingController pour Instagram
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Compte Instagram Pro (Optionnel)'.tr,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mot de passe et Numéro de téléphone (existants)
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child:
                        CountryCodePicker(
                          onChanged: (e) => value.updateCountryCode(e.dialCode.toString()),
                          initialSelection: 'FR',
                          favorite: const ['+33', 'FR'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TextFormField(
                            controller: value.mobileTextEditor,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number'.tr,
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Bouton de soumission et navigation (existants)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    child: InkWell(
                      onTap: () {
                        // Assurez-vous d'utiliser une FormKey pour valider tous les champs requis
                        // if (_formKey.currentState!.validate()) { value.onRegister(); }
                        value.onRegister();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)), color: ThemeProvider.appColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Subscribe'.tr, style: const TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'bold'))],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You have already account ?'.tr, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 10),
                        InkWell(onTap: () => Get.back(), child: Text('Log in'.tr, style: const TextStyle(fontFamily: 'bold', fontSize: 14, color: ThemeProvider.appColor))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),*/
        );
      },
    );
  }
}
