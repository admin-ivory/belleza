/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
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
  final emailTextEditor = TextEditingController();
  final firstNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();
  String countryCodeMobile = '+33';
  String cover = ImageConstant.logoBelleza;
  final lat = 48.857548;
  final lng = 2.351377;
  final name = TextEditingController();
  final zipcode = TextEditingController();
  String otpCode = '';
  final descriptionsTextEditor = 'New Afro Queen Services';
  final addressTextEditor = TextEditingController();

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

  String selectedGender = 'Female';

  String genderList = 'Female';

  List<AddBusinessModel> _servedCategoriesList = <AddBusinessModel>[];
  List<AddBusinessModel> get servedCategoriesList => _servedCategoriesList;
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
    _servedCategoriesList = [];
    for (var element in list) {
      if (element.isChecked == true) {
        _servedCategoriesList.add(element);
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
  void saveCountryCode(String code) {
    countryCodeMobile = '+33';
    update();
  }

  void saveGender(String gender) {
    selectedGender = gender;
    update();
  }

  void onCategoriesList() {
    debugPrint('open category');
    Get.delete<RegisterCategoriesController>(force: true);
    Get.toNamed(AppRouter.allCategoriesRoutes, arguments: [_servedCategoriesList]);
  }

  void onCityChanged(CityModal city) {
    _selectedCity = city;
    update();
  }

  void verifyPhoneFromFirebase() {
    phoneVerified = true;
    update();
  }

  Future<void> onRegister() async {

    if (cover == '' || cover.isEmpty) {
      cover = ImageConstant.logoBelleza;
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
      }      else {
        savedList = ['2'];
      }
      debugPrint(element.id.toString());

    }
    debugPrint(savedList.join(','));
    var body = {
      "email": 'ivoiryproject@gmail.com',
      "from_username": name.text,
      "last_name": 'lastNameTextEditor.text',
      "mobile": mobileTextEditor.text,
      "categories": "2",
      "subject": descriptionsTextEditor,
      "cover": cover,
      'mediaURL':cover,
      'thank_you_text' :'thank you for contacting us',
      'header_text' :'heaaaaaaaaggggg ',
      'from_mail' :'testttteur grome mail',
      'from_message' : 'hhhhhhhhhhhhhhhhhh',
      'to_respond' : 'requuuuuuuuuuuuuuuuuuuuired',
      'id' :'15'
    };
    var response = await parser.sendTestToFirebase(body);
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
