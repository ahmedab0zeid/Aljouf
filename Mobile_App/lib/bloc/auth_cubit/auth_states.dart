import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginVisibilityChangeState extends AuthState {}
class ConditionsAgreeChangeState extends AuthState {}
class RegisterVisibilityChangeState extends AuthState {}
class PasswordVisibilityChangeState extends AuthState {}
class GenderChangeState extends AuthState {}

class LoginLoadingState extends AuthState{}
class LoginLoadedState extends AuthState{}
class LoginErrorState extends AuthState{}

class RegisterLoadingState extends AuthState{}
class RegisterLoadedState extends AuthState{}
class RegisterErrorState extends AuthState{}

class SendCodeLoadingState extends AuthState{}
class SendCodeLoadedState extends AuthState{}
class SendCodeErrorState extends AuthState{}

class VerifyLoadingState extends AuthState{}
class VerifyLoadedState extends AuthState{}
class VerifyErrorState extends AuthState{}

class ChangePassLoadingState extends AuthState{}
class ChangePassLoadedState extends AuthState{}
class ChangePassErrorState extends AuthState{}

class CheckLoadingState extends AuthState{}
class CheckLoadedState extends AuthState{}
class CheckErrorState extends AuthState{}

