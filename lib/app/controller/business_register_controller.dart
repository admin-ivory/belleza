/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/app/backend/parse/business_register_parse.dart';
import 'package:user/app/controller/register_categories_controller.dart';

import '../backend/api/handler.dart';
import '../backend/models/add_individual_model.dart';
import '../backend/models/city_model.dart';
import '../helper/router.dart';
import '../util/constant.dart';
import '../util/theme.dart';
import '../util/toast.dart';




class BusinessSignUpController extends GetxController implements GetxService {
  final BusinessRegisterParser parser;
  final int totalSteps = 4;
  int currentView = 1;
  int type = 1; // 1 = salon // 0 = individual
  final RxInt currentStep = 0.obs;
  final emailText = TextEditingController();
  final businessNameTextEditor = TextEditingController();

  final whatsappTextEditor = TextEditingController();
  final name = TextEditingController();
  final zipcode = TextEditingController();
  final descriptionsTextEditor = 'New Afro Queen Services';
  final addressTextEditor = TextEditingController();
// 2. AJOUTEZ CECI : Variable pour la sélection ACTUELLE
  var selectedCategory = Rxn<Categories>(); // 'Rxn' pour 'Rx nullable'

// 3. AJOUTEZ CECI : Fonction pour mettre à jour la sélection
  void onCategoryChanged(Categories? newValue) {
    selectedCategory.value = newValue;
  }
  var servedCategoriesList = <AddBusinessModel>[].obs;
  List<CityModal> _cityList = <CityModal>[];
  List<CityModal> get cityList => _cityList;

  CityModal _selectedCity = CityModal();
  CityModal get selectedCity => _selectedCity;

  bool emailVerified = false;
  bool phoneVerified = false;
  int smsId = 1;
  RxBool isLogin = false.obs;
  String smsName = AppConstants.defaultSMSGateway;
  bool apiCalled = false;



  BusinessSignUpController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    smsName = parser.getSMSName();
    getHomeCities();
  }

  Future<void> getHomeCities() async {
    Response response = await parser.getHomeCities();
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _cityList = [];
      body.forEach((data) {
        CityModal datas = CityModal.fromJson(data);
        _cityList.add(datas);
      });
      if (_cityList.isNotEmpty) {
        _selectedCity = _cityList[0];
        debugPrint(selectedCity.id.toString());
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCategory(List<AddBusinessModel> list) {
    servedCategoriesList ;
    for (var element in list) {
      if (element.isChecked == true) {
        servedCategoriesList.add(element);
      }
    }
    update();
  }

  void updateType(int number) {
    type = number;
    if (type == 1) {
      debugPrint('salon');
      name.text = '';
    } else {
      name.text = 'NA';
      debugPrint('individual');
    }
    update();
  }
  // Fonction à appeler depuis votre formulaire
// Passez-lui les données récupérées de vos TextFormField, par exemple
  Future<void> envoyerEmailDeConfirmation({
    required String emailUtilisateur,
    required String nomUtilisateur,
   // required String whatsapp,
    required String instagram,
    required String businessName,
    required String zoneZip
  }) async {
    // 1. Afficher un dialogue de chargement
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(), // Un simple spinner
      ),
      barrierDismissible: false, // L'utilisateur ne peut pas fermer le dialogue en cliquant à côté
    );

    try {
      // Référence à votre collection 'mail'
      final mailCollection = FirebaseFirestore.instance.collection('mail');

      // Écriture du document qui va déclencher l'extension
      await mailCollection.add({
        'to': [emailUtilisateur], // L'e-mail vient du formulaire
        'template': {
          'name': 'mailTemplate', // L'ID de votre document 'templates'
          'data': {
            'nom': nomUtilisateur, // La variable {{ nom }}
            'email': emailUtilisateur,
           // 'whatsapp': whatsapp,
            'instagram': instagram,
            'businessName': businessName,
            'zoneZip' : zoneZip
          },
        },
      });
      await mailCollection.add({
        'to': ['souscription@belleza.afroo-app.com'], // <<< VOTRE EMAIL
        'template': {
          'name': 'admin_notification', // <<< Le nouveau template
          'data': {
            'nom': nomUtilisateur, // La variable {{ nom }}
            'email': emailUtilisateur,
          // 'whatsapp': whatsapp,
            'instagram': instagram,
            'businessName': businessName,
            'zoneZip' : zoneZip
          },
        },
      });

      // 2. Fermer le dialogue de chargement
      Get.back();

      // 3. Afficher le dialogue de succès
      Get.dialog(
        AlertDialog(
          title: const Text('Succès'),
          content: const Text('Votre message a été envoyé avec succès.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(), // Ferme le dialogue de succès
              child: const Text('OK'),
            ),
          ],
        ),
      );

      print('Document d\'e-mail ajouté à la file d\'attente !');
    } catch (e) {
      // 2. Fermer le dialogue de chargement (même en cas d'erreur)
      Get.back();

      // 3. Afficher le dialogue d'erreur
      Get.dialog(
        AlertDialog(
          title: const Text('Erreur'),
          content: Text(
              'Une erreur est survenue lors de l\'envoi de votre message. Erreur : $e'),
          actions: [
            TextButton(
              onPressed: () => Get.back(), // Ferme le dialogue d'erreur
              child: const Text('Fermer'),
            ),
          ],
        ),
      );

      print('Erreur lors de l\'ajout du document : $e');
    }
  }
  Future<void> getAllServedCategory() async {
    await Future.delayed(Duration(seconds: 1));
    debugPrint('getAllServedCategory');
    var response = await parser.getAllServedCategory();
    apiCalled = true;
    if (response.statusCode == 200) {
      // success
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      servedCategoriesList ;
      body.forEach((element) {
        AddBusinessModel datas = AddBusinessModel.fromJson(element);
        var index = servedCategoriesList.indexWhere((item) => item.id == datas.id);
        debugPrint(index.toString());
        if (index >= 0) {
          datas.isChecked = true;
        } else {
          datas.isChecked = false;
        }
        servedCategoriesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  void onNext() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
      // Ici, vous pouvez ajouter une validation pour l'étape précédente
    }
    update();
  }
  void onBack() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void onBackRoutes() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> verifyEmail() async {
    debugPrint('verify email');
    if (!GetUtils.isEmail(emailText.text)) {
      showToast("Email is not valid".tr);
      return;
    }

    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              const CircularProgressIndicator(color: ThemeProvider.appColor),
              const SizedBox(width: 30),
              SizedBox(child: Text("Please wait".tr, style: const TextStyle(fontFamily: 'bold'))),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
    var body = {
      "email": emailText.text,
    };
    var response = await parser.verifyEmail(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['data'] == true) {
        smsId = myMap['otp_id'];
        FocusManager.instance.primaryFocus?.unfocus();
        //  onEmailModal();
      } else {
        if (myMap['success'] == false && myMap['status'] == 500) {
          debugPrint(myMap['message'.tr]);
          showToast(myMap['message'.tr]);
        } else {
          showToast('Something went wrong while signup'.tr);
        }
      }
    } else if (response.statusCode == 401) {
      showToast('Something went wrong while signup'.tr);
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }
  void openLink() async {
    var url = Uri.parse('https://www.mapcoordinates.net/en');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url'.tr;
    }
  }

  void onCategoriesList() {
    debugPrint('open category');
    Get.delete<RegisterCategoriesController>(force: true);
    Get.toNamed(AppRouter.allCategoriesRoutes, arguments: [servedCategoriesList]);
  }

  void onCityChanged(CityModal city) {
    _selectedCity = city;
    update();
  }

  void verifyPhoneFromFirebase() {
    phoneVerified = true;
    update();
  }

}
