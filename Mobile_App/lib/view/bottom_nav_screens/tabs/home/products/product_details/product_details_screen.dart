import 'package:aljouf/bloc/layout/bottom_nav_cubit.dart';
import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/models/home/products_model.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/product_details/taps/details.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/product_details/taps/info_and_care.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/product_details/taps/reviews.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:light_carousel/main/light_carousel.dart';
import '../../../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../../../shared/components.dart';
import '../../../../../../utilities/app_ui.dart';
import '../../../../../../utilities/app_util.dart';
import '../products_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products product;
  final Products? cartItem;
  const ProductDetailsScreen({Key? key, required this.product, this.cartItem}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
var price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product.originPrice!=null){
      price = widget.product.originPrice;
    }else{
      price = widget.product.price;
    }
  }
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xffF4F0D1).withOpacity(0.5),
              height: AppUtil.responsiveHeight(context)*0.32,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // if(product!.images!.isNotEmpty)
                    SizedBox(
                        height: AppUtil.responsiveHeight(context)*0.35,
                        width: double.infinity,
                        child: LightCarousel(
                          images: List.generate(widget.product.images!.isEmpty?1:widget.product.images!.length, (index){
                            return Column(
                              children: [
                                SizedBox(height: AppUtil.responsiveHeight(context)*0.04,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(imageUrl: widget.product.images!.isEmpty?widget.product.image!:widget.product.images![index],height: AppUtil.responsiveHeight(context)*0.22,fit: BoxFit.fill,placeholder: (context, url) => Image.asset("${AppUI.imgPath}productJouf.png",height: AppUtil.responsiveHeight(context)*0.22,width: double.infinity,),
                                    errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}productJouf.png",height: AppUtil.responsiveHeight(context)*0.22,width: double.infinity,),),
                                ),
                                SizedBox(height: AppUtil.responsiveHeight(context)*0.04,),
                              ],
                            );
                          }),
                          dotSize: 7.0,
                          dotSpacing: 25.0,
                          dotColor: AppUI.mainColor.withOpacity(0.3),
                          // dotPosition: AppUtil.rtlDirection(context)?DotPosition.bottomRight:DotPosition.bottomLeft,
                          dotHorizontalPadding: 20,
                          dotIncreasedColor: AppUI.mainColor,
                          indicatorBgPadding: 20.0,
                          dotBgColor: Colors.purple.withOpacity(0.0),
                          borderRadius: true,
                        )
                    ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,left: AppUtil.rtlDirection(context)?null:20,right: AppUtil.rtlDirection(context)?20:null,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: AppUI.whiteColor,
                        child: Icon(AppUtil.rtlDirection(context)?Icons.arrow_back_ios:Icons.arrow_back_ios_new,color: AppUI.blackColor,size: 19,),
                      ),
                    ),
                  ),
                  // if(product!.salePrice!=null)
                  //   Positioned(
                  //     top:  MediaQuery.of(context).padding.top+30,left: !AppUtil.rtlDirection(context)?null:20,right: !AppUtil.rtlDirection(context)?20:null,
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                          // CustomCard(
                          //   height: 30,width: 70,elevation: 0,radius: 5,
                          //   color: AppUI.errorColor.withOpacity(0.13),
                          //   child: const SizedBox(),
                          // ),
                          // CustomText(text: "10 % OFF",color: AppUI.errorColor,fontSize: 10,)
                    //     ],
                    //   ),
                    // ),

                  Positioned(
                    top: 70,left: !AppUtil.rtlDirection(context)?null:20,right: !AppUtil.rtlDirection(context)?20:null,
                    child: Column(
                      children: [
                        // CircleAvatar(
                        //   backgroundColor: AppUI.whiteColor,
                        //   child: Image.asset("${AppUI.imgPath}bag.png",color: AppUI.blackColor,),
                        // ),
                        const SizedBox(height: 20,),
                        BlocBuilder<CategoriesCubit,CategoriesStates>(
                            buildWhen: (context,state){
                              return state is WishChangeState;
                            },
                            builder: (context, state) {
                              return InkWell(
                                onTap: (){
                                  if(widget.product.fav!){
                                    cubit.deleteFromWishList(
                                        context, widget.product.id.toString());
                                  }else {
                                    cubit.addToWishList(
                                        context, widget.product.id.toString());
                                  }
                                },
                                child:
                                CustomCard(
                                  height: 40,width: 40,elevation: 0,radius: 10,padding: 0,
                                  child: Icon(widget.product.fav!?Icons.favorite:Icons.favorite_border,color: widget.product.fav!?AppUI.errorColor:AppUI.blackColor,size: 19,),
                              )
                              );
                            }

                        ),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap: () async {
                            await FlutterShare.share(
                                title: widget.product.name!,
                                linkUrl: widget.product.url!,
                                chooserTitle: 'Share ${widget.product.name}'
                            );
                          },
                          child: CustomCard(
                            height: 40,width: 40,elevation: 0,radius: 10,padding: 0,
                            child: Icon(Icons.share,color: AppUI.blackColor,size: 19,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: widget.product.name,fontSize: 14,),
                  Row(
                    children: [
                      CustomText(text: "${widget.product.special==0?price:widget.product.special} SR",fontWeight: FontWeight.w600,fontSize: 16,),
                      const SizedBox(width: 15,),
                      if(widget.product.special!=0)
                        Row(
                          children: [
                            CustomText(text: "${price} SR",color: AppUI.iconColor,textDecoration: TextDecoration.lineThrough,fontSize: 12,),
                            const SizedBox(width: 15,),
                            CustomText(text: "${(100-((double.parse(widget.product.special!.toString())/double.parse(price.toString()))*100)).round()}%",color: const Color(0xff08C25E),fontSize: 12,)
                          ],
                        ),
                    ],
                  ),
                 // Row(
                  //   children: [
                  //     RatingBar.builder(
                  //       initialRating: double.parse(product!.averageRating!),
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       ignoreGestures: true,
                  //       itemSize: 18,
                  //       unratedColor: AppUI.iconColor.withOpacity(0.1),
                  //       onRatingUpdate: (rating) {
                  //         // cubit.setRate(rating);
                  //       },
                  //       itemBuilder: (BuildContext context, int index) {return const Icon(Icons.star,size: 30,color: Colors.amber,) ; },
                  //     ),
                  //     const SizedBox(width: 10,),
                  //     CustomText(text: "(${product!.ratingCount})",fontSize: 12,),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     CustomText(text: "${"color".tr()}: ",color: AppUI.iconColor,),
                  //     const CustomText(text: "Black",color: Colors.black,fontWeight: FontWeight.w500,),
                  //   ],
                  // ),
                  // const SizedBox(height: 5,),
                  // BlocBuilder<ProductCubit,ProductStates>(
                  //   builder: (context, state) {
                  //   final cubit = ProductCubit.get(context);
                  //     return SizedBox(
                  //       height: 80,
                  //       child: ListView(
                  //         shrinkWrap: true,
                  //         scrollDirection: Axis.horizontal,
                  //         children: List.generate(3, (index) {
                  //           return Row(
                  //             children: [
                  //               CustomCard(
                  //                 onTap: (){
                  //                   cubit.setSelectedColorIndex(index);
                  //                 },
                  //                 elevation: 0,height: 80,width: 60,radius: 10,padding: 0.0,
                  //                 border: cubit.selectedColorIndex==index?AppUI.mainColor:null,color: AppUI.backgroundColor,
                  //                 child: Image.asset("${AppUI.imgPath}men.png"),
                  //               ),
                  //               const SizedBox(width: 10,),
                  //             ],
                  //           );
                  //         }),
                  //       ),
                  //     );
                  //   }
                  // ),
                  // const SizedBox(height: 15,),
                  // BlocBuilder<CategoriesCubit,CategoriesState>(
                  //     builder: (context, state) {
                  //       cubit = CategoriesCubit.get(context);
                  //       return
                ],
              ),
            ),
            const Divider(),
            BlocBuilder<CategoriesCubit,CategoriesStates>(
                buildWhen: (_,state) => state is TabsChangeState,
                builder: (context, state) {
                  return SizedBox(
                  height: cubit.tabIndex == 0? 200:600,
                  child: DefaultTabController(
                    length: 3,
                    initialIndex:  0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                            indicatorWeight: 3,
                            indicatorColor: AppUI.mainColor,
                            unselectedLabelColor: AppUI.blackColor,
                            labelColor: AppUI.mainColor,
                            isScrollable: true,
                            onTap: (index){
                              cubit.tabIndex = index;
                              cubit.emit(TabsChangeState());
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            physics: const BouncingScrollPhysics(),
                            tabs: <Widget>[
                              Tab(child: Text("details".tr(),style: const TextStyle(fontWeight: FontWeight.w100,),textAlign: TextAlign.center,),),
                              Tab(child: Text("nitration".tr(),style: const TextStyle(fontWeight: FontWeight.w100,),textAlign: TextAlign.center,),),
                              Tab(child: Text("reviews".tr(),style: const TextStyle(fontWeight: FontWeight.w100,),textAlign: TextAlign.center,),),
                            ]
                        ),
                        const SizedBox(
                          height: 1,
                            child: Divider()),
                        Expanded(
                          child: TabBarView(
                              children: <Widget> [
                                Details(desc: widget.product.description),
                                InfoAndCare(nitrate: widget.product.customTabs!),
                                ReviewsTab(product: widget.product),
                              ]),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
            InkWell(
              onTap: (){
                AppUtil.mainNavigator(context, const ProductsScreen(offer: true,));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText(text: "youMayAlsoLike".tr()),
                    const Spacer(),
                    CustomText(text: "seeMore".tr(),color: AppUI.mainColor,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: AppUtil.responsiveHeight(context)*0.7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(cubit.offer!.data!.length, (index) {
                  return SizedBox(
                      height: 300,width: AppUtil.responsiveWidth(context)*0.47,
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
                            if (!mounted) return;
                            Navigator.of(context, rootNavigator: true).pop();
                            if(!mounted)return;
                            AppUtil.successToast(context, "productAddedToCart".tr());
                          }else{
                            AppUtil.errorToast(context, "invalidQuantity".tr());
                          }
                        }


                      },));
                }),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomCard(
              height: 80,
              child: BlocBuilder<CategoriesCubit,CategoriesStates>(
                buildWhen: (_,state) => state is AddCartLoadingState || state is AddCartLoadedState,
                builder: (context, state) {
                  if(state is AddCartLoadingState){
                    return const LoadingWidget();
                  }
                  return CustomButton(text: "addToBag".tr(),color: widget.cartItem==null?AppUI.mainColor:AppUI.whiteColor,onPressed: () async {
                  await cubit.addToCart(context,widget.product.id!.toString(),from: "details");
                  },child: widget.cartItem!=null?BlocBuilder<CategoriesCubit,CategoriesStates>(
                    buildWhen: (_,state) => state is ChangeQuantityState,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(child: CustomButton(text: "goToCart".tr(),onPressed: (){
                            BottomNavCubit.get(context).setCurrentIndex(1);
                            AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
                          },)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    if(widget.cartItem!.qty.toString() != widget.cartItem!.quantity) {
                                      if (widget.cartItem!.quantity is String) {
                                        widget.cartItem!.quantity = (int.parse(
                                            widget.cartItem!.quantity
                                                .toString()) + 1).toString();
                                      } else {
                                        widget.cartItem!.quantity = int.parse(
                                            widget.cartItem!.quantity
                                                .toString()) + 1;
                                      }
                                      cubit.emit(ChangeQuantityState());
                                      cubit.changeQuantity(context,
                                          widget.cartItem!.id.toString(),
                                          widget.cartItem!.quantity!
                                              .toString());
                                    }else{
                                      AppUtil.errorToast(context, "invalidQuantity".tr());
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppUI.mainColor,
                                    child: CustomText(text: "+",color: AppUI.whiteColor,fontSize: 25,),
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                CustomText(text: widget.cartItem!.quantity.toString(),fontSize: 25),
                                const SizedBox(width: 15,),
                                InkWell(
                                  onTap: (){
                                    if(int.parse(widget.cartItem!.quantity.toString())!=1) {
                                      if(widget.cartItem!.quantity is String) {
                                        widget.cartItem!.quantity = (int.parse(widget.cartItem!.quantity.toString()) - 1).toString();
                                      }else{
                                        widget.cartItem!.quantity = int.parse(widget.cartItem!.quantity.toString()) - 1;
                                      }
                                      cubit.emit(ChangeQuantityState());
                                      cubit.changeQuantity(context,widget.cartItem!.id.toString(), widget.cartItem!.quantity!.toString());
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppUI.backgroundColor,
                                    child: CustomText(text: "-",color: AppUI.mainColor,fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  ):null,);
                }
              ),
            // );
          // }
      ),
    );
  }
}
