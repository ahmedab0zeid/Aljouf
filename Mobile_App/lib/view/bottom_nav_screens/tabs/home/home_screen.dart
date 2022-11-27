import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/products_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_carousel/main/light_carousel.dart';
import '../../../../models/home/products_model.dart';
import '../../../../utilities/app_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);

    if(cubit.categoriesModel == null || cubit.bannerModel == null || cubit.offer == null || cubit.cartModel == null){
      return const InternetConnectionWidget();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<CategoriesCubit,CategoriesStates>(
            buildWhen: (_,state) =>state is BannerLoadedState || state is BannerLoadingState || state is BannerErrorState,
            builder: (context, state) {
              if(state is BannerLoadingState){
                return const LoadingWidget();
              }
              if(state is BannerErrorState){
                return const ErrorFetchWidget();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){

                  },
                  child: SizedBox(
                      height: AppUtil.responsiveHeight(context)*0.2,
                      width: double.infinity,
                      child: LightCarousel(
                        images: cubit.images,
                        dotSize: 5.0,
                        dotSpacing: 15.0,
                        dotColor: AppUI.whiteColor,
                        dotIncreasedColor: AppUI.mainColor,
                        indicatorBgPadding: 15.0,
                        dotBgColor: Colors.purple.withOpacity(0.0),
                        borderRadius: true,
                      )
                  ),
                ),
              );
            }
          ),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
            buildWhen: (_,states) => states is CategoriesLoadingState || states is CategoriesLoadedState || states is CategoriesErrorState,
            builder: (context, states) {
              if(states is CategoriesLoadingState){
                return const LoadingWidget();
              }
              if(states is CategoriesErrorState){
                return const ErrorFetchWidget();
              }
              if(cubit.categoriesModel == null && states is !CategoriesLoadingState && states is !CategoriesErrorState){
                return const InternetConnectionWidget();
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(cubit.categoriesModel!.data!.length, (index) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: (){
                              // AppUtil.mainNavigator(context, SubCategoriesScreen(cat: cubit.categoriesModel!.data![index]));
                              AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data![index]));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: cubit.categoriesModel!.data![index].mobileImage!,
                                placeholder: (context, url) => Image.asset("${AppUI.imgPath}catJouf.png"),
                                errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}catJouf.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,)
                        ],
                      );
                    }),
                  ),
                ),
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: (){
                AppUtil.mainNavigator(context, const ProductsScreen(offer: true,));
              },
              child: Row(
                children: [
                  CustomText(text: "offers".tr()),
                  const Spacer(),
                  CustomText(text: "seeMore".tr(),color: AppUI.mainColor,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
              buildWhen: (_,states) => states is OffersLoadingState || states is OffersLoadedState || states is OffersErrorState || states is OffersEmptyState || states is WishListLoadedState || states is WishChangeState,
              builder: (context, states) {

                if(states is OffersLoadingState && cubit.page == 1){
                  return const LoadingWidget();
                }
                if(states is OffersErrorState){
                  return const ErrorFetchWidget();
                }

                if(states is OffersEmptyState || cubit.offers.isEmpty){
                  return const EmptyWidget();
                }
                if(cubit.offer == null && states is !OffersLoadingState  && states is !OffersErrorState){
                  return const InternetConnectionWidget();
                }
                return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 280,width: AppUtil.responsiveWidth(context)*0.957,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: List.generate(cubit.offers.length>4?4:cubit.offers.length, (index) {
                          return SizedBox(
                            width: AppUtil.responsiveWidth(context)*0.47,
                            child: ProductCard(product: cubit.offers[index],onFav: (){
                              if(cubit.offers[index].fav!){
                                cubit.deleteFromWishList(context, cubit.offers[index].id.toString());
                              }else{
                                cubit.addToWishList(context, cubit.offers[index].id.toString());
                              }
                            },addToCart: () async {
                              Products? cartItem;
                              for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                                if(element.productId.toString() == cubit.offers[index].id.toString()){
                                  cartItem = element;
                                  break;
                                }
                              }
                                AppUtil.dialog2(context, "", [
                                  const LoadingWidget(),
                                  const SizedBox(height: 30,),
                                ],backgroundColor: Colors.transparent,barrierDismissible: false);
                              if(cartItem==null) {
                                await cubit.addToCart(context, cubit.offers[index].id.toString(),from: "home");
                              }else{
                                if(cartItem.qty.toString() != cartItem.quantity) {
                                  if (cartItem.quantity is String) {
                                    cartItem.quantity = (int.parse(
                                        cartItem.quantity
                                            .toString()) + 1).toString();
                                  } else {
                                    cartItem.quantity = int.parse(
                                        cartItem.quantity
                                            .toString()) + 1;
                                  }
                                  cubit.emit(ChangeQuantityState());
                                      await cubit.changeQuantity(context,
                                          cartItem.id.toString(),
                                          cartItem.quantity.toString());
                                  await cubit.cart();
                                  if(!mounted)return;
                                  Navigator.of(context, rootNavigator: true).pop();
                                  if(!mounted)return;
                                  AppUtil.successToast(context, "productAddedToCart".tr());

                                }else{
                                  AppUtil.errorToast(context, "invalidQuantity".tr());
                                }
                              }

                            },),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: (){
                // AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data!.where((element) => element.categoryId==228).first,));
              },
              child: Row(
                children: [
                  CustomText(text: cubit.categoriesModel!.data!.where((element) => element.categoryId==228).first.name),
                  const Spacer(),
                  // CustomText(text: "seeMore".tr(),color: AppUI.mainColor,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
              buildWhen: (_,states) => states is SubCategoriesLoadingState || states is SubCategoriesLoadedState || states is SubCategoriesErrorState || states is SubCategoriesEmptyState,
              builder: (context, states) {
                if(states is CategoriesLoadingState){
                  return const LoadingWidget();
                }
                if(states is CategoriesErrorState){
                  return const ErrorFetchWidget();
                }

                if(states is SubCategoriesEmptyState){
                  return const EmptyWidget();
                }

                if(cubit.oliveOilSubCategory == null && states is !SubCategoriesLoadingState  && states is !SubCategoriesErrorState){
                  return const InternetConnectionWidget();
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(cubit.oliveOilSubCategory!.data!.subCategories!.length, (index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: (){
                                // AppUtil.mainNavigator(context, SubCategoriesScreen(cat: cubit.categoriesModel!.data![index]));
                                AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.oliveOilSubCategory!.data!.subCategories![index]));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset("${AppUI.imgPath}${(index+1)%2==0?"green_opasity.png": (index+1)%3==0?"yellow_opasity.png":"blue_opasity.png"}"),
                                  Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: CachedNetworkImage(
                                          imageUrl: cubit.oliveOilSubCategory!.data!.subCategories![index].mobileImage!,
                                          placeholder: (context, url) => Image.asset("${AppUI.imgPath}catJouf.png"),
                                          errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}catJouf.png"),
                                        ),
                                      ),
                                      const SizedBox(height: 4,),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                            color: (index+1)%2==0? AppUI.mainColor: (index+1)%3==0? const Color(0xffEBC60D):const Color(0xff2694AC)
                                          ),
                                          alignment: Alignment.center,
                                          child: CustomText(text: cubit.oliveOilSubCategory!.data!.subCategories![index].name,color: AppUI.whiteColor,),
                                        ),
                                      ),

                                    ],
                                  )
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(15),
                                  //   child: CachedNetworkImage(
                                  //     imageUrl: cubit.categoriesModel!.data![index].mobileImage!,
                                  //     placeholder: (context, url) => Image.asset("${AppUI.imgPath}catJouf.png"),
                                  //     errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}catJouf.png"),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15,)
                          ],
                        );
                      }),
                    ),
                  ),
                );
              }
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: (){
                AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data!.where((element) => element.categoryId==228).first,));
              },
              child: Row(
                children: [
                  CustomText(text: cubit.categoriesModel!.data!.where((element) => element.categoryId==228).first.name),
                  const Spacer(),
                  CustomText(text: "seeMore".tr(),color: AppUI.mainColor,),
                ],
              ),
            ),
          ),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
              buildWhen: (_,states) => states is OlivesLoadingState || states is OlivesLoadedState || states is OlivesErrorState || states is OlivesEmptyState || states is WishListLoadedState || states is WishChangeState,
              builder: (context, states) {
                if(states is OlivesLoadingState && cubit.page == 1){
                  return const LoadingWidget();
                }
                if(states is OlivesErrorState){
                  return const ErrorFetchWidget();
                }

                if(states is OlivesEmptyState || cubit.oliveProductsList.isEmpty){
                  return const EmptyWidget();
                }

                if(cubit.oliveProductsModel == null && states is !OlivesLoadingState  && states is !OlivesErrorState){
                  return const InternetConnectionWidget();
                }
                return
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 280,width: AppUtil.responsiveWidth(context)*0.957,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: List.generate(cubit.oliveProductsList.length>4?4:cubit.oliveProductsList.length, (index) {
                            return SizedBox(
                              width: AppUtil.responsiveWidth(context)*0.47,
                              child: ProductCard(product: cubit.oliveProductsList[index],onFav: (){
                                if(cubit.oliveProductsList[index].fav!){
                                  cubit.deleteFromWishList(context, cubit.oliveProductsList[index].id.toString());
                                }else{
                                  cubit.addToWishList(context, cubit.oliveProductsList[index].id.toString());
                                }
                              },addToCart: () async {
                                Products? cartItem;
                                for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                                  if(element.productId.toString() == cubit.oliveProductsList[index].id.toString()){
                                    cartItem = element;
                                    break;
                                  }
                                }
                                AppUtil.dialog2(context, "", [
                                  const LoadingWidget(),
                                  const SizedBox(height: 30,),
                                ],backgroundColor: Colors.transparent,barrierDismissible: false);
                                if(cartItem==null) {
                                  await cubit.addToCart(context, cubit.oliveProductsList[index].id.toString(),from: "home");
                                }else{
                                  if(cartItem.qty.toString() != cartItem.quantity) {
                                    if (cartItem.quantity is String) {
                                      cartItem.quantity = (int.parse(
                                          cartItem.quantity
                                              .toString()) + 1).toString();
                                    } else {
                                      cartItem.quantity = int.parse(
                                          cartItem.quantity
                                              .toString()) + 1;
                                    }
                                    cubit.emit(ChangeQuantityState());
                                    await cubit.changeQuantity(context,
                                        cartItem.id.toString(),
                                        cartItem.quantity.toString());
                                    await cubit.cart();
                                    if (!mounted) return;
                                    Navigator.of(context, rootNavigator: true).pop();
                                    if(!mounted)return;
                                    AppUtil.successToast(context, "productAddedToCart".tr());

                                  }else{
                                    AppUtil.errorToast(context, "invalidQuantity".tr());
                                  }
                                }
                              },),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),

          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("${AppUI.imgPath}honey_banner.png"),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: (){
                AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data!.where((element) => element.categoryId==109).first,));
              },
              child: Row(
                children: [
                  CustomText(text: cubit.categoriesModel!.data!.where((element) => element.categoryId==109).first.name),
                  const Spacer(),
                  CustomText(text: "seeMore".tr(),color: AppUI.mainColor,),
                ],
              ),
            ),
          ),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
              buildWhen: (_,states) => states is HoneyLoadingState || states is HoneyLoadedState || states is HoneyErrorState || states is HoneyEmptyState || states is WishListLoadedState || states is WishChangeState,
              builder: (context, states) {
                if(states is HoneyLoadingState){
                  return const LoadingWidget();
                }
                if(states is HoneyErrorState){
                  return const ErrorFetchWidget();
                }

                if(states is HoneyEmptyState || cubit.honeyProductsList.isEmpty){
                  return const EmptyWidget();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 280,width: AppUtil.responsiveWidth(context)*0.957,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: List.generate(cubit.honeyProductsList.length>4?4:cubit.honeyProductsList.length, (index) {
                            return SizedBox(
                              width: AppUtil.responsiveWidth(context)*0.47,
                              child: ProductCard(product: cubit.honeyProductsList[index],onFav: (){
                                if(cubit.honeyProductsList[index].fav!){
                                  cubit.deleteFromWishList(context, cubit.honeyProductsList[index].id.toString());
                                }else{
                                  cubit.addToWishList(context, cubit.honeyProductsList[index].id.toString());
                                }
                              },addToCart: () async {
                                Products? cartItem;
                                for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                                  if(element.productId.toString() == cubit.honeyProductsList[index].id.toString()){
                                    cartItem = element;
                                    break;
                                  }
                                }
                                AppUtil.dialog2(context, "", [
                                  const LoadingWidget(),
                                  const SizedBox(height: 30,),
                                ],backgroundColor: Colors.transparent,barrierDismissible: false);
                                if(cartItem==null) {
                                  await cubit.addToCart(context, cubit.honeyProductsList[index].id.toString(),from: "home");
                                }else{
                                  if(cartItem.qty.toString() != cartItem.quantity) {
                                    if (cartItem.quantity is String) {
                                      cartItem.quantity = (int.parse(
                                          cartItem.quantity
                                              .toString()) + 1).toString();
                                    } else {
                                      cartItem.quantity = int.parse(
                                          cartItem.quantity
                                              .toString()) + 1;
                                    }
                                    cubit.emit(ChangeQuantityState());
                                    await cubit.changeQuantity(context,
                                        cartItem.id.toString(),
                                        cartItem.quantity.toString());
                                    await cubit.cart();
                                    if (!mounted) return;
                                    Navigator.of(context, rootNavigator: true).pop();
                                    if(!mounted)return;
                                    AppUtil.successToast(context, "productAddedToCart".tr());

                                  }else{
                                    AppUtil.errorToast(context, "invalidQuantity".tr());
                                  }
                                }
                              },),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),


          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("${AppUI.imgPath}fruits_banner.png"),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: (){
                AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data!.where((element) => element.categoryId==227).first,));
              },
              child: Row(
                children: [
                  CustomText(text: cubit.categoriesModel!.data!.where((element) => element.categoryId==227).first.name),
                  const Spacer(),
                  CustomText(text: "seeMore".tr(),color: AppUI.mainColor,),
                ],
              ),
            ),
          ),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
              buildWhen: (_,states) => states is FruitsLoadingState || states is FruitsLoadedState || states is FruitsErrorState || states is FruitsEmptyState || states is WishListLoadedState || states is WishChangeState,
              builder: (context, states) {
                if(states is FruitsLoadingState){
                  return const LoadingWidget();
                }
                if(states is FruitsErrorState){
                  return const ErrorFetchWidget();
                }

                if(states is FruitsEmptyState || cubit.fruitsProductsList.isEmpty){
                  return const EmptyWidget();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 280,width: AppUtil.responsiveWidth(context)*0.957,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: List.generate(cubit.fruitsProductsList.length>4?4:cubit.fruitsProductsList.length, (index) {
                            return SizedBox(
                              width: AppUtil.responsiveWidth(context)*0.47,
                              child: ProductCard(product: cubit.fruitsProductsList[index],onFav: (){
                                if(cubit.fruitsProductsList[index].fav!){
                                  cubit.deleteFromWishList(context, cubit.fruitsProductsList[index].id.toString());
                                }else{
                                  cubit.addToWishList(context, cubit.fruitsProductsList[index].id.toString());
                                }
                              },addToCart: () async {
                                Products? cartItem;
                                for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                                  if(element.productId.toString() == cubit.fruitsProductsList[index].id.toString()){
                                    cartItem = element;
                                    break;
                                  }
                                }
                                AppUtil.dialog2(context, "", [
                                  const LoadingWidget(),
                                  const SizedBox(height: 30,),
                                ],backgroundColor: Colors.transparent,barrierDismissible: false);
                                if(cartItem==null) {
                                  await cubit.addToCart(context, cubit.fruitsProductsList[index].id.toString(),from: "home");
                                }else{
                                  if(cartItem.qty.toString() != cartItem.quantity) {
                                    if (cartItem.quantity is String) {
                                      cartItem.quantity = (int.parse(
                                          cartItem.quantity
                                              .toString()) + 1).toString();
                                    } else {
                                      cartItem.quantity = int.parse(
                                          cartItem.quantity
                                              .toString()) + 1;
                                    }
                                    cubit.emit(ChangeQuantityState());
                                    await cubit.changeQuantity(context,
                                        cartItem.id.toString(),
                                        cartItem.quantity.toString());
                                    await cubit.cart();
                                    if (!mounted) return;
                                    Navigator.of(context, rootNavigator: true).pop();
                                    if(!mounted)return;
                                    AppUtil.successToast(context, "productAddedToCart".tr());

                                  }else{
                                    AppUtil.errorToast(context, "invalidQuantity".tr());
                                  }
                                }
                              },),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),

          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}
