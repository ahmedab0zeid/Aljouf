import 'package:aljouf/bloc/layout/bottom_nav_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utilities/app_ui.dart';
import '../../shared/components.dart';

class BottomNavBar extends StatelessWidget {
  final Function() onTap0,onTap1,onTap2,onTap3,onTap4;
  final int currentIndex;
  const BottomNavBar({Key? key,required this.currentIndex,required this.onTap0,required this.onTap1,required this.onTap2,required this.onTap3,required this.onTap4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return CircleBottomNavigationBar(
    //   initialSelection: BottomNavCubit.get(context).currentIndex,
    //   circleColor: AppUI.mainColor,
    //   activeIconColor: AppUI.whiteColor,
    //   inactiveIconColor: AppUI.mainColor,
    //   textColor: AppUI.mainColor,
    //   barHeight: 85,
    //   arcHeight: 100,
    //   tabs: [
    //     TabData(
    //       icon: Icons.grid_view_outlined,
    //       iconSize: 25,
    //       title: 'categories'.tr(), // Optional
    //       fontSize: 12,// Optional
    //     ),
    //     TabData(
    //       icon: Icons.shopping_cart_outlined,
    //       iconSize: 25,
    //       title: 'bag'.tr(), // Optional
    //       fontSize: 12,// Optional
    //     ),
    //     TabData(
    //       icon: Icons.home_outlined,
    //       iconSize: 25,
    //       title: 'home'.tr(), // Optional
    //       fontSize: 12,// Optional
    //     ),
    //     TabData(
    //       icon: Icons.chat_outlined,
    //       iconSize: 25,
    //       title: 'support'.tr(), // Optional
    //       fontSize: 12,// Optional
    //     ),
    //
    //     TabData(
    //       icon: Icons.person_outlined,
    //       iconSize: 25,
    //       title: 'profile'.tr(), // Optional
    //       fontSize: 12,// Optional
    //     ),
    //
    //   ],
    //   onTabChangedListener: onTap,
    // );
    return Stack(
      children: [
        SizedBox(
          height: 85,
          child: Column(
            children: [
              Container(
                color: AppUI.whiteColor,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 25),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: onTap0,
                              child: SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(height: currentIndex==0?7:17,),
                                    Image.asset("${AppUI.imgPath}cat.png",height: 23,width: 23,color: AppUI.mainColor,fit: BoxFit.fill,),
                                    const SizedBox(height: 3,),
                                    CustomText(text: currentIndex==0?"categories".tr():"         ",textAlign: TextAlign.center,color: currentIndex==0?AppUI.mainColor:Colors.grey[400]!.withOpacity(0.8),fontSize: 12,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: onTap1,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(height: currentIndex==1?7:17,),
                                        Image.asset("${AppUI.imgPath}bag.png",height: 23,width: 23,color: AppUI.mainColor,fit: BoxFit.fill,),
                                        CustomText(text: currentIndex==1?"bag".tr():"         ",textAlign: TextAlign.center,color: currentIndex==1?AppUI.mainColor:Colors.grey[400]!,fontSize: 12)
                                      ],
                                    ),
                                  ),
                                  if(CategoriesCubit.get(context).cartModel != null && currentIndex != 1)
                                  BlocBuilder<CategoriesCubit,CategoriesStates>(
                                    buildWhen: (_,state) => state is CartLoadedState,
                                    builder: (context, state) {
                                      if(CategoriesCubit.get(context).cartModel!.data!.products!.isEmpty){
                                        return const SizedBox();
                                      }
                                        return Padding(
                                        padding: const EdgeInsets.only(top: 10,right: 30),
                                        child: CircleAvatar(
                                          radius: 9,backgroundColor: AppUI.ratingColor,
                                          child: CustomText(text: CategoriesCubit.get(context).cartModel!.data!.products!.length.toString(),color: AppUI.whiteColor,fontSize: 12,),
                                        ),
                                      );
                                    }
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: onTap2,
                              child: SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(height: currentIndex==2?7:17,),
                                    Image.asset("${AppUI.imgPath}home.png",height: 23,width: 23,color: AppUI.mainColor,fit: BoxFit.fill,),
                                    CustomText(text: currentIndex==2?"home".tr():"         ",textAlign: TextAlign.center,color: currentIndex==2?AppUI.mainColor:Colors.grey[400]!,fontSize: 12)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: onTap3,
                              child: SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(height: currentIndex==3?7:17,),
                                    Image.asset("${AppUI.imgPath}support.png",height: 23,width: 23,color: AppUI.mainColor,fit: BoxFit.fill),
                                    const SizedBox(height: 3,),
                                    CustomText(text: currentIndex==3?"support".tr():"         ",textAlign: TextAlign.center,color: currentIndex==3?AppUI.mainColor:Colors.grey[400]!,fontSize: 12)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: onTap4,
                              child: SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    SizedBox(height: currentIndex==4?7:17,),
                                    Image.asset("${AppUI.imgPath}profile.png",height: 23,width: 23,color: AppUI.mainColor,fit: BoxFit.fill),
                                    const SizedBox(height: 3,),
                                    CustomText(text: currentIndex==4?"profile".tr():"         ",textAlign: TextAlign.center,color: currentIndex==4?AppUI.mainColor:Colors.grey[400]!,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(currentIndex==0)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5,),
                child: CircleAvatar(
                  backgroundColor: AppUI.mainColor,
                  radius: 27,
                  child: Image.asset("${AppUI.imgPath}cat.png",height: 23,width: 23,color: currentIndex==0?AppUI.whiteColor:Colors.grey[400]!.withOpacity(0.8),fit: BoxFit.fill),
                ),
              ),
            )
            else
              const Expanded(child: SizedBox()),
            if(currentIndex==1)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: CircleAvatar(
                    backgroundColor: AppUI.mainColor,
                    radius: 27,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("${AppUI.imgPath}bag.png",height: 23,width: 23,color: currentIndex==1?AppUI.whiteColor:Colors.grey[400]!.withOpacity(0.8),fit: BoxFit.fill),
                        if(CategoriesCubit.get(context).cartModel != null)
                          BlocBuilder<CategoriesCubit,CategoriesStates>(
                              buildWhen: (_,state) => state is CartLoadedState,
                              builder: (context, state) {
                                if(CategoriesCubit.get(context).cartModel!.data!.products!.isEmpty){
                                  return const SizedBox();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(right: 25,bottom: 20),
                                  child: CircleAvatar(
                                    radius: 9,backgroundColor: AppUI.ratingColor,
                                    child: CustomText(text: CategoriesCubit.get(context).cartModel!.data!.products!.length.toString(),color: AppUI.whiteColor,fontSize: 12,),
                                  ),
                                );
                              }
                          )
                      ],
                    ),
                  ),
                ),
              )
            else
              const Expanded(child: const SizedBox()),
            if(currentIndex==2)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: CircleAvatar(
                    backgroundColor: AppUI.mainColor,
                    radius: 27,
                    child: Image.asset("${AppUI.imgPath}home.png",height: 23,width: 23,color: currentIndex==2?AppUI.whiteColor:Colors.grey[400]!.withOpacity(0.8),fit: BoxFit.fill),
                  ),
                ),
              )else
              const Expanded(child: SizedBox()),
            if(currentIndex==3)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5,right: 3),
                  child: CircleAvatar(
                    backgroundColor: AppUI.mainColor,
                    radius: 27,
                    child: Image.asset("${AppUI.imgPath}support.png",height: 23,width: 23,color: currentIndex==3?AppUI.whiteColor:Colors.grey[400]!.withOpacity(0.8),fit: BoxFit.fill),
                  ),
                ),
              )else
              const Expanded(child: SizedBox()),
            if(currentIndex==4)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                    backgroundColor: AppUI.mainColor,
                    radius: 27,
                    child: Image.asset("${AppUI.imgPath}profile.png",height: 23,width: 23,color: currentIndex==4?AppUI.whiteColor:Colors.grey[400]!.withOpacity(0.8),fit: BoxFit.fill),
                  ),
                ),
              )else
              const Expanded(child: SizedBox()),
          ],
        )
      ],
    );
  }
}
