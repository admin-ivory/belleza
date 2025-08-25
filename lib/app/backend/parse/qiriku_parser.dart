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
import 'package:user/app/util/constant.dart';

class QirikuParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  QirikuParser({required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getHomeData(var body) async {
    var response = await apiService.postPublic(AppConstants.getHomeData, body);
    return response;
  }

  String getCover() {
    return sharedPreferencesManager.getString('cover') ?? '';
  }
  String getAddressName() {
    return sharedPreferencesManager.getString('address') ?? 'Home';
  }
  double getLng() {
    return sharedPreferencesManager.getDouble('lng') ?? 0.0;
  }
  bool haveLoggedIn() {
    return sharedPreferencesManager.getString('uid') != '' && sharedPreferencesManager.getString('uid') != null ? true : false;
  }
  double getLat() {
    return sharedPreferencesManager.getDouble('lat') ?? 0.0;
  }
  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null && sharedPreferencesManager.getString('uid') != '' ? true : false;
  }


  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  Future<Response> logout() async {
    return await apiService.logout(AppConstants.logout, sharedPreferencesManager.getString('token') ?? '');
  }

  void clearAccount() {
    sharedPreferencesManager.clearKey('first_name');
    sharedPreferencesManager.clearKey('last_name');
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
    sharedPreferencesManager.clearKey('email');
    sharedPreferencesManager.clearKey('cover');
  }
}
