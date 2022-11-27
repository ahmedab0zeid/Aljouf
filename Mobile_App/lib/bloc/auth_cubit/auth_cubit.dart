import 'dart:convert';

import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/models/auth/user_model.dart';
import 'package:aljouf/view/auth/tabs/sign_in.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:aljouf/view/init_screens/login_or_signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import '../../shared/cash_helper.dart';
import '../../utilities/app_util.dart';
import 'auth_states.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final checkFormKey = GlobalKey<FormState>();
  final newPassFormKey = GlobalKey<FormState>();

  bool loginState = true;
  final TextEditingController loginPhone = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();

  final TextEditingController registerEmail = TextEditingController();
  final TextEditingController registerFirstName = TextEditingController();
  final TextEditingController registerLastName = TextEditingController();
  final TextEditingController registerUserName = TextEditingController();
  final TextEditingController registerPhone = TextEditingController();
  final TextEditingController nationalNum = TextEditingController();
  final TextEditingController registerPassword = TextEditingController();
  final TextEditingController registerConfirmPassword = TextEditingController();
  final TextEditingController dateController = TextEditingController();


  final TextEditingController verifyController1 = TextEditingController();
  final TextEditingController verifyController2 = TextEditingController();
  final TextEditingController verifyController3 = TextEditingController();
  final TextEditingController verifyController4 = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();


  bool loginVisibality = true;

  bool registerVisibility = true;
  bool registerConfirmVisibility = true;


  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;


  IconData registerVisibilityIcon = Icons.visibility_off_outlined;
  void registerChangeVisibility() {
    registerVisibility = !registerVisibility;
    registerVisibilityIcon = registerVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(RegisterVisibilityChangeState());
  }

  IconData passwordVisibilityIcon = Icons.visibility_off_outlined;
  void passwordChangeVisibility() {
    passwordVisibility = !passwordVisibility;
    passwordVisibilityIcon = passwordVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PasswordVisibilityChangeState());
  }

  bool male = true;
  changeGenderState(gender){
    male = gender;
    emit(GenderChangeState());
  }

  IconData registerConfirmVisibilityIcon = Icons.visibility_off_outlined;
  void registerConfirmChangeVisibility() {
    registerConfirmVisibility = !registerConfirmVisibility;
    registerConfirmVisibilityIcon = registerConfirmVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(RegisterVisibilityChangeState());
  }

  IconData passwordConfirmVisibilityIcon = Icons.visibility_off_outlined;
  void passwordConfirmChangeVisibility() {
    passwordConfirmVisibility = !passwordConfirmVisibility;
    passwordConfirmVisibilityIcon = passwordConfirmVisibility
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PasswordVisibilityChangeState());
  }

  IconData loginVisibilityIcon = Icons.visibility_off_outlined;
  Future<void> loginChangeVisibility() async {
    loginVisibality = !loginVisibality;
    loginVisibilityIcon = loginVisibality
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(LoginVisibilityChangeState());


  }

  UserModel? loginModel;
  login(context) async {
    emit(LoginLoadingState());
    // String fcm = await AppUtil.getToken();
    String jwtGuest = await CashHelper.getSavedString("jwtGuest", "");
    Map<String,dynamic> formData = {
      "email": loginPhone.text,
      "password": loginPassword.text,
      "access_token": jwtGuest
    };
    try{
      Map<String,dynamic> response = await AuthRepositories.login(formData);
      loginModel = UserModel.fromJson(response);
      if(loginModel!.success != 1){
        AppUtil.errorToast(context, loginModel!.error![0]);
      }else {
        AppUtil.successToast(context, "loginSuccessfully".tr());
        CashHelper.setSavedString("user", jsonEncode(loginModel!.data!));
        CashHelper.setSavedString("jwt", loginModel!.data!.accessToken!);
        CashHelper.setSavedString("email", loginModel!.data!.email!);
        CashHelper.setSavedString("pass", loginPassword.text);
        CashHelper.setSavedString("verify", "true");
        loginState = true;
        AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
        CategoriesCubit.get(context).cart();
        CategoriesCubit.get(context).wishList(fromMain: true);
        ProfileCubit.get(context).profile();
        ProfileCubit.get(context).addresses();
      }
      emit(LoginLoadedState());
    }catch(e){
      AppUtil.errorToast(context, e.toString());
      emit(LoginErrorState());
      return Future.error(e);
    }
  }

  UserModel? registerModel;
  register(context,formData) async {
    emit(RegisterLoadingState());
    // String fcm = await AppUtil.getToken();

    try{
      Map<String,dynamic> response = await AuthRepositories.register(formData);
      registerModel = UserModel.fromJson(response);
      if(registerModel!.success != 1){
        AppUtil.errorToast(context, registerModel!.error![0]);
      }
      emit(RegisterLoadedState());
    }catch(e){
      AppUtil.errorToast(context, e.toString());
      emit(RegisterErrorState());
      return Future.error(e);
    }
  }


  Map<String,dynamic>? sendCodeResponse;
  var forgotEmail = TextEditingController();
  var forgotPass1FormKey = GlobalKey<FormState>();
  sendCode(context,email) async {
    emit(SendCodeLoadingState());
    try{
      sendCodeResponse = await AuthRepositories.sendCode({"email": email});
      emit(SendCodeLoadedState());

    }catch(e){
      AppUtil.errorToast(context, e.toString());
      emit(SendCodeErrorState());
      return Future.error(e);
    }
  }
  Map<String,dynamic>? verifyResponse;
  verifyCode(context,email) async {
    emit(VerifyLoadingState());
    try{
      verifyResponse = await AuthRepositories.validateCode({
        "email": email,
        "activation_code":"${verifyController1.text}${verifyController2.text}${verifyController3.text}${verifyController4.text}"
      });
      emit(VerifyLoadedState());
    }catch(e){
      AppUtil.errorToast(context, e.toString());
      emit(VerifyErrorState());
      return Future.error(e);
    }
  }

  Map<String,dynamic>? resetPassResponse;
  var changePassKey = GlobalKey<FormState>();
  changePass(context) async {
    emit(ChangePassLoadingState());
    try{
      resetPassResponse = await AuthRepositories.changePass({
        "email": forgotEmail.text,
        "password": password.text,
        "confirm": confirmPassword.text
      });
      emit(ChangePassLoadedState());

      if(resetPassResponse!['success'] == 1){
        AppUtil.successToast(context, "passwordChanged".tr());
        AppUtil.removeUntilNavigator(context, const LoginOrSignupScreen());
      }else{
        AppUtil.errorToast(context, resetPassResponse!['error'][0]);
      }
    }catch(e){
      AppUtil.errorToast(context, e.toString());
      emit(ChangePassErrorState());
      return Future.error(e);
    }
  }


  getToken() async {
    try{
      Map<String,dynamic> response = await AuthRepositories.getToken();
      if(response['success'] == 1){
        await CashHelper.setSavedString("jwtGuest", response['data']['access_token']);
      }
    }catch(e){
      return Future.error(e);
    }
  }

}
