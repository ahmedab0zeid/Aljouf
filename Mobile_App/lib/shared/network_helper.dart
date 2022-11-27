import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cash_helper.dart';

class NetworkHelper {
  static Future<Uri> setApi(String endPoint) async {
    String lang = await CashHelper.getSavedString("lang", "en-gb");
      return Uri.parse("https://aljouf.com/index.php?$endPoint&language=$lang");
  }


  static Future repo(String endPoint, String type,
      {formData, bool headerState = true}) async {
    String jwt = await CashHelper.getSavedString("jwt", "");
    String jwtGuest = await CashHelper.getSavedString("jwtGuest", "");
    String lang = await CashHelper.getSavedString("lang", "en-gb");
    if (kDebugMode) {
      print(formData);
      print("jwt  :  $jwt");
      print("jwtGuest  :  $jwtGuest");
      print(endPoint);
      print(await setApi(endPoint));
    }
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Cookie": "OCSESSID=8d87b6a83c38ea74f58b36afc3; currency=SAR; language=ar",
      "Authorization": "Bearer ${jwt==''?jwtGuest:jwt}"
    };

    http.Response response = type.toLowerCase() == "post"
        ? await http.post(await setApi(endPoint),
        headers: headerState ? headers : null, body: jsonEncode(formData))
        : type.toLowerCase() == "get" ? await http.get(
        await setApi(endPoint), headers: headerState ? headers : null) : type.toLowerCase() == "put"?  await http.put(await setApi(endPoint),
        headers: headerState ? headers : null, body: jsonEncode(formData)): await http.delete(await setApi(endPoint) , headers: headerState ? headers : null);
    if (kDebugMode) {
      print("$endPoint '$type' ${response.body}");
    }
    var mapResponse = jsonDecode(response.body);
    return mapResponse;
  }
}
