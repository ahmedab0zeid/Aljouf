import 'package:aljouf/view/auth/tabs/sign_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../bloc/auth_cubit/auth_states.dart';
import '../../../shared/components.dart';
import '../../../utilities/app_ui.dart';
import '../../../utilities/app_util.dart';
import '../../bottom_nav_screens/bottom_nav_tabs_screen.dart';
import '../forgot_password/forgot_pass_1.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Image.asset("${AppUI.imgPath}logo.png",height: 70,)),
      body: BlocConsumer<AuthCubit,AuthState>(
          listener: (context,state){},
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Form(
              key: cubit.loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    CustomText(text: "welcomeBack".tr(),fontSize: 24.0,fontWeight: FontWeight.w600,),
                    const SizedBox(height: 10,),
                    CustomText(text: "signInToContinue".tr(),color: AppUI.greyColor,),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        CustomText(text: "email".tr(),color: AppUI.greyColor,),
                      ],
                    ),
                    const SizedBox(height: 7,),
                    CustomInput(controller: cubit.loginPhone, hint: "email".tr(), textInputType: TextInputType.emailAddress,
                      // suffixIcon: Image.asset("${AppUI.imgPath}sar.png",width: 60,),
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      children: [
                        CustomText(text: "pass".tr(),color: AppUI.greyColor,),
                      ],
                    ),
                    const SizedBox(height: 7,),
                    CustomInput(controller: cubit.loginPassword, hint: "pass".tr(), textInputType: TextInputType.text,obscureText: cubit.loginVisibality,suffixIcon: IconButton(onPressed: (){
                      cubit.loginChangeVisibility();
                    }, icon: Icon(cubit.loginVisibilityIcon,color: AppUI.iconColor,size: 30,)),),
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              AppUtil.mainNavigator(context, const ForgotPass1());
                            },
                            child: CustomText(text: "forgetPass".tr(),color: AppUI.mainColor,)),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    if(state is LoginLoadingState)
                      const LoadingWidget()
                    else
                      CustomButton(text: "signin".tr(),width: double.infinity,onPressed: () async {
                        if(cubit.loginFormKey.currentState!.validate()) {
                          await cubit.login(context);
                        }
                      },),
                    const SizedBox(height: 5,),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InkWell(
                    //         onTap: () async {
                    //           AppUtil.removeUntilNavigator(
                    //               context, const BottomNavTabsScreen());
                    //         },
                    //         child: CustomText(text: "skipLogin".tr(),color: AppUI.mainColor,fontWeight: FontWeight.w600,fontSize: 16.0,)),
                    //   ],
                    // ),
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Expanded(child: CustomText(text: "orLoginWith".tr(),color: AppUI.shimmerColor,textAlign: TextAlign.center,)),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${AppUI.imgPath}google.png",width: 60,),
                        const SizedBox(width: 20,),
                        Image.asset("${AppUI.imgPath}facebook.png",width: 60,),
                        const SizedBox(width: 20,),
                        Image.asset("${AppUI.imgPath}twitter.png",width: 60,),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: "don'tHaveAnAccount".tr()),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            AppUtil.mainNavigator(context, const SignUp());
                          },
                            child: CustomText(text: "signup".tr(),color: AppUI.secondColor,)),
                        const SizedBox(height: 30,),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
