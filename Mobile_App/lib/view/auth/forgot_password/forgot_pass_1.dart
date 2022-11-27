import 'package:aljouf/bloc/auth_cubit/auth_cubit.dart';
import 'package:aljouf/bloc/auth_cubit/auth_states.dart';
import 'package:aljouf/view/auth/auth_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components.dart';
import '../../../utilities/app_ui.dart';
import '../../../utilities/app_util.dart';
import 'forgot_pass_2.dart';
class ForgotPass1 extends StatefulWidget {
  const ForgotPass1({Key? key}) : super(key: key);

  @override
  _ForgotPass1State createState() => _ForgotPass1State();
}

class _ForgotPass1State extends State<ForgotPass1> {
  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: cubit.forgotPass1FormKey,
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
              CustomText(text: "resetPass".tr(),fontSize: 20,fontWeight: FontWeight.w600,),
              SizedBox(width: AppUtil.responsiveWidth(context)*0.65,child: CustomText(text: "enterEmailOrPhone".tr(),color: AppUI.shimmerColor,textAlign: TextAlign.center,)),
              const SizedBox(height: 20,),
              CustomInput(controller: cubit.forgotEmail,hint: "emailOrPhone".tr(), textInputType: TextInputType.text),
              const SizedBox(height: 50,),
              BlocBuilder<AuthCubit,AuthState>(
                  buildWhen: (_,state) => state is SendCodeLoadingState || state is SendCodeLoadedState || state is SendCodeErrorState,
                builder: (context, state) {
                    if(state is SendCodeLoadingState){
                      return const LoadingWidget();
                    }
                  return CustomButton(text: "sendCode".tr(),onPressed: () async {
                    if(cubit.forgotPass1FormKey.currentState!.validate()) {
                      await cubit.sendCode(context,cubit.forgotEmail.text);
                      if (cubit.sendCodeResponse!['success'] == 1) {
                        if (!mounted) return;
                        AppUtil.successToast(
                            context, "codeSentSuccessfully".tr());
                        AppUtil.mainNavigator(
                            context,
                            ForgotPass2(email: cubit.forgotEmail.text,));
                      } else {
                        if (!mounted) return;
                        AppUtil.errorToast(
                            context, cubit.sendCodeResponse!['error'][0]);
                      }
                    }
                  },);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
