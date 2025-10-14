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
import '../backend/parse/business_register_parse.dart';

class BusinessSignUpController extends GetxController implements GetxService {
  final BusinessRegisterParser parser;
  int currentView = 1;
  int type = 0; // 1 = salon // 0 = individual

  final emailTextEditor = TextEditingController();
  final businessNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();
  String countryCodeMobile = '+33';
  //final passwordTextEditor = TextEditingController();
  //final confirmPasswordTextEditor = TextEditingController();
  String cover = '';
  final lat = TextEditingController();
  final lng = TextEditingController();
  final name = TextEditingController();
  final feeStart = TextEditingController();
  final zipcode = TextEditingController();
  bool passwordVisible = true;
  String otpCode = '';
  final instagramTextEditor = TextEditingController();
  final addressTextEditor = TextEditingController();

  List<CityModal> _cityList = <CityModal>[];
  List<CityModal> get cityList => _cityList;
  String countryCode = '+33';

  CityModal _selectedCity = CityModal();
  CityModal get selectedCity => _selectedCity;

  bool emailVerified = false;
  bool phoneVerified = false;
  int smsId = 1;
  RxBool isLogin = false.obs;
  String smsName = AppConstants.defaultSMSGateway;
  bool apiCalled = false;

  String selectedGender = 'Female';

  List<String> genderList = ['Male', 'Female'];

  List<AddProfileModel> _servedCategoriesList = <AddProfileModel>[];
  List<AddProfileModel> get servedCategoriesList => _servedCategoriesList;
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

  void saveCategory(List<AddProfileModel> list) {
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

  void onNext() {
    currentView = currentView + 1;
    update();
  }

  void onBack() {
    currentView = currentView - 1;
    update();
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
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: ThemeProvider.orangeColor,
                        keyboardType: TextInputType.number,
                        focusedBorderColor: ThemeProvider.appColor,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          otpCode = verificationCode;
                          onOtpSubmit(context, way);
                        }, // end onSubmit
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              AbsorbPointer(
                absorbing: isLogin.value == false ? false : true,
                child: Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.white),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (otpCode != '' && otpCode.length >= 6) {
                          onOtpSubmit(context, way);
                        }
                      },
                      style: ElevatedButton.styleFrom(foregroundColor: ThemeProvider.whiteColor, backgroundColor: ThemeProvider.appColor, elevation: 0),
                      child: isLogin.value == true ? const CircularProgressIndicator(color: ThemeProvider.whiteColor) : Text('Verify'.tr, style: const TextStyle(fontFamily: 'regular', fontSize: 16))),
                ),
              )
            ],
          );
        });
  }

  Future<void> onOtpSubmit(context, way) async {
    isLogin.value = !isLogin.value;
    update();
    var param = {'id': smsId, 'otp': otpCode, 'email': emailTextEditor.text};
    Response response = await parser.verifyOTP(param);
    debugPrint(response.bodyString.toString());
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        Navigator.of(context).pop(true);
        if (way == 'email') {
          emailVerified = true;
        } else {
          phoneVerified = true;
        }
        successToast('Your Email is Verified'.tr);
        update();
      } else {
        showToast('Something went wrong while signup'.tr);
      }
      update();
    } else if (response.statusCode == 401) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  void saveCountryCode(String code) {
    countryCodeMobile = '+$code';
    update();
  }

  Future<void> verifyPhone() async {
    debugPrint('verifyPhone');
    debugPrint(smsName);
    if (mobileTextEditor.text == '' || mobileTextEditor.text.isEmpty) {
      showToast('Phone number is required'.tr);
      return;
    }
    if (smsName == '2') {
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
      var param = {'country_code': countryCodeMobile, 'mobile': mobileTextEditor.text};
      Response response = await parser.checkPhoneExist(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed(AppRouter.getFirebaseAuthRoutes(), arguments: [countryCodeMobile, mobileTextEditor.text, 'register']);
        } else {
          showToast('Something went wrong while signup'.tr);
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['message'] != '') {
          showToast(myMap['message'.tr]);
        } else {
          showToast('Something went wrong'.tr);
        }
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
    } else {
      debugPrint('sms');
      var param = {'country_code': countryCodeMobile, 'mobile': mobileTextEditor.text};
      Response response = await parser.verifyPhone(param);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          smsId = myMap['otp_id'];
          FocusManager.instance.primaryFocus?.unfocus();
          sendSMS();
        } else {
          showToast('Something went wrong while signup'.tr);
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['message'] != '') {
          showToast(myMap['message'.tr]);
        } else {
          showToast('Something went wrong'.tr);
        }
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

  void sendSMS() {
    var context = Get.context as BuildContext;
    openOTPModal(context, countryCodeMobile.toString() + mobileTextEditor.text.toString(), 'mobile');
  }

  void togglePasswordBtn() {
    passwordVisible = !passwordVisible;
    update();
  }

  void saveGender(String gender) {
    selectedGender = gender;
    update();
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

  void verifyPhoneFromFirebase() {
    phoneVerified = true;
    update();
  }

  Future<void> onRegister() async {
    if (emailVerified == false) {
      showToast('Please verify email'.tr);
      return;
    }
    if (phoneVerified == false) {
      showToast('Please verify phone number'.tr);
      return;
    }
    if (emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        businessNameTextEditor.text == '' ||
        businessNameTextEditor.text.isEmpty ||
        lastNameTextEditor.text == '' ||
        lastNameTextEditor.text.isEmpty ||
        mobileTextEditor.text == '' ||
        mobileTextEditor.text.isEmpty ||
        feeStart.text == '' ||
        feeStart.text.isEmpty ||
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
      "fee_start": feeStart.text,
      "about": instagramTextEditor.text,
      "cid": selectedCity.id.toString(),
      "zipcode": zipcode.text,
      "address": addressTextEditor.text,
      "extra_field": 'NA',
      "status": 0,
      "cover": cover,
      "gender": selectedGender == 'Male' ? 1 : 0,
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

