import 'package:aljouf/bloc/auth_cubit/auth_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/main.dart';
import 'package:aljouf/shared/cash_helper.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/auth/tabs/sign_in.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/products_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/addresses/addresses_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/change_password_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/favorite_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/orders/my_orders_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/profile/edit_profile.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/setting/setting_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/setting/static_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    final authCubit = AuthCubit.get(context);
    return BlocBuilder<ProfileCubit,ProfileStates>(
      buildWhen: (_,state) => state is ProfileLoadingState || state is ProfileLoadedState || state is ProfileErrorState,
      builder: (context, state) {
        if(state is ProfileLoadingState){
          return const LoadingWidget();
        }
        if(state is ProfileErrorState){
          return const ErrorFetchWidget();
        }

        return Stack(
          children: [
            Image.asset("${AppUI.imgPath}profile_background.png",width: double.infinity,fit: BoxFit.fill,height: AppUtil.responsiveHeight(context)*0.2,),
            Container(
              height: AppUtil.responsiveHeight(context)*0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: AppUtil.rtlDirection(context)?const Radius.circular(400):const Radius.circular(0),bottomRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(400)),
                color: AppUI.whiteColor.withOpacity(0.1),
              ),
            ),
            Column(
              children: [
                SizedBox(height: AppUtil.responsiveHeight(context)*0.0001,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppUI.whiteColor,
                    radius: 30,
                    child: Image.asset('${AppUI.imgPath}profile.png',height: 30,width: 30,),
                  ),
                  title: authCubit.loginState?CustomText(text: "${cubit.profileModel!.data!.firstname} ${cubit.profileModel!.data!.lastname}",color: AppUI.whiteColor,fontWeight: FontWeight.w600,fontSize: 17,):null,
                  subtitle: authCubit.loginState?CustomText(text: cubit.profileModel!.data!.email,color: AppUI.whiteColor,):null,
                ),
                SizedBox(height: AppUtil.responsiveHeight(context)*0.0001,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomCard(
                    height: 100,padding: 7,child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CustomCard(
                              height: 55,
                              onTap: (){
                                if(authCubit.loginState) {
                                  AppUtil.mainNavigator(context, const MyOrdersScreen());
                                }else{
                                  AppUtil.mainNavigator(context, const SignIn());
                                  AppUtil.errorToast(context, "youMustLoginFirst".tr());
                                }
                              },width: 55,radius: 18,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),
                              child: SvgPicture.asset("${AppUI.iconPath}delivery_truck.svg"),
                            ),
                            CustomText(text: "myOrders".tr(),fontWeight: FontWeight.w100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomCard(
                              onTap: (){
                                AppUtil.mainNavigator(context, const ProductsScreen(offer: true,));
                              },
                              height: 55,width: 55,radius: 18,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),
                              child: SvgPicture.asset("${AppUI.iconPath}package.svg"),
                            ),
                            CustomText(text: "offers".tr(),fontWeight: FontWeight.w100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomCard(
                              onTap: (){
                                // if(authCubit.loginState) {
                                  AppUtil.mainNavigator(context, const AddressesScreen());
                                // }else{
                                //   AppUtil.mainNavigator(context, const SignIn());
                                //   AppUtil.errorToast(context, "youMustLoginFirst".tr());
                                // }
                              },
                              height: 55,width: 55,radius: 18,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),
                              child: SvgPicture.asset("${AppUI.iconPath}location.svg"),
                            ),
                            CustomText(text: "addresses".tr(),fontWeight: FontWeight.w100,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomCard(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: (){
                                      if(authCubit.loginState) {
                                        AppUtil.mainNavigator(context, const EditProfile());
                                      }else{
                                        AppUtil.mainNavigator(context, const SignIn());
                                        AppUtil.errorToast(context, "youMustLoginFirst".tr());
                                      }
                                    },
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: SvgPicture.asset("${AppUI.iconPath}profile.svg"),
                                    ),
                                    title: CustomText(text: "profile".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                      child: Divider(thickness: 0.6,)),

                                  ListTile(
                                    onTap: (){
                                      if(authCubit.loginState) {
                                        AppUtil.mainNavigator(context, const ChangePasswordScreen());
                                      }else{
                                        AppUtil.mainNavigator(context, const SignIn());
                                        AppUtil.errorToast(context, "youMustLoginFirst".tr());
                                      }
                                    },
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: Icon(Icons.lock_outline,color: AppUI.mainColor,size: 18,)
                                      // SvgPicture.asset("${AppUI.iconPath}profile.svg"),
                                    ),
                                    title: CustomText(text: "changePass".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                      child: Divider(thickness: 0.6,)),

                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    onTap: (){
                                      AppUtil.mainNavigator(context, FavoriteScreen());
                                    },
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: SvgPicture.asset("${AppUI.iconPath}fav.svg"),
                                    ),
                                    title: CustomText(text: "favorite".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                      child: Divider(thickness: 0.6,)),
                                  // ListTile(
                                  //   contentPadding: const EdgeInsets.all(0),
                                  //   onTap: (){
                                  //     AppUtil.mainNavigator(context, AddressesScreen());
                                  //   },
                                  //   leading: CustomCard(
                                  //     height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                  //     child: SvgPicture.asset("${AppUI.iconPath}location_address.svg",color: AppUI.mainColor,),
                                  //   ),
                                  //   title: CustomText(text: "addresses".tr()),
                                  //   trailing: const Icon(Icons.arrow_forward_ios),
                                  // ),
                                  // const SizedBox(
                                  //     height: 10,
                                  //     child: Divider(thickness: 0.6,)),
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    onTap: (){
                                      AppUtil.dialog2(context, "language".tr(), [
                                        InkWell(
                                          onTap: (){
                                            CashHelper.setSavedString("lang", "en-gb");
                                            context.setLocale(const Locale("en"));
                                            Navigator.of(context,rootNavigator: true).pop();
                                            AppUtil.removeUntilNavigator(context, const MyApp());
                                          },
                                            child: const CustomText(text: "English")),
                                        const SizedBox(height: 2,),
                                        const Divider(),
                                        const SizedBox(height: 2,),
                                        InkWell(
                                            onTap: (){
                                              CashHelper.setSavedString("lang", "ar");
                                              context.setLocale(const Locale("ar"));
                                              Navigator.of(context,rootNavigator: true).pop();
                                              AppUtil.removeUntilNavigator(context, const MyApp());
                                            },
                                            child: const CustomText(text: "العربية")),
                                        const SizedBox(height: 20,)
                                      ]);
                                    },
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: SvgPicture.asset("${AppUI.iconPath}lang.svg"),
                                    ),
                                    title: CustomText(text: "language".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const SizedBox(
                                      height: 10,
                                      child: Divider(thickness: 0.6,)),

                                  ListTile(
                                    onTap: (){
                                      AppUtil.mainNavigator(context, SettingScreen());
                                    },
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: SvgPicture.asset("${AppUI.iconPath}setting.svg"),
                                    ),
                                    title: CustomText(text: "settings".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),

                                  const SizedBox(
                                      height: 10,
                                      child: Divider(thickness: 0.6,)),

                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    onTap: (){
                                      if(authCubit.loginState) {
                                        AppUtil.dialog2(context, "logout".tr(), [
                                          CustomText(text: "areYouSureToLogoutFromThisAccount".tr(),
                                            color: AppUI.greyColor,
                                            textAlign: TextAlign.center,),
                                          const SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              CustomButton(text: "submit".tr(),
                                                width: AppUtil.responsiveWidth(context) * 0.3,
                                                onPressed: () {
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                  CashHelper.logOut(context);
                                                },),
                                              const SizedBox(width: 15,),
                                              CustomButton(text: "cancel".tr(),
                                                width: AppUtil.responsiveWidth(context) * 0.3,
                                                borderColor: AppUI.greyColor,
                                                color: AppUI.whiteColor,
                                                textColor: AppUI.errorColor,
                                                onPressed: () {
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                },),
                                            ],
                                          )
                                        ]);
                                      }else{
                                        AppUtil.mainNavigator(context, const SignIn());
                                      }
                                    },
                                    leading: CustomCard(
                                      height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                                      child: SvgPicture.asset("${AppUI.iconPath}logout.svg"),
                                    ),
                                    title: CustomText(text: authCubit.loginState?"logout".tr():"signin".tr()),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80,)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      }
    );
  }
}
