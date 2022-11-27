import 'package:aljouf/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/layout/profile/profile_cubit.dart';
import '../../../../../bloc/layout/profile/profile_states.dart';
import '../../../../../utilities/app_ui.dart';
import '../../../../../utilities/app_util.dart';
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: "changePass".tr()),
      body: BlocBuilder<ProfileCubit,ProfileStates>(
          builder: (context, ProfileStates state) {
            final cubit = ProfileCubit.get(context);
            return Form(
              key: cubit.changePassFormState,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // CustomInput(controller: cubit.oldPassword, hint: "oldPass".tr(), textInputType: TextInputType.text,obscureText: cubit.oldPassVisibility,suffixIcon: IconButton(onPressed: (){
                          //   cubit.oldPassChangeVisibility();
                          // }, icon: Icon(cubit.oldPassVisibilityIcon,color: AppUI.iconColor,size: 25,)),),
                          //
                          // const SizedBox(height: 25,),

                          CustomInput(controller: cubit.password, hint: "pass".tr(), textInputType: TextInputType.text,obscureText: cubit.passVisibility,suffixIcon: IconButton(onPressed: (){
                            cubit.passChangeVisibility();
                          }, icon: Icon(cubit.passVisibilityIcon,color: AppUI.iconColor,size: 25,)),),

                          const SizedBox(height: 25,),

                          CustomInput(controller: cubit.rePassword, hint: "rePass".tr(), textInputType: TextInputType.text,obscureText: cubit.rePassVisibility,suffixIcon: IconButton(onPressed: (){
                            cubit.rePassChangeVisibility();
                          }, icon: Icon(cubit.rePassVisibilityIcon,color: AppUI.iconColor,size: 25,)),),

                          const SizedBox(height: 30,),
                          BlocBuilder<ProfileCubit,ProfileStates>(
                              buildWhen: (_,state) => state is ChangePassLoadingState || state is ChangePassLoadedState,
                              builder: (context, ProfileStates state) {
                                if(state is ChangePassLoadingState){
                                  return const LoadingWidget();
                                }
                                return CustomButton(text: "saveChanges".tr(),onPressed: () async {
                                  if(cubit.changePassFormState.currentState!.validate()){
                                    if (cubit.password.text !=
                                        cubit.rePassword.text) {
                                      AppUtil.errorToast(context, "passMisfit".tr());
                                      return;
                                    }
                                    // if (cubit.oldPassword.text !=
                                    //     oldPass) {
                                    //   AppUtil.errorToast(context, "invalidOldPass".tr());
                                    //   return;
                                    // }
                                    await cubit.changePass(context);
                                  }
                                },);
                              }
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}