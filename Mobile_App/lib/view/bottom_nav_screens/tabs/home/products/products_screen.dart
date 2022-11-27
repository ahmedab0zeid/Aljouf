import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/models/home/categories_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/layout/categories/categories_states.dart';
import '../../../../../models/home/products_model.dart';
import '../../../../../utilities/app_util.dart';
import 'filter_screen.dart';
class ProductsScreen extends StatefulWidget {
  final cat;
  final bool offer;
  const ProductsScreen({Key? key,this.cat,this.offer = false}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = CategoriesCubit.get(context);
    cubit.page=1;
    if(!widget.offer) {
      cubit.products.clear();
    }else {
      cubit.offers.clear();
    }
    if(widget.offer){
      CategoriesCubit.get(context).productsOffers();
    }else{
      CategoriesCubit.get(context).productsByCatID(widget.cat==null?null:widget.cat!.categoryId);
    }
    cubit.productsScrollController.addListener(() {
      if (cubit.productsScrollController.position.pixels ==
          cubit.productsScrollController.position.maxScrollExtent) {
        cubit.page++;
        if(widget.offer){
          CategoriesCubit.get(context).productsOffers();
        }else{
          CategoriesCubit.get(context).productsByCatID(widget.cat==null?null:widget.cat!.categoryId);
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);

    return Scaffold(
      appBar: customAppBar(title: widget.offer?"offers".tr():widget.cat==null?"products".tr():widget.cat!.name),
      body: Column(
              children: [
                if(!widget.offer)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomInput(controller: cubit.searchController, textInputType: TextInputType.text,fillColor: AppUI.inputColor,suffixIcon: InkWell(
                    onTap: (){
                      cubit.page = 1;
                      cubit.products.clear();
                      CategoriesCubit.get(context).productsByCatID(widget.cat==null?null:widget.cat!.categoryId,search: cubit.searchController.text);
                    },
                      child: SvgPicture.asset("${AppUI.iconPath}search.svg",height: 22,)),radius: 15,onChange: (v){
                    if(v.isEmpty) {
                      cubit.page = 1;
                      cubit.products.clear();
                      CategoriesCubit.get(context).productsByCatID(widget.cat==null?null:widget.cat!.categoryId,search: v);
                    }
                  },onSubmit: (v){
                    cubit.page = 1;
                    cubit.products.clear();
                    CategoriesCubit.get(context).productsByCatID(widget.cat==null?null:widget.cat!.categoryId,search: v);
                  },),
                ),
                const SizedBox(height: 4,),
                if(!widget.offer)
                  Row(
                  children: [
                    CustomCard(
                      onTap: (){
                        AppUtil.mainNavigator(context, const FilterScreen());
                      },
                      height: 38,width: 80,padding: 4,elevation: 0,border: AppUI.mainColor,radius: 9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("${AppUI.iconPath}filter.svg",),
                          const SizedBox(width: 6,),
                          CustomText(text: "filter".tr())
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<CategoriesCubit,CategoriesStates>(
                        buildWhen: (_,states) => states is ProductsLoadingState || states is ProductsLoadedState || states is ProductsErrorState || states is ProductsEmptyState ||
                            states is OffersLoadingState || states is OffersLoadedState || states is OffersErrorState || states is OffersEmptyState || states is WishChangeState,
                        builder: (context, states) {
                          if(states is ProductsLoadingState  && cubit.page == 1|| states is OffersLoadingState && cubit.page == 1){
                            return const LoadingWidget();
                          }
                          if(states is ProductsErrorState || states is OffersErrorState){
                            return const ErrorFetchWidget();
                          }

                          if(states is ProductsEmptyState  && cubit.page == 1 || states is OffersEmptyState && cubit.page == 1){
                            return const EmptyWidget();
                          }

                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              GridView.count(
                                controller: cubit.productsScrollController,
                              // shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              padding: const EdgeInsets.all(5),
                              childAspectRatio: (150/220),
                              children: List.generate(widget.offer?cubit.offers.length:cubit.products.length, (index) {
                                return ProductCard(product: widget.offer?cubit.offers[index]:cubit.products[index],onFav: (){
                                  if(widget.offer?cubit.offers[index].fav!:cubit.products[index].fav!){
                                    cubit.deleteFromWishList(context, widget.offer?cubit.offers[index].id.toString():cubit.products[index].id.toString());
                                  }else{
                                    cubit.addToWishList(context, widget.offer?cubit.offers[index].id.toString():cubit.products[index].id.toString());
                                  }
                                },addToCart: () async {
                                  Products? cartItem;
                                  Products? product = widget.offer?cubit.offers[index]:cubit.products[index];

                                  for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                                    if(element.productId.toString() == product.id.toString()){
                                      cartItem = element;
                                      break;
                                    }
                                  }
                                  AppUtil.dialog2(context, "", [
                                    const LoadingWidget(),
                                    const SizedBox(height: 30,),
                                  ],backgroundColor: Colors.transparent,barrierDismissible: false);
                                  if(cartItem==null) {
                                    await cubit.addToCart(context, product.id.toString(),from: "home");
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

                                });
                              }),
                              ),
                              SizedBox(
                                height: states is ProductsLoadingState || states is OffersLoadingState && cubit.page>1? 90 : 0,
                                width: double.infinity,
                                child: Center(
                                  child: states is ProductsEmptyState || states is OffersEmptyState && cubit.page > 1
                                      ? Text("noMoreData".tr())
                                      : const LoadingWidget(),
                                ),
                              )
                            ],
                          );
                      }
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}
