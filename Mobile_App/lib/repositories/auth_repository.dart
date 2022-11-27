
import 'dart:convert';

import '../shared/network_helper.dart';

class AuthRepositories{

  static Future<Map<String , dynamic>> register(Map<String,dynamic>formData) async {
    return await NetworkHelper.repo("route=rest/register/register","post",formData: formData,headerState: true);
  }

  static Future<Map<String,dynamic>> login(formData) async {
    return await NetworkHelper.repo("route=rest/login/login","post",formData: formData,headerState: true);
  }

  static Future<Map<String,dynamic>> logout(email) async {
    return await NetworkHelper.repo("route=rest/logout/logout","post");
  }

  static Future<Map<String,dynamic>> sendCode(formData) async {
    return await NetworkHelper.repo("route=rest/forgotten/forgotten","post",formData: formData,headerState: false);
  }

  static Future<Map<String,dynamic>> validateCode(formData) async {
    return await NetworkHelper.repo("route=rest/forgotten/check_otp","post",formData: formData,headerState: false);
  }

  static Future<Map<String , dynamic>> changePass(formData) async {
    return await NetworkHelper.repo("route=rest/account/password","put",formData: formData);
  }

  static Future<Map<String , dynamic>> getToken() async {
    return await NetworkHelper.repo("route=feed/rest_api/gettoken&grant_type=client_credentials","post");
  }


}