
import 'dart:math';

import 'package:aljouf/bloc/auth_cubit/auth_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/view/auth/forgot_password/forgot_pass_2.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:flutter/material.dart';

import '../../bloc/layout/profile/profile_cubit.dart';
import '../../shared/cash_helper.dart';
import '../../utilities/app_ui.dart';
import '../../utilities/app_util.dart';
import 'login_or_signup_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    introData();
    Future.delayed(const Duration(milliseconds: 5000),()async{
      String jwt = await CashHelper.getSavedString("jwt", "");
      String lang = await CashHelper.getSavedString("lang", "");
      String verify = await CashHelper.getSavedString("verify", "");
      String email = await CashHelper.getSavedString("email", "");
      if(lang == ""){
        if(!mounted)return;
        if(AppUtil.rtlDirection(context)){
          CashHelper.setSavedString("lang", "ar");
        }else{
          CashHelper.setSavedString("lang", "en-gb");
        }
      }
      // await HomeCubit.get(context).fetchInsurances();
      if(verify!="true" && jwt != ""){
        if(!mounted)return;
        await AuthCubit.get(context).sendCode(context, email);
      }

      if(!mounted)return;
      AppUtil.removeUntilNavigator(context, jwt==""?const LoginOrSignupScreen():verify=="true"?const BottomNavTabsScreen():ForgotPass2(registerFormData: {"email": email},));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset("${AppUI.imgPath}splash.png",width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
            Container(color: const Color(0xffFCFCFC),height: 2,width: double.infinity,)
          ],
        ),
      ),
    );
  }
  String getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
  String getRandomPhone(int length) {
    const _chars = '1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

   introData() async {
     String jwt = await CashHelper.getSavedString("jwt", "");
     if(jwt == ""){
       AuthCubit.get(context).loginState = false;
       String jwtGuest = await CashHelper.getSavedString("jwtGuest", "");
       if(jwtGuest == ""){
         String pass = getRandomString(20);
         Map<String,String> formData = {
           "firstname": getRandomString(8),
           "lastname": getRandomString(8),
           "email": "${getRandomString(8)}@${getRandomString(8)}.com",
           "password": pass,
           "confirm": pass,
           "telephone": "+966${getRandomPhone(9)}"
           // "token": fcm
         };
         await AuthCubit.get(context).register(context, formData);
         if(AuthCubit.get(context).registerModel!.success==1){
           CashHelper.setSavedString("jwtGuest", AuthCubit.get(context).registerModel!.data!.accessToken!);
           print('AuthCubit.get(context).registerModel!.data!.accessToken ${AuthCubit.get(context).registerModel!.data!.accessToken}');
         }
       }
     }
     CategoriesCubit.get(context);
     ProfileCubit.get(context);
   }

}
