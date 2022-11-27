
import 'dart:convert';

import 'package:aljouf/view/auth/forgot_password/forgot_pass_1.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../bloc/auth_cubit/auth_states.dart';
import '../../../shared/cash_helper.dart';
import '../../../shared/components.dart';
import '../../../utilities/app_ui.dart';
import '../../../utilities/app_util.dart';
import '../forgot_password/forgot_pass_2.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);

    return Scaffold(
      appBar: customAppBar(title: Column(
        children: [
          CustomText(text: "createAccount".tr(),fontSize: 24.0,fontWeight: FontWeight.w600,),
          CustomText(text: "freeSignUp".tr(),color: AppUI.greyColor,),

        ],
      )),
      body: Form(
              key: cubit.registerFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),

                          Row(
                            children: [
                              CustomText(text: "phoneNumber".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),
                          CustomInput(controller: cubit.registerPhone, textInputType: TextInputType.phone,suffixIcon: Image.asset("${AppUI.imgPath}sar.png",width: 60,),),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              CustomText(text: "firstName".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),

                          CustomInput(controller: cubit.registerFirstName, textInputType: TextInputType.text),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              CustomText(text: "lastName".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),

                          CustomInput(controller: cubit.registerLastName,textInputType: TextInputType.text),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              CustomText(text: "email".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),

                          CustomInput(controller: cubit.registerEmail, textInputType: TextInputType.emailAddress,),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              CustomText(text: "pass".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),

                          CustomInput(controller: cubit.registerPassword,textInputType: TextInputType.text,obscureText: cubit.registerVisibility,suffixIcon: IconButton(onPressed: (){
                            cubit.registerChangeVisibility();
                          }, icon: Icon(cubit.registerVisibilityIcon,color: AppUI.iconColor,size: 25,)),),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              CustomText(text: "rePass".tr(),color: AppUI.greyColor,),
                            ],
                          ),
                          const SizedBox(height: 7,),

                          CustomInput(controller: cubit.registerConfirmPassword, textInputType: TextInputType.text,obscureText: cubit.registerConfirmVisibility,suffixIcon: IconButton(onPressed: (){
                            cubit.registerConfirmChangeVisibility();
                          }, icon: Icon(cubit.registerConfirmVisibilityIcon,color: AppUI.iconColor,size: 25,)),),

                          const SizedBox(height: 30,),

                            BlocBuilder<AuthCubit,AuthState>(
                                buildWhen: (_,state) => state is RegisterLoadingState || state is RegisterLoadedState || state is SendCodeLoadingState || state is SendCodeLoadedState || state is SendCodeErrorState || state is RegisterErrorState,
                                builder: (context, state) {
                                  if(state is SendCodeLoadingState || state is RegisterLoadingState) {
                                    return const LoadingWidget();
                                  }
                                  return CustomButton(text: "signup".tr(),width: double.infinity,onPressed: () async {

                                  if(cubit.registerFormKey.currentState!.validate()) {
                                    Map<String,String> formData = {
                                      "firstname": cubit.registerFirstName.text,
                                      "lastname": cubit.registerLastName.text,
                                      "email": cubit.registerEmail.text,
                                      "password": cubit.registerPassword.text,
                                      "confirm": cubit.registerConfirmPassword.text,
                                      "telephone": "+966${cubit.registerPhone.text}"
                                      // "token": fcm
                                    };

                                    await cubit.register(context,formData);
                                    if(cubit.registerModel!.success == 1) {
                                      AppUtil.successToast(context, "loginSuccessfully".tr());
                                      CashHelper.setSavedString("user", jsonEncode(cubit.registerModel!.data!));
                                      CashHelper.setSavedString("jwt", cubit.registerModel!.data!.accessToken!);
                                      CashHelper.setSavedString("email", cubit.registerModel!.data!.email!);
                                      CashHelper.setSavedString("pass", cubit.registerPassword.text);
                                      CashHelper.setSavedString("verify", "false");
                                      if (!mounted) return;
                                      await cubit.sendCode(
                                          context, cubit.registerEmail.text);
                                      if (cubit.sendCodeResponse!['success'] == 1) {
                                        if (!mounted) return;
                                        AppUtil.successToast(
                                            context, "codeSentSuccessfully".tr());
                                        AppUtil.mainNavigator(
                                            context,
                                            ForgotPass2(
                                              registerFormData: formData,));
                                      } else {
                                        if (!mounted) return;
                                        AppUtil.errorToast(
                                            context,
                                            cubit.sendCodeResponse!['error'][0]);
                                      }
                                    }
                                  }
                                },);
                              }
                            ),
                          const SizedBox(height: 20,),
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
                              CustomText(text: "haveAnAccount".tr()),
                              const SizedBox(width: 10,),
                              InkWell(
                                  onTap: (){
                                   Navigator.pop(context);
                                  },
                                  child: CustomText(text: "signin".tr(),color: AppUI.secondColor,)),
                              const SizedBox(height: 30,),
                        ],
                      ),
                    ],
                  ),
                  ]
                )
                ),
              ),
      ),
    );
  }
}
