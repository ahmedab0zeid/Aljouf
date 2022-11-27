// import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'dart:ui' as ui;
import 'package:toast/toast.dart';
import '../shared/cash_helper.dart';
import '../shared/components.dart';
import 'app_ui.dart';

class AppUtil{

  static double responsiveHeight (context)=> MediaQuery.of(context).size.height;
  static double responsiveWidth (context)=> MediaQuery.of(context).size.width;
  static mainNavigator (context,screen)=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  static removeUntilNavigator (context,screen)=> Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (route) => false);
  static replacementNavigator (context,screen)=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen));


  static bool rtlDirection(context){
    return EasyLocalization.of(context)!.currentLocale==const Locale('en')?false:true;
  }


// Show dialog
  static dialog(context,title,List<Widget> dialogBody,{barrierDismissible=true,alignment,color})async{
    return await showGeneralDialog(context: context,barrierDismissible: barrierDismissible, pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return AlertDialog(
      alignment: alignment??Alignment.center,
      backgroundColor: color??AppUI.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      title: CustomText(text: title,fontWeight: FontWeight.bold,),
      insetPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.all(5),
      contentPadding: EdgeInsets.zero,

      content: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: ListBody(
                children: dialogBody,
              ),
            );
          }
      ),
    ); });
  }


// Show dialog
  static dialog2(context,title,List<Widget> dialogBody,{barrierDismissible=true,backgroundColor})async{
    return await showDialog(context: context,barrierDismissible: barrierDismissible, builder: (context){
      return AlertDialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: CustomText(text: title,textAlign: TextAlign.center,fontWeight: FontWeight.bold,),
        content: SingleChildScrollView(
          child: ListBody(
            children: dialogBody,
          ),
        ),
      );
    });
  }
//Get current location
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<List> getAddress (location) async {

    geocoding.Placemark placemark = await getPlaceMark(location);

    String place = (placemark.country!.isNotEmpty ? '${placemark.country!}, ' : '') +
        (placemark.administrativeArea!.isNotEmpty ? '${placemark.administrativeArea!}, ' : '') +
        (placemark.subLocality!.isNotEmpty ? '${placemark.subLocality!}, ' : '') +
        (placemark.street!.isNotEmpty ? '${placemark.street!} ' : ''
        );

    place = place.isNotEmpty ? place.replaceFirst(', ', '', place.lastIndexOf(', ')) : '';

    return [placemark.postalCode,place,placemark.isoCountryCode];

  }


  static Future<geocoding.Placemark> getPlaceMark (latLng,) async {

    try {

      List<geocoding.Placemark> placeMarks = await geocoding.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: await CashHelper.getSavedString("lang", "")
      );

      geocoding.Placemark placemark = placeMarks[0];

      return placemark;

    }catch (e) {

      return Future.error(e);

    }

  }

  // toast msg
static successToast(context,msg){
  // ToastContext().init(context);
  // Toast.show(msg,duration: 3,gravity: 1,textStyle: TextStyle(color: AppUI.whiteColor),backgroundColor: AppUI.activeColor,);
    Flushbar(
      messageText: Row(
        children: [
          CustomText(text: msg,color: AppUI.whiteColor,),
          const Spacer(),
          Icon(Icons.check,color: AppUI.whiteColor,)
        ],
      ),
      messageColor: AppUI.whiteColor,
      messageSize: 18,
      // titleColor: AppUI.mainColor,
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
      // maxWidth: double.infinity,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      barBlur: .1,
      backgroundColor: AppUI.mainColor,
      borderColor: AppUI.mainColor,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),
    ).show(context);
}

static errorToast(context,msg){
  // ToastContext().init(context);
  // Toast.show(msg,duration: 3,gravity: 1,textStyle: TextStyle(color: AppUI.whiteColor),backgroundColor: AppUI.errorColor);
  Flushbar(
    messageText: Row(
      children: [
        SizedBox(
          width: AppUtil.responsiveWidth(context)*0.78,
            child: CustomText(text: msg,color: AppUI.whiteColor,)),
        const Spacer(),
        Icon(Icons.close,color: AppUI.whiteColor,)
      ],
    ),
    messageColor: AppUI.whiteColor,
    messageSize: 18,
    // titleColor: AppUI.mainColor,
    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
    // maxWidth: double.infinity,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    barBlur: .1,
    backgroundColor: AppUI.errorColor,
    borderColor: AppUI.errorColor,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(10),
  ).show(context);
}

  static Future<void> initNotification() async {
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // messaging.requestPermission();
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  }

  static Future<void> showPushNotification(context) async {

    // FirebaseMessaging.onMessage.listen((event) async {
    //   Flushbar(
    //     message: event.notification!.body ,
    //     title: event.notification!.title,
    //     messageColor: Colors.white,
    //     titleColor: Colors.white,
    //     textDirection: ui.TextDirection.rtl,
    //     padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
    //     // maxWidth: double.infinity,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 5),
    //     flushbarPosition: FlushbarPosition.TOP,
    //     barBlur: .1,
    //     backgroundColor: AppUI.mainColor,
    //     borderColor: Colors.white,
    //     margin: const EdgeInsets.all(8),
    //     borderRadius: BorderRadius.circular(8),
    //   ).show(context);
      // await HomeCubit.get(context).notification();
    // });
  }

  static getToken() async {
    // String? fcm = await FirebaseMessaging.instance.getToken();
    // return fcm;
  }

}