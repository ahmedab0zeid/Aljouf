import '../shared/network_helper.dart';

class ProfileRepository{
  static Future profile() async {
    return await NetworkHelper.repo("route=rest/account/account","get");
  }

  static Future editProfile(formData) async {
    return await NetworkHelper.repo("route=rest/account/account","put",formData: formData);
  }

  static Future changePass(formData) async {
    return await NetworkHelper.repo("route=rest/account/password","put",formData: formData);
  }

  static Future allStaticPages() async {
    return await NetworkHelper.repo("route=feed/rest_api/information","get");
  }

  static Future staticPage(id) async {
    return await NetworkHelper.repo("route=feed/rest_api/information&id=$id","get");
  }

  static Future addresses() async {
    return await NetworkHelper.repo("route=rest/account/address","get");
  }


  static Future deleteAddress(id) async {
    return await NetworkHelper.repo("route=rest/account/address&id=$id","delete");
  }

  static Future editAddress(formData,id) async {
    return await NetworkHelper.repo("route=rest/account/address&id=$id",formData: formData,"put");
  }


  static Future addAddress(formData) async {
    return await NetworkHelper.repo("route=rest/account/address","post",formData: formData);
  }


}