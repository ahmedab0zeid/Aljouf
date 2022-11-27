
import 'package:aljouf/view/auth/tabs/sign_in.dart';
import 'package:aljouf/view/auth/tabs/sign_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../shared/components.dart';
import '../../utilities/app_ui.dart';
import '../../utilities/app_util.dart';
import '../auth/auth_screen.dart';
import '../bottom_nav_screens/bottom_nav_tabs_screen.dart';
class LoginOrSignupScreen extends StatefulWidget {
  const LoginOrSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginOrSignupScreenState createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          Expanded(flex: 3,child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 4,child: Image.asset("${AppUI.imgPath}logo.png",width: 180,)),
              Expanded(
                child: Column(
                  children: [
                    CustomText(text: "startShoppingNow".tr(),color: AppUI.mainColor,fontSize: 24,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: const CustomText(text: "shop from the comfort of your home or while at work with aljouf and get it delivered to your door",textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),

            ],
          )),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(text: "signup".tr(),onPressed: (){
                        AppUtil.mainNavigator(context, const SignUp());
                      },),
                      const SizedBox(height: 10,),
                      CustomButton(text: "signin".tr(),borderColor: AppUI.mainColor,color: AppUI.whiteColor,textColor: AppUI.mainColor,onPressed: (){
                        AppUtil.mainNavigator(context, const SignIn());
                      },),
                      const SizedBox(height: 12,),
                      InkWell(
                        onTap: (){
                          AppUtil.removeUntilNavigator(
                              context, const BottomNavTabsScreen());
                        },
                          child: CustomText(text: "continueAsGuest".tr(),color: AppUI.mainColor,)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
