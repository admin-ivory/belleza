import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:user/app/controller/business_register_controller.dart';
import 'package:user/app/util/constant.dart';
import 'package:user/app/util/theme.dart';

import '../../backend/models/add_individual_model.dart';
import '../../backend/models/city_model.dart';


class FormBusiness extends GetWidget<BusinessSignUpController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   FormBusiness({super.key});

  // Fonction pour construire l'indicateur de progression
  Widget _buildTimelineIndicator(int step, int current) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: current >= step ? ThemeProvider.appColor : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<BusinessSignUpController>(
        builder: (value) {
          return Scaffold(
            body: Container( // Suppression du Padding inutile ici
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Obx(
                        () => Column(
                      children: [
                        const SizedBox(height: 30.0),

                        // Titre et Timeline (Toujours visibles)
                        const Text('Bienvenue chez vous!!', style: TextStyle(fontFamily: 'Segoe UI', fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff000000)), textAlign: TextAlign.left),
                        const SizedBox(height: 20.0),

                        // Indicateur de Timeline
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(value.totalSteps, (index) => _buildTimelineIndicator(index, value.currentStep.value)),
                        ),
                        const SizedBox(height: 30.0),

                        // --- ÉTAPE 1: NOM/PRÉNOM (Index 0) ---
                        if (value.currentStep.value == 0)
                          Column(
                            children: [
                              InputTextWidget(
                                  controller: value.name,
                                  labelText: "Business Name / Prénom",
                                  icon: Icons.business,
                                  isrequired: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  validator: (v) => v!.isEmpty ? 'Le nom du business est requis' : null),
                              const SizedBox(height: 25.0),
                            ],
                          ),

                        // --- ÉTAPE 2: CONTACTS (Index 1) ---
                        if (value.currentStep.value == 1)
                          Column(
                            children: [
                              InputTextWidget(
                                  isrequired: true,
                                  labelText: "Adresse Email Pro **",
                                  icon: Icons.ice_skating,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) => v!.isEmpty || !GetUtils.isEmail(v) ? 'Email invalide' : null),
                              const SizedBox(height: 12.0),
                             ],
                          ),

                        // --- ÉTAPE 3: CATÉGORIE / ZONE (Index 2) ---
                        if (value.currentStep.value == 2)
                          const Column(
                            children: [
                              InputTextWidget(
                                  isrequired: true,
                                  labelText: "Insta Pro",
                                  icon: Icons.ice_skating,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                 // validator: (v) => v!.isEmpty || !GetUtils.isEmail(v) ? 'Email invalide' : null),
                              ),
                              SizedBox(height: 12.0),
                            ],
                          ),

                        // --- ÉTAPE 4: MOT DE PASSE (Index 3) ---
                        if (value.currentStep.value == 3)
                         Column(
                           children: [
                             InputTextWidget(
                             controller: value.addressTextEditor,
                             labelText: "Salon ou Deplacement ",
                             icon: Icons.social_distance,
                             obscureText: false,
                             keyboardType: TextInputType.text,
                             isrequired: false,),
                             const SizedBox(height: 25.0),
                             InputTextWidget(
                               controller: value.zipcode,
                               labelText: "Zone",
                               icon: Icons.social_distance,
                               obscureText: false,
                               keyboardType: TextInputType.text,
                               isrequired: false,),]

                         ),

                        // --- Boutons de Navigation ---
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Bouton Retour
                              if (value.currentStep.value > 0)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: value.onBack,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      foregroundColor: Colors.black87,
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: Text('Retour'.tr, style: const TextStyle(fontSize: 17, fontFamily: 'bold')),
                                  ),
                                ),

                              if (value.currentStep.value > 0)
                                const SizedBox(width: 15),

                              // Bouton Suivant / Terminer
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validation de l'étape actuelle avant de passer à la suivante
                                    if (_formKey.currentState!.validate()) {
                                      if (value.currentStep.value == value.totalSteps - 1) {
                                        // Dernière étape: Soumission
                                        value.envoyerEmailDeConfirmation(
                                            nomUtilisateur: value.name.text,
                                            emailUtilisateur: value.emailText.text,
                                            instagram: value.businessNameTextEditor.text,
                                           // whatsapp: value.whatsappTextEditor.text,
                                            zoneZip: value.zipcode.text,
                                            businessName: value.name.text,
                                        );
                                      } else {
                                        // Prochaine étape
                                        value.onNext();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeProvider.appColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text(
                                    value.currentStep.value == value.totalSteps - 1 ? 'Terminer'.tr : 'Suivant'.tr,
                                    style: const TextStyle(fontSize: 17, fontFamily: 'bold'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Lien de connexion (Toujours visible)
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
                ),
              ),
            ),
          );
        }
    );
  }
}
// Correction: La fonction validator doit être passée en paramètre
typedef ValidatorCallback = String? Function(String?);


class InputTextWidget extends StatelessWidget {

  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValidatorCallback? validator;
  final bool isrequired; // Rendu final et utilisé pour la condition

  const InputTextWidget({
    super.key,
    required this.labelText,
    required this.icon,
    required this.obscureText,
    required this.keyboardType,
    this.controller,
    this.validator,
    this.isrequired = true, // Par défaut, un champ est requis
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Container(
        child: Material(
          elevation: 15.0,
          // CORRECTION ICI: Si requis, utilise Colors.pink, sinon Colors.black (pour une ombre subtile)
          shadowColor: isrequired ? Colors.pink : Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 15.0),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              autofocus: false,
              keyboardType: keyboardType,

              // Logique du validator pour la non-nullité
              validator: (val) {
                if (validator != null) {
                  return validator!(val);
                }
                if (isrequired && (val == null || val.isEmpty)) {
                  return 'Le champ de texte est vide !';
                }
                return null;
              },
              decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: Colors.black,
                  size: 32.0,
                ),
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black54, fontSize: 18.0),
                hintText: '',
                enabledBorder: InputBorder.none,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

