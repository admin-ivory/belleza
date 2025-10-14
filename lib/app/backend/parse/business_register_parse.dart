/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:user/app/backend/api/api.dart';
import 'package:user/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:user/app/util/constant.dart';import 'package:image_picker/image_picker.dart';

class BusinessRegisterParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  BusinessRegisterParser({required this.apiService, required this.sharedPreferencesManager});

  Future<Response> onRegister(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.createUser, body);
    return response;
  }

  void saveToken(String token) {
    sharedPreferencesManager.putString('token', token);
  }

  void saveInfo(String id, String firstName, String lastName, String cover, String email, String mobile) {
    sharedPreferencesManager.putString('uid', id);
    sharedPreferencesManager.putString('first_name', firstName);
    sharedPreferencesManager.putString('last_name', lastName);
    sharedPreferencesManager.putString('email', email);
    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('phone', mobile);
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ?? AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  int getVerificationMethod() {
    return sharedPreferencesManager.getInt('user_verify_with') ?? AppConstants.defaultVerificationForSignup;
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ?? AppConstants.defaultSMSGateway;
  }

  Future<Response> saveReferral(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.referralCode, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> sendVerificationMail(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendVerificationMail, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTP, param);
  }

  Future<Response> verifyMobileForeFirebase(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyMobileForeFirebase, param);
  }

  Future<Response> sendRegisterOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendVerificationSMS, param);
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService.uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> verifyEmail(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.verifyEmail, body);
    return response;
  }

  Future<Response> verifyPhone(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.verifyPhoneRegister, body);
    return response;
  }


  Future<Response> getHomeCities() async {
    var response = await apiService.getPublic(AppConstants.getHomeCities);
    return response;
  }

  Future<Response> checkPhoneExist(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.checkPhoneExist, body);
    return response;
  }

  Future<Response> saveMyRequest(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.saveMyRequest, body);
    return response;
  }

}
class RegisterCategoriesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterCategoriesParser({required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getAllServedCategory() async {
    var response = await apiService.getPublic(AppConstants.getActiveCategories);
    return response;
  }
}