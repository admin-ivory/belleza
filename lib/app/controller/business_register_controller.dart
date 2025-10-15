
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/app/backend/api/handler.dart';
import 'package:user/app/backend/parse/register_parse.dart';
import 'package:user/app/controller/account_controller.dart';
import 'package:user/app/controller/app_pages_controller.dart';
import 'package:user/app/controller/booking_controller.dart';
import 'package:user/app/controller/categories_controller.dart';
import 'package:user/app/controller/firebase_controller.dart';
import 'package:user/app/controller/home_controller.dart';
import 'package:user/app/controller/near_controller.dart';
import 'package:user/app/controller/register_categories_controller.dart';
import 'package:user/app/controller/tabs_controller.dart';
import 'package:user/app/helper/router.dart';
import 'package:user/app/util/constant.dart';
import 'package:user/app/util/theme.dart';
import 'package:user/app/util/toast.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:user/app/env.dart';

import '../backend/models/add_individual_model.dart';
import '../backend/models/city_model.dart';
import '../backend/models/google_places_model.dart';
import '../backend/parse/business_register_parse.dart';
import '../helper/uuid_generator.dart';

class BusinessSignUpController extends GetxController implements GetxService {
  final BusinessRegisterParser parser;
  //int currentView = 1;
  int type = 0; // 1 = salon // 0 = individual
// Ajoutez ces propriétés à votre BusinessSignUpController
  final RxInt currentStep = 0.obs;
  final int totalSteps = 4; // Nom, Email/Mobile, Catégorie/Zone, Mot de passe
  final List<AddBusinessModel> allCategoriesOptions = [
    AddBusinessModel(categories: 'Coiffure', isChecked: false, id: 1),
    AddBusinessModel(categories: 'Maquillage', isChecked: false, id: 2),
    AddBusinessModel(categories: 'Manucure', isChecked: false, id: 3),
    AddBusinessModel(categories: 'Barbier', isChecked: false, id: 4),
  ];
  final searchbarText = TextEditingController();
  int verificationMethod = AppConstants.defaultVerificationForSignup;
  final emailTextEditor = TextEditingController();
  final businessNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();
  String countryCodeMobile = '+33';
  String cover = '';
  final lat = TextEditingController();
  final lng = TextEditingController();
  final name = TextEditingController();
  final zipcode = TextEditingController();

  final instagramTextEditor = TextEditingController();
  final addressTextEditor = TextEditingController();
  List<GooglePlacesModel> _getList = <GooglePlacesModel>[];
  List<CityModal> _cityList = <CityModal>[];
  List<CityModal> get cityList => _cityList;
  String countryCode = '+33';

  CityModal _selectedCity = CityModal();
  CityModal get selectedCity => _selectedCity;
  bool isConfirmed = false;
  bool emailVerified = false;
   int smsId = 1;
  RxBool isLogin = false.obs;
  String smsName = AppConstants.defaultSMSGateway;
  bool apiCalled = false;

  List<AddBusinessModel> _servedCategoriesList = <AddBusinessModel>[];
  List<AddBusinessModel> get servedCategoriesList => _servedCategoriesList;
  BusinessSignUpController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    smsName = parser.getSMSName();
    getHomeCities();
  }
  void updateCountryCode(String code) {
    countryCode = code;
    update();
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
  void openCategorySelector() {
    // Prépare une liste temporaire pour le dialogue
    List<AddBusinessModel> tempSelectedList = servedCategoriesList.toList();

    Get.dialog(
      SimpleDialog(
        title: Text('Sélectionner les catégories'.tr),
        children: [
          // Le contenu du dialogue de sélection


          // Bouton de validation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Enregistre la sélection finale
              //  servedCategoriesList = tempSelectedList;
                Get.back(); // Ferme le dialogue
              },
              child: Text('Valider ( ${tempSelectedList.length} )'.tr),
            ),
          ),
        ],
      ),
    );
  }

  void onSearchChanged(String value) {
    debugPrint(value);
    if (value.isNotEmpty) {
      getPlacesList(value);
    }
  }

  void saveCategory(List<AddBusinessModel> list) {
    _servedCategoriesList = [];
    for (var element in list) {
      if (element.isChecked == true) {
        _servedCategoriesList.add(element);
      }
    }
    update();
  }
  void onAppPages(String name, String id) {
    debugPrint('$name = $id');
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPagesRoutes(), arguments: [name, id], preventDuplicates: false);
  }
  void updateType(int number) {
    type = number;
    if (type == 1) {
      debugPrint('salon');
      name.text = '';
    } else {
      name.text = 'My Business Name';
      debugPrint('individual');
    }
    update();
  }

  Future<void> getPlacesList(String value) async {
    String googleURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    var sessionToken = Uuid().generateV4();
    var googleKey = Environments.googleMapsKey;
    String request = '$googleURL?input=$value&key=$googleKey&sessiontoken=$sessionToken&types=locality';

    '$googleURL?input=$value&key=$Environments.googleMapsKey&sessiontoken=$sessionToken';
    Response response = await parser.getPlacesList(request);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['predictions'];
      _getList = [];
      body.forEach((data) {
        GooglePlacesModel datas = GooglePlacesModel.fromJson(data);
        _getList.add(datas);
      });
      isConfirmed = false;
      update();
      debugPrint(_getList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
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

  void selectFromGallery(String kind) async {
    debugPrint(kind);
    final pickedFile = await ImagePicker().pickImage(source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera, imageQuality: 25);
    debugPrint(pickedFile.toString());
    if (pickedFile != null) {
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
      Response response = await parser.uploadImage(pickedFile);
      Get.back();
      if (response.statusCode == 200) {
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future<void> verifyEmail() async {
    debugPrint('verify email');
    if (!GetUtils.isEmail(emailTextEditor.text)) {
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
      "email": emailTextEditor.text,
    };
    var response = await parser.verifyEmail(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['data'] == true) {
        smsId = myMap['otp_id'];
        FocusManager.instance.primaryFocus?.unfocus();
        onEmailModal();
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

  void onEmailModal() {
    debugPrint('verify OTP');
    var context = Get.context as BuildContext;
    openOTPModal(context, emailTextEditor.text, 'email');
  }

  void openLink() async {
    var url = Uri.parse('https://www.mapcoordinates.net/en');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url'.tr;
    }
  }

  void openOTPModal(context, String text, String way) {
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: Text("Verification".tr, textAlign: TextAlign.center),
            content: AbsorbPointer(
              absorbing: isLogin.value == false ? false : true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    children: [
                      Text('We have sent verification code on'.tr, style: const TextStyle(fontSize: 12, fontFamily: 'medium')),
                      Text(text, style: const TextStyle(fontSize: 12, fontFamily: 'medium')),
                      const SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
            ),

          );
        });
  }



  void onCategoriesList() {
    debugPrint('open category');
    Get.delete<RegisterCategoriesController>(force: true);
   // Get.toNamed(AppRouter.getRegisterCategoriesRoutes(), arguments: [_servedCategoriesList]);
  }

  void onCityChanged(CityModal city) {
    _selectedCity = city;
    update();
  }

  Future<void> onRegister() async {
// La fonction principale de vérification (email ou téléphone)
    if (verificationMethod == 0) {
      debugPrint('Début de l\'envoi de l\'email de test.');

      // Préparation du body minimal requis par l'API pour un test d'envoi.
      // Nous passons uniquement l'email et les champs requis par votre backend.
      var param = {
        'email': emailTextEditor.text,
        'subject': 'Inscription Pro - Test', // Sujet clair
        'header_text': 'Ceci est un email de test de confirmation.',
        'thank_you_text': "Merci d'avoir soumis votre demande.",
        'mediaURL': '${Environments.apiBaseURL}api/storage/images/',
        'country_code': countryCodeMobile,
        'mobile': mobileTextEditor.text,
        // Suppression des champs inutiles ou spécifiques à l'OTP
      };

      // Dialogue de chargement
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

      // 1. Appel API pour envoyer l'email
      Response response = await parser.sendVerificationMail(param);
      Get.back(); // Ferme le dialogue

      if (response.statusCode == 200) {
        // Succès: Affiche une confirmation simple
        showToast('Email de test envoyé avec succès à ${emailTextEditor.text}'.tr);

        // Si l'email est juste un test, la vérification n'est pas nécessaire.
        // Si vous aviez besoin d'une vérification, vous devriez appeler ici
        // la fonction qui ouvre le modal d'OTP.

      } else if (response.statusCode == 500) {
        // Gestion des erreurs internes du serveur (500)
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        String errorMessage = myMap['message'] ?? 'Erreur interne du serveur (Code 500).';
        showToast(errorMessage.tr);
      } else {
        // Gestion des autres erreurs (400, 401, 404, etc.)
        ApiChecker.checkApi(response);
      }
      update();
    }
    if (emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        businessNameTextEditor.text == '' ||
        businessNameTextEditor.text.isEmpty ||
        lastNameTextEditor.text == '' ||
        lastNameTextEditor.text.isEmpty ||
        mobileTextEditor.text == '' ||
        mobileTextEditor.text.isEmpty ||
        addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        instagramTextEditor.text == '' ||
        instagramTextEditor.text.isEmpty ||
        servedCategoriesList.isEmpty ||
        zipcode.text == '' ||
        zipcode.text.isEmpty ||
        lat.text == '' ||
        lat.text.isEmpty ||
        lng.text == '' ||
        lng.text.isEmpty ||
        name.text == '' ||
        name.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
    if (cover == '' || cover.isEmpty) {
      showToast('Please upload your cover photo'.tr);
      return;
    }
    if (!GetUtils.isEmail(emailTextEditor.text)) {
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
    List<String> savedList = [];
    for (var element in servedCategoriesList) {
      if (element.isChecked == true) {
        savedList.add(element.id.toString());
      }
    }
    debugPrint(savedList.join(','));
    var body = {
      "email": emailTextEditor.text,
      "first_name": businessNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "mobile": mobileTextEditor.text,
      "country_code": countryCodeMobile,
      "categories": savedList.join(','),
      "lat": lat.text,
      "lng": lng.text,
      "cid": selectedCity.id.toString(),
      "zipcode": zipcode.text,
      "address": addressTextEditor.text,
      "status": 0,
      "type": type == 1 ? 'salon' : 'individual',
      "name": name.text
    };
    var response = await parser.saveMyRequest(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Get.generalDialog(
        pageBuilder: (context, __, ___) => AlertDialog(
          title: Text('Success!'.tr),
          content: Text('Your Request is submitted'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onBackRoutes();
              },
              child: Text('Okay'.tr, style: const TextStyle(color: ThemeProvider.appColor, fontFamily: 'bold')),
            )
          ],
        ),
      );
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
}

