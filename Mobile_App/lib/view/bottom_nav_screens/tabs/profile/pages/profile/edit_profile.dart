import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/layout/profile/profile_cubit.dart';
import '../../../../../../utilities/app_ui.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: "profile".tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileCubit,ProfileStates>(
          buildWhen: (_,state) => state is ProfileLoadedState || state is ProfileLoadingState || state is ProfileErrorState,
          builder: (context, state) {
            if(state is ProfileLoadingState){
              return const LoadingWidget();
            }
            if(state is ProfileErrorState){
              return const ErrorFetchWidget();
            }

            cubit.firstName.text = cubit.profileModel!.data!.firstname!;
            cubit.lastName.text = cubit.profileModel!.data!.lastname!;
            cubit.phone.text = cubit.profileModel!.data!.telephone!;
            cubit.email.text = cubit.profileModel!.data!.email!;

            return Column(
              children: [
                Row(
                  children: [
                    CustomText(text: "phoneNumber".tr(),color: AppUI.greyColor,),
                  ],
                ),
                const SizedBox(height: 7,),
                CustomInput(controller: cubit.phone, textInputType: TextInputType.phone,suffixIcon: Image.asset("${AppUI.imgPath}sar.png",width: 60,),),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    CustomText(text: "firstName".tr(),color: AppUI.greyColor,),
                  ],
                ),
                const SizedBox(height: 7,),

                CustomInput(controller: cubit.firstName, textInputType: TextInputType.text),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    CustomText(text: "lastName".tr(),color: AppUI.greyColor,),
                  ],
                ),
                const SizedBox(height: 7,),

                CustomInput(controller: cubit.lastName,textInputType: TextInputType.text),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    CustomText(text: "email".tr(),color: AppUI.greyColor,),
                  ],
                ),
                const SizedBox(height: 7,),
                CustomInput(controller: cubit.email, textInputType: TextInputType.emailAddress,),
                const SizedBox(height: 25,),
                BlocBuilder<ProfileCubit,ProfileStates>(
                    buildWhen: (_,state) => state is EditProfileLoadedState || state is EditProfileLoadingState || state is EditProfileErrorState,
                    builder: (context, state) {
                      if(state is EditProfileLoadingState){
                        return const LoadingWidget();
                      }
                      if(state is EditProfileErrorState){
                        return const ErrorFetchWidget();
                      }
                    return CustomButton(text: "submit".tr(),width: double.infinity,onPressed: (){
                      cubit.editProfile(context);
                    },);
                  }
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
