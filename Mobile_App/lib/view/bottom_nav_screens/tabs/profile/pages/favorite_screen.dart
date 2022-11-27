import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/home/products_model.dart';
import '../../../../../utilities/app_util.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: "favorite".tr()),
      body:  BlocBuilder<CategoriesCubit,CategoriesStates>(
        buildWhen: (_,state) => state is WishListLoadingState || state is WishListLoadedState || state is WishListErrorState || state is WishListEmptyState || state is WishChangeState,
        builder: (context, state) {
          if(cubit.wishlist==null){
            return const LoadingWidget();
          }
          if(state is WishListErrorState){
            return const ErrorFetchWidget();
          }
          if(state is WishListEmptyState){
            return const EmptyWidget();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(5),
              childAspectRatio: (150/220),
              children: List.generate(cubit.wishlist!.data!.length, (index) {
                return ProductCard(product: cubit.wishlist!.data![index],onFav: (){
                  if(cubit.wishlist!.data![index].fav!){
                    cubit.deleteFromWishList(context, cubit.wishlist!.data![index].id.toString());
                  }else{
                    cubit.addToWishList(context, cubit.wishlist!.data![index].id.toString());
                  }
                },fromFav: true,addToCart: () async {
                  Products? cartItem;
                  for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
                    if(element.productId.toString() == cubit.wishlist!.data![index].id.toString()){
                      cartItem = element;
                      break;
                    }
                  }
                  AppUtil.dialog2(context, "", [
                    const LoadingWidget(),
                    const SizedBox(height: 30,),
                  ],backgroundColor: Colors.transparent,barrierDismissible: false);
                  if(cartItem==null) {
                    await cubit.addToCart(context, cubit.wishlist!.data![index].id.toString());
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
          );
        }
      ),
    );
  }
}
