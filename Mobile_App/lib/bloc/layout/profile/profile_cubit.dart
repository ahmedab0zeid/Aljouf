import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/models/auth/user_model.dart';
import 'package:aljouf/models/profile/addresses_model.dart';
import 'package:aljouf/models/profile/all_static_pages_model.dart';
import 'package:aljouf/models/profile/static_page_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/profile_repository.dart';
import '../../../utilities/app_util.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit(): super(ProfileInitState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  UserModel? profileModel;
  profile()async{
    emit(ProfileLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.profile();
      profileModel = UserModel.fromJson(response);
      emit(ProfileLoadedState());
    }catch(e){
      emit(ProfileErrorState());
      return Future.error(e);
    }

  }

  editProfile(context)async{
    Map<String,String> formData = {
      "firstname": firstName.text,
      "lastname": lastName.text,
      "email": email.text,
      "telephone": "${phone.text}"
      // "token": fcm
    };
    emit(EditProfileLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.editProfile(formData);
      if(response['success'] != 1){
        AppUtil.errorToast(context, response['error']![0]);
      }else {
        AppUtil.successToast(context, "profileUpdated".tr());
        profile();
      }
      emit(EditProfileLoadedState());
    }catch(e){
      emit(EditProfileErrorState());
      return Future.error(e);
    }

  }

// change password
  var changePassFormState = GlobalKey<FormState>();
  var oldPassword = TextEditingController();
  var password = TextEditingController();
  var rePassword = TextEditingController();

  bool oldPassVisibility = true;
  bool passVisibility = true;
  bool rePassVisibility = true;
  IconData oldPassVisibilityIcon = Icons.visibility_off_outlined;
  IconData passVisibilityIcon = Icons.visibility_off_outlined;
  IconData rePassVisibilityIcon = Icons.visibility_off_outlined;

  void oldPassChangeVisibility() {
    oldPassVisibility = !oldPassVisibility;
    oldPassVisibilityIcon = oldPassVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PassVisibilityChangeState());
  }

  void passChangeVisibility() {
    passVisibility = !passVisibility;
    passVisibilityIcon = passVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PassVisibilityChangeState());
  }

  void rePassChangeVisibility() {
    rePassVisibility = !rePassVisibility;
    rePassVisibilityIcon = rePassVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PassVisibilityChangeState());
  }

  changePass(context)async{
    Map<String,String> formData = {
      "password": password.text,
      "confirm": rePassword.text
    };
    emit(ChangePassLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.changePass(formData);
      if(response['success'] != 1){
        AppUtil.errorToast(context, response['error']![0]);
      }else {
        password.clear();
        rePassword.clear();
        AppUtil.successToast(context, "passwordUpdated".tr());
      }
      emit(ChangePassLoadedState());
    }catch(e){
      emit(ChangePassLoadedState());
      return Future.error(e);
    }
  }

  AllStaticPagesModel? allStaticPagesModel;
  allStaticPages()async{
    emit(AllStaticPageLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.allStaticPages();
      allStaticPagesModel = AllStaticPagesModel.fromJson(response);
      emit(AllStaticPageLoadedState());
    }catch(e){
      emit(AllStaticPageErrorState());
      return Future.error(e);
    }

  }

  StaticPageModel? aboutPageModel;
  staticPage(id)async{
    emit(StaticPageLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.staticPage(id);
      aboutPageModel = StaticPageModel.fromJson(response);
      emit(StaticPageLoadedState());
    }catch(e){
      emit(StaticPageErrorState());
      return Future.error(e);
    }

  }

  AddressesModel? addressesModel;
  addresses()async{
    emit(AddressesLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.addresses();
      addressesModel = AddressesModel.fromJson(response);
      if(addressesModel!.data!.addresses == null || addressesModel!.data!.addresses!.isEmpty){
        emit(AddressesEmptyState());
      }else{
        emit(AddressesLoadedState());
      }
    }catch(e){
      emit(AddressesErrorState());
      return Future.error(e);
    }
  }

  addAddress({required Map<String, String> formData})async{

    emit(AddAddressesLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.addAddress(formData);
      if(response['success'] == 1){
        await addresses();
      }
      emit(AddressesLoadedState());
      return response;
    }catch(e){
      emit(AddressesLoadedState());
      return Future.error(e);
    }
  }

  editAddress({required Map<String, String> formData,id})async{

    emit(AddAddressesLoadingState());
    try{
      Map<String,dynamic> response = await ProfileRepository.editAddress(formData,id);
      if(response['success'] == 1){
        await addresses();
      }
      emit(AddressesLoadedState());
      return response;
    }catch(e){
      emit(AddressesLoadedState());
      return Future.error(e);
    }
  }

  deleteAddress(id)async{
    try{
      Map<String,dynamic> response = await ProfileRepository.deleteAddress(id);
      if(response['success'] == 1){
        await addresses();
      }
    }catch(e){
      return Future.error(e);
    }
  }

}