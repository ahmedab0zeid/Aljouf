
import 'package:aljouf/view/bottom_nav_screens/tabs/cart/cart_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/categories/categories_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/home_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/products_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/profile_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/cash_helper.dart';
import '../../../shared/components.dart';
import '../../../utilities/app_ui.dart';
import '../../../utilities/app_util.dart';
import '../../bloc/layout/bottom_nav_cubit.dart';
import '../../bloc/layout/bottom_nav_states.dart';
import 'bottom_nav_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavTabsScreen extends StatefulWidget {
  const BottomNavTabsScreen({Key? key}) : super(key: key);

  @override
  _BottomNavTabsScreenState createState() => _BottomNavTabsScreenState();
}

class _BottomNavTabsScreenState extends State<BottomNavTabsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppUtil.showPushNotification(context);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(context.read<BottomNavCubit>().currentIndex!=2){
          BottomNavCubit.get(context).setCurrentIndex(2);
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: context.watch<BottomNavCubit>().currentIndex==0?'categories'.tr():context.watch<BottomNavCubit>().currentIndex==1?'bag'.tr():context.watch<BottomNavCubit>().currentIndex==2? Image.asset("${AppUI.imgPath}logo.png",height: 70,):context.watch<BottomNavCubit>().currentIndex==3? 'support'.tr():'profile'.tr(),
            backgroundColor: context.watch<BottomNavCubit>().currentIndex==4 ? AppUI.mainColor:AppUI.whiteColor,
            textColor: context.watch<BottomNavCubit>().currentIndex==4 ? AppUI.whiteColor:AppUI.blackColor,
          leading: context.watch<BottomNavCubit>().currentIndex==2? Container(
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),color: AppUI.shimmerColor.withOpacity(0.5)),
            alignment: Alignment.center,
            child: SvgPicture.asset("${AppUI.iconPath}menu.svg"),
          ):null,
          leadingWidth: 64.0,
          actions: [
            if(context.watch<BottomNavCubit>().currentIndex==2)
              InkWell(
                onTap: (){
                  AppUtil.mainNavigator(context, const ProductsScreen());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  width: 48,decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),color: AppUI.shimmerColor.withOpacity(0.5)),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("${AppUI.iconPath}search.svg"),
                ),
              )
          ]
        ),
        body: BlocBuilder<BottomNavCubit,BottomNavState>(
          buildWhen: (_,state) => state is ChangeState,
          builder: (_,state){
            return BottomNavCubit.get(context).currentIndex==0?const CategoriesScreen():BottomNavCubit.get(context).currentIndex==1?const CartScreen():BottomNavCubit.get(context).currentIndex==2?const HomeScreen():BottomNavCubit.get(context).currentIndex==3?const SupportScreen():const ProfileScreen();
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit,BottomNavState>(
          buildWhen: (_,state) => state is ChangeState,
          builder: (context, state,) {
            var bottomNavProvider = BottomNavCubit.get(context);
            return BottomNavBar(currentIndex: bottomNavProvider.currentIndex,
              onTap0: (){
              bottomNavProvider.setCurrentIndex(0);
            },
              onTap1: (){
              bottomNavProvider.setCurrentIndex(1);
            },
              onTap2: (){
              bottomNavProvider.setCurrentIndex(2);
            },
              onTap3: (){
              bottomNavProvider.setCurrentIndex(3);
            },
              onTap4: (){
              bottomNavProvider.setCurrentIndex(4);
            },

            );
          }
        ),
        // extendBodyBehindAppBar: true,
        extendBody: true,
      ),
    );
  }
}
