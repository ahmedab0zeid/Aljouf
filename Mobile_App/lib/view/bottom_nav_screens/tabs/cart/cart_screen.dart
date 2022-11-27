import 'package:aljouf/bloc/layout/bottom_nav_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/product_details/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components.dart';
import '../../../../utilities/app_ui.dart';
import '../../../../utilities/app_util.dart';
import 'checkout/checkout_screen.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top,),
                CustomText(text: "bag".tr(),fontSize: 18,fontWeight: FontWeight.w600,color: AppUI.blackColor,),
                BlocBuilder<CategoriesCubit,CategoriesStates>(
                    buildWhen: (_,state) => state is CartLoadingState || state is CartLoadedState || state is CartEmptyState || state is CartLoadedState || state is ChangeQuantityState,
                    builder: (context, state) {
                      if(state is CartLoadingState){
                        return const LoadingWidget();
                      }
                      if(state is CartEmptyState || cubit.cartModel!.data!.products!.isEmpty){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: double.infinity,),
                            Image.asset("${AppUI.imgPath}emptyCart.png"),
                            const SizedBox(height: 50,),
                            CustomText(text: "yourCartIsEmpty".tr(),fontWeight: FontWeight.w700,)
                          ],
                        );
                      }

                      if(state is CartErrorState){
                        return const ErrorFetchWidget();
                      }
                      return Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(cubit.cartModel!.data!.products!.length, (index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      AppUtil.mainNavigator(context, ProductDetailsScreen(product: cubit.cartModel!.data!.products![index]));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CachedNetworkImage(imageUrl: cubit.cartModel!.data!.products![index].image!,placeholder: (context, url) => Image.asset("${AppUI.imgPath}productJouf.png",height: 150,),
                                                errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}productJouf.png",height: 170,),),
                                            ),
                                            const SizedBox(width: 4,),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        // if(cubit.cartModel!.items![index].title!=null)
                                                        SizedBox(
                                                          width: AppUtil.responsiveWidth(context)*0.6,
                                                            child: CustomText(text: cubit.cartModel!.data!.products![index].name,color: AppUI.greyColor,)),
                                                        // CustomText(text: cubit.cartModel!.data!.products![index].description,color: AppUI.blackColor,),
                                                        // CustomText(text: cubit.cartModel!.items![index].name!.length<3?cubit.cartModel!.items![index].name:"${cubit.cartModel!.items![index].name!.substring(3,cubit.cartModel!.items![index].name!.length>29?24:cubit.cartModel!.items![index].name!.length-5)}...",color: AppUI.blackColor,),
                                                        Row(
                                                          children: [
                                                            // CustomText(text: "${cubit.cartModel!.data!.products![index].special==0?cubit.cartModel!.data!.products![index].price:cubit.cartModel!.data!.products![index].special} SAR",color: AppUI.orangeColor,fontWeight: FontWeight.w600,),
                                                            CustomText(text: "${cubit.cartModel!.data!.products![index].price}",color: AppUI.blackColor,fontWeight: FontWeight.w600,),
                                                            const SizedBox(width: 10,),
                                                            // if(cubit.cartModel!.data!.products![index].special!=0)
                                                            // CustomText(text: "${cubit.cartModel!.data!.products![index].price} SAR",color: AppUI.greyColor,textDecoration: TextDecoration.lineThrough,fontSize: 12,),
                                                          ],
                                                        ),
                                                        // if(cubit.cartList[index].salePrice!="" && cubit.cartList[index].salePrice!=null)
                                                        // if(cubit.cartList[index].attributes!.isNotEmpty)
                                                        //   Row(
                                                        //     children: [
                                                        //       CustomText(text: cubit.cartList[index].attributes![0].name,color: AppUI.iconColor,),
                                                        //       const SizedBox(width: 10,),
                                                        //       CustomText(text:  cubit.cartList[index].attributes![0].option,color: AppUI.blackColor,),
                                                        //     ],
                                                        //   ),
                                                        const SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                if(int.parse(cubit.cartModel!.data!.products![index].quantity.toString())!=1) {
                                                                  if(cubit.cartModel!.data!.products![index].quantity is String) {
                                                                    cubit.cartModel!.data!.products![index].quantity = (int.parse(cubit.cartModel!.data!.products![index].quantity.toString()) - 1).toString();
                                                                  }else{
                                                                    cubit.cartModel!.data!.products![index].quantity = int.parse(cubit.cartModel!.data!.products![index].quantity.toString()) - 1;
                                                                  }
                                                                  cubit.emit(ChangeQuantityState());
                                                                  cubit.changeQuantity(context,cubit.cartModel!.data!.products![index].id.toString(), cubit.cartModel!.data!.products![index].quantity!.toString());
                                                                }
                                                              },
                                                              child: CircleAvatar(radius: 13,backgroundColor: AppUI.greyColor,child: Padding(
                                                                padding: const EdgeInsets.all(1.0),
                                                                child: CircleAvatar(backgroundColor: AppUI.whiteColor,child: const CustomText(text: "-",fontSize: 18,)),
                                                              )),
                                                            ),
                                                            const SizedBox(width: 10,),
                                                            CustomText(text: cubit.cartModel!.data!.products![index].quantity!.toString(),fontSize: 22,),
                                                            const SizedBox(width: 10,),
                                                            InkWell(
                                                              onTap: (){
                                                                if(cubit.cartModel!.data!.products![index].qty.toString() != cubit.cartModel!.data!.products![index].quantity) {
                                                                  if (cubit
                                                                      .cartModel!
                                                                      .data!
                                                                      .products![index]
                                                                      .quantity is String) {
                                                                    cubit
                                                                        .cartModel!
                                                                        .data!
                                                                        .products![index]
                                                                        .quantity =
                                                                        (int
                                                                            .parse(
                                                                            cubit
                                                                                .cartModel!
                                                                                .data!
                                                                                .products![index]
                                                                                .quantity
                                                                                .toString()) +
                                                                            1)
                                                                            .toString();
                                                                  } else {
                                                                    cubit
                                                                        .cartModel!
                                                                        .data!
                                                                        .products![index]
                                                                        .quantity =
                                                                        int.parse(
                                                                            cubit
                                                                                .cartModel!
                                                                                .data!
                                                                                .products![index]
                                                                                .quantity
                                                                                .toString()) +
                                                                            1;
                                                                  }
                                                                  cubit.emit(
                                                                      ChangeQuantityState());
                                                                  cubit
                                                                      .changeQuantity(
                                                                      context,
                                                                      cubit
                                                                          .cartModel!
                                                                          .data!
                                                                          .products![index]
                                                                          .id
                                                                          .toString(),
                                                                      cubit
                                                                          .cartModel!
                                                                          .data!
                                                                          .products![index]
                                                                          .quantity!
                                                                          .toString());
                                                                }else{
                                                                  AppUtil.errorToast(context, "invalidQuantity".tr());
                                                                }
                                                              },
                                                              child: CircleAvatar(radius: 13,backgroundColor: AppUI.greyColor,child: Padding(
                                                                padding: const EdgeInsets.all(1.0),
                                                                child: CircleAvatar(backgroundColor: AppUI.whiteColor,child: const CustomText(text: "+",fontSize: 18,)),

                                                              )),
                                                            ),
                                                            SizedBox(width: AppUtil.responsiveWidth(context)*0.2,),
                                                            InkWell(
                                                              onTap: () async {
                                                                cubit.deleteItemFromCart(context,cubit.cartModel!.data!.products![index].id.toString());
                                                                cubit.cartModel!.data!.products!.remove(cubit.cartModel!.data!.products![index]);
                                                                if(cubit.cartModel!.data!.products!.isEmpty){
                                                                  cubit.emit(CartEmptyState());
                                                                }else {
                                                                  cubit.emit(ChangeQuantityState());
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.asset("${AppUI.imgPath}trash_red.png",height: 20,),
                                                                  const SizedBox(width: 5,),
                                                                  CustomText(text: "delete".tr(),color: AppUI.errorColor,fontSize: 12,)
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25,)
                                ],
                              );
                            }),
                          ),
                          const SizedBox(height: 10,),
                          CustomInput(controller: cubit.couponController,hint: "enterCoupon".tr(), textInputType: TextInputType.text,fillColor: AppUI.whiteColor,borderColor: AppUI.backgroundColor,radius: 4,suffixIcon: InkWell(
                              onTap: (){
                                if(!cubit.couponApplied) {
                                  cubit.addCoupon(context);
                                }else{
                                  cubit.deleteCoupon(context);
                                }
                              },
                              child: CustomText(text: cubit.couponApplied?"cancel".tr():"apply".tr(),color: cubit.couponApplied?AppUI.errorColor:AppUI.mainColor,)),),

                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              CustomText(text: "totalPrice".tr().toUpperCase()),
                              const Spacer(),
                              CustomText(text: "${cubit.total.toString().length>6?cubit.total.toString().substring(0,6):cubit.total} SAR",color: AppUI.blackColor,fontSize: 16,fontWeight: FontWeight.w600,)
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(text: "checkout".tr(),width: AppUtil.responsiveWidth(context)*0.43,onPressed: (){
                                  AppUtil.mainNavigator(context, const CheckoutScreen());
                                },),
                                const SizedBox(width: 10,),
                                CustomButton(text: "continueShopping".tr(),width: AppUtil.responsiveWidth(context)*0.43,borderColor: AppUI.mainColor,color: AppUI.mainColor.withOpacity(0.1),textColor: AppUI.mainColor,onPressed: (){
                                  BottomNavCubit.get(context).setCurrentIndex(2);
                                  AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
                                },)
                              ],
                            ),
                          ),
                          const SizedBox(height: 90,),
                        ],
                      );
                    }
                ),
                ],
            ),
          ),
        ],
      ),
    );
  }
}
