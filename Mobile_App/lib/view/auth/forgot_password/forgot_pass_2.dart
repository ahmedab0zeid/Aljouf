import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../bloc/auth_cubit/auth_states.dart';
import '../../../shared/cash_helper.dart';
import '../../../shared/components.dart';
import '../../../utilities/app_ui.dart';
import '../../../utilities/app_util.dart';
import '../../bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'forgot_pass_3.dart';
class ForgotPass2 extends StatefulWidget {
  final String? email;
  final Map<String,String>? registerFormData;
  const ForgotPass2({Key? key,this.email,this.registerFormData}) : super(key: key);

  @override
  _ForgotPass2State createState() => _ForgotPass2State();
}

class _ForgotPass2State extends State<ForgotPass2> {
  int second = 59;

  Timer? periodicTimer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top,),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 20,),
              CustomText(text: widget.email==null?"verifyEmail".tr():"resetPass".tr(),fontSize: 20,fontWeight: FontWeight.w600,),
              const SizedBox(height: 20,),
              SizedBox(width: AppUtil.responsiveWidth(context)*0.65,child: CustomText(text: "codeSentToEmail".tr(),color: AppUI.shimmerColor,textAlign: TextAlign.center,)),
              CustomText(text: "00:${second<10?"0$second":second}",color: AppUI.errorColor,),
              const SizedBox(height: 30,),
              Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: CustomInput(controller: cubit.verifyController1, textInputType: TextInputType.text,textAlign: TextAlign.center,autofocus: true,onChange: (v){
                            if(v.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },)),
                          const SizedBox(width: 40,),
                          Expanded(child: CustomInput(controller: cubit.verifyController2, textInputType: TextInputType.text,textAlign: TextAlign.center,onChange: (v){
                            if(v.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },)),
                          const SizedBox(width: 40,),
                          Expanded(child: CustomInput(controller: cubit.verifyController3,textInputType: TextInputType.text,textAlign: TextAlign.center,onChange: (v){
                            if(v.length==1){
                              FocusScope.of(context).nextFocus();
                            }
                          },)),
                          const SizedBox(width: 40,),
                          Expanded(child: CustomInput(controller: cubit.verifyController4, textInputType: TextInputType.text,textAlign: TextAlign.center,onChange: (v){
                            if(v.length==1){
                              FocusScope.of(context).unfocus();
                            }
                          },)),
                        ],
                      ),
                       const SizedBox(height: 50,),
                      BlocBuilder<AuthCubit,AuthState>(
                          buildWhen: (_,state) => state is VerifyLoadingState || state is VerifyLoadedState || state is VerifyErrorState,
                          builder: (context, state) {
                            if(state is VerifyLoadingState) {
                              return const LoadingWidget();
                            }
                            return  CustomButton(text: "verify".tr(),onPressed: () async {
                            await cubit.verifyCode(context,widget.email??widget.registerFormData!['email']);
                            if (cubit.verifyResponse!['success'] == 1) {
                              if (!mounted) return;
                              if(widget.email == null) {
                                CashHelper.setSavedString("verify", "true");
                                AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
                              }else{
                                AppUtil.mainNavigator(context, ForgotPass3());
                              }
                              AppUtil.successToast(
                                  context, "emailVerified".tr());
                            } else {
                              if (!mounted) return;
                              AppUtil.errorToast(
                                  context, cubit.verifyResponse!['error'][0]);
                            }
                          },);
                        }
                      ),
                    ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  if(second == 60) {
                    timer();
                    cubit.sendCode(context,
                        widget.email ?? widget.registerFormData!['email']);
                  }
                },
                  child: CustomText(text: "resendOTP".tr(),color: second==60?AppUI.errorColor:AppUI.greyColor,textDecoration: TextDecoration.underline)),
              // CustomInput(controller: TextEditingController(),hint: "newPass".tr(), textInputType: TextInputType.text),
              // const SizedBox(height: 16,),
              // CustomInput(controller: TextEditingController(),hint: "reNewPass".tr(), textInputType: TextInputType.text),
              const SizedBox(height: 50,),
              // Row(
              //   children: [
              //     Expanded(child: Divider()),
              //     Expanded(child: CustomText(text: "isThatYou".tr(),textAlign: TextAlign.center,)),
              //     Expanded(child: Divider()),
              //   ],
              // ),

            ],
          ),
        ),
      ),
    );
  }


  timer() {
    periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(second == 1){
        second = 60;
        timer.cancel();
      }else{
        second--;
      }
      setState(() {});
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(periodicTimer!=null) {
      periodicTimer!.cancel();
    }
  }
}
