import 'package:aljouf/bloc/auth_cubit/auth_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../utilities/app_ui.dart';
class ForgotPass3 extends StatefulWidget {
  const ForgotPass3({Key? key}) : super(key: key);

  @override
  _ForgotPass3State createState() => _ForgotPass3State();
}

class _ForgotPass3State extends State<ForgotPass3> {
  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: cubit.changePassKey,
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
              const SizedBox(height: 20,),
              Row(
                children: [
                  CustomText(text: "pass".tr(),color: AppUI.greyColor,),
                ],
              ),
              const SizedBox(height: 7,),

              BlocBuilder<AuthCubit,AuthState>(
                buildWhen: (_,state) => state is PasswordVisibilityChangeState,
                builder: (context, state) {
                  return CustomInput(controller: cubit.password,textInputType: TextInputType.text,obscureText: cubit.passwordVisibility,suffixIcon: IconButton(onPressed: (){
                    cubit.passwordChangeVisibility();
                  }, icon: Icon(cubit.passwordVisibilityIcon,color: AppUI.iconColor,size: 25,)),);
                }
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  CustomText(text: "rePass".tr(),color: AppUI.greyColor,),
                ],
              ),
              const SizedBox(height: 7,),

              BlocBuilder<AuthCubit,AuthState>(
                  buildWhen: (_,state) => state is PasswordVisibilityChangeState,
                  builder: (context, state) {
                    return CustomInput(controller: cubit.confirmPassword, textInputType: TextInputType.text,obscureText: cubit.passwordConfirmVisibility,suffixIcon: IconButton(onPressed: (){
                    cubit.passwordConfirmChangeVisibility();
                  }, icon: Icon(cubit.passwordConfirmVisibilityIcon,color: AppUI.iconColor,size: 25,)),);
                }
              ),

              const SizedBox(height: 50,),
              BlocBuilder<AuthCubit,AuthState>(
                  buildWhen: (_,state) => state is ChangePassLoadingState || state is ChangePassLoadedState || state is ChangePassErrorState ,
                  builder: (context, state) {
                    if(state is ChangePassLoadingState){
                      return const LoadingWidget();
                    }
                    return CustomButton(text: "changePass".tr(),onPressed: () async {
                      if(cubit.changePassKey.currentState!.validate()) {
                        if(cubit.password.text != cubit.confirmPassword.text){
                          AppUtil.errorToast(context, "passMisFit".tr());
                          return;
                        }
                        await cubit.changePass(context);
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
