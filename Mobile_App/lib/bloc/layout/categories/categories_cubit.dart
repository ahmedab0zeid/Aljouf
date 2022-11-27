import 'dart:convert';

import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/models/auth/user_model.dart';
import 'package:aljouf/models/home/banner_model.dart';
import 'package:aljouf/models/home/cart_model.dart';
import 'package:aljouf/models/home/categories_model.dart';
import 'package:aljouf/models/home/sub_categories_model.dart';
import 'package:aljouf/shared/cash_helper.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/home/products_model.dart';
import '../../../repositories/categories_repository.dart';
import '../../../utilities/app_ui.dart';
import '../../../view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import '../bottom_nav_cubit.dart';

class CategoriesCubit extends Cubit<CategoriesStates>{
  CategoriesCubit(): super(CategoriesInitState());
  static CategoriesCubit get(context) => BlocProvider.of(context);

  //filter
  String filterType = "sort";
  String sortGroupValue = "";
  String orderGroupValue = "";
  String catGroupValue = "";
  String priceGroupValue = "";
  String minPrice = "";
  String maxPrice = "";

  setFilterType(filterType){
    this.filterType = filterType;
    emit(FilterChangeState());
  }


  var searchController = TextEditingController();
  BannerModel? bannerModel;
  List<Widget> images = [];

  int tabIndex = 0;
  fetchBanners() async {
    emit(BannerLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.fetchBanners();
      bannerModel = BannerModel.fromJson(response);
      images.clear();
      int i =0;
      if(bannerModel!=null) {
        for (var element in bannerModel!.data!) {
          images.add(ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: bannerModel!.data![i].image!,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Image.asset("${AppUI.imgPath}catJouf.png"),
              errorWidget: (context, url, error) =>
                  Image.asset("${AppUI.imgPath}catJouf.png"),
            ),),
          );
          i++;
        }
      }
      emit(BannerLoadedState());
    } catch (e) {
      emit(BannerErrorState());
      return Future.error(e);
    }
  }

  CategoriesModel? categoriesModel;
  fetchCategories() async {
    emit(CategoriesLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.fetchCategories();
      categoriesModel = CategoriesModel.fromJson(response);
      categoriesModel!.data!.removeWhere((element) => element.status == "0");
      emit(CategoriesLoadedState());
      fetchOliveOilSubCategories();
    } catch (e) {
      emit(CategoriesErrorState());
      return Future.error(e);
    }
  }

  SubCategoriesModel? subCategoriesModel;
  fetchSubCategories(id) async {
    emit(SubCategoriesLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.fetchSubCategories(id);
      subCategoriesModel = SubCategoriesModel.fromJson(response);
      if(subCategoriesModel!.data!.subCategories!.isNotEmpty) {
        emit(SubCategoriesLoadedState());
      }else{
        emit(SubCategoriesEmptyState());
      }
    } catch (e) {
      emit(SubCategoriesErrorState());
      return Future.error(e);
    }
  }

  SubCategoriesModel? oliveOilSubCategory;
  fetchOliveOilSubCategories() async {
    emit(SubCategoriesLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.fetchSubCategories(228);
      oliveOilSubCategory = SubCategoriesModel.fromJson(response);
      if(oliveOilSubCategory!.data!.subCategories!.isNotEmpty) {
        emit(SubCategoriesLoadedState());
      }else{
        emit(SubCategoriesEmptyState());
      }
    } catch (e) {
      emit(SubCategoriesErrorState());
      return Future.error(e);
    }
  }

  ScrollController productsScrollController = ScrollController();
  ProductsModel? productsModel;
  List<Products> products = [];
  int page = 1;
  productsByCatID(id, {search}) async {
    emit(ProductsLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.productsByCatID(id,search: search,page: page,sort: sortGroupValue ,order: orderGroupValue);
      productsModel = ProductsModel.fromJson(response);
      products.addAll(productsModel!.data!);
      if(productsModel!.data!.isNotEmpty) {
        manageFavProducts(products);
        emit(ProductsLoadedState());
      }else{
        emit(ProductsEmptyState());
      }
    } catch (e) {
      emit(ProductsErrorState());
      return Future.error(e);
    }
  }

  ProductsModel? oliveProductsModel;
  List<Products> oliveProductsList = [];
  oliveProducts() async {
    oliveProductsList.clear();
    emit(OlivesLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.productsByCatID(228,page: 1);
      oliveProductsModel = ProductsModel.fromJson(response);
      oliveProductsList.addAll(oliveProductsModel!.data!);
      if(oliveProductsModel!.data!.isNotEmpty) {
        manageFavProducts(oliveProductsList);
        emit(OlivesLoadedState());
      }else{
        emit(OlivesEmptyState());
      }
    } catch (e) {
      emit(OlivesErrorState());
      return Future.error(e);
    }
  }

  ProductsModel? honeyProductsModel;
  List<Products> honeyProductsList = [];
  honeyProducts() async {
    honeyProductsList.clear();
    emit(HoneyLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.productsByCatID(109,page: 1);
      honeyProductsModel = ProductsModel.fromJson(response);
      honeyProductsList.addAll(honeyProductsModel!.data!);
      if(honeyProductsModel!.data!.isNotEmpty) {
        manageFavProducts(honeyProductsList);
        emit(HoneyLoadedState());
      }else{
        emit(HoneyEmptyState());
      }
    } catch (e) {
      emit(HoneyErrorState());
      return Future.error(e);
    }
  }


  ProductsModel? fruitsProductsModel;
  List<Products> fruitsProductsList = [];
  fruitsProducts() async {
    fruitsProductsList.clear();
    emit(FruitsLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.productsByCatID(227,page: 1);
      fruitsProductsModel = ProductsModel.fromJson(response);
      fruitsProductsList.addAll(fruitsProductsModel!.data!);
      if(fruitsProductsModel!.data!.isNotEmpty) {
        manageFavProducts(fruitsProductsList);
        emit(FruitsLoadedState());
      }else{
        emit(FruitsEmptyState());
      }
    } catch (e) {
      emit(FruitsErrorState());
      return Future.error(e);
    }
  }



  ProductsModel? offer;
  List<Products> offers = [];
  productsOffers() async {
    if(page == 1){
      offers.clear();
    }
    emit(OffersLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.productsOffers(page: page);
      offer = ProductsModel.fromJson(response);
      offers.addAll(offer!.data!);
      if(offer!.data!.isNotEmpty) {
        // if(fromMain) {
        //   await wishList();
        //   oliveProducts();
        //   honeyProducts();
        //   fruitsProducts();
        // }else{
          manageFavProducts(offers);
        // }
        emit(OffersLoadedState());
      }else{
        emit(OffersEmptyState());
      }
    } catch (e) {
      emit(OffersErrorState());
      return Future.error(e);
    }
  }


  var commentController = TextEditingController();
  double? rateAdded;
  addReview(id,context, List<Reviews1>? reviews) async {
    User user = User.fromJson(jsonDecode(await CashHelper.getSavedString("user", "")));
    rateAdded ??= 5.0;
    Map<String,String> formData = {
      "name": "${user.firstname} ${user.lastname}",
      "text": commentController.text,
      "rating": "${rateAdded??5}"
    };
    emit(AddReviewsLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.addReview(id,formData);
      if(response['success'] == 1){
        commentController.clear();
        // if(reviews==null){
        //   reviews = [Reviews1(rating: rateAdded.toString(),author: "${user.firstname} ${user.lastname}",text: commentController.text,dateAdded: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}")];
        // }else{
        //   reviews.add(Reviews1(rating: rateAdded.toString(),author: "${user.firstname} ${user.lastname}",text: commentController.text,dateAdded: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}"));
        // }
        // sortReviews(reviews);
        AppUtil.successToast(context, "reviewAdded".tr());
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
      emit(AddReviewsLoadedState());
    } catch (e) {
      emit(AddReviewsErrorState());
      return Future.error(e);
    }
  }

  double rating1 = 0;
  double rating2 = 0;
  double rating3 = 0;
  double rating4 = 0;
  double rating5 = 0;
  double averageCount = 0;
  sortReviews(List<Reviews1> reviews) {
     rating1 = 0;
     rating2 = 0;
     rating3 = 0;
     rating4 = 0;
     rating5 = 0;
     averageCount = 0;
     double sumReviews = 0;
     for (var element in reviews) {
       if(double.parse(element.rating.toString()) == 1.0){
         rating1++;
       }else if(double.parse(element.rating.toString()) == 2.0){
         rating2++;
       }else if(double.parse(element.rating.toString()) == 3.0){
         rating3++;
       }else if(double.parse(element.rating.toString()) == 4.0){
         rating4++;
       }else if(double.parse(element.rating.toString()) == 5.0){
         rating5++;
       }
       sumReviews += double.parse(element.rating!.toString());
     }
     if(sumReviews!=0) {
       averageCount = sumReviews/reviews.length;
     }

  }

  addToCart(context, String id, {from = ""}) async {
    emit(AddCartLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.addToCart({"product_id": id,"quantity": "1"});
      if(from == "home"){
        Navigator.of(context, rootNavigator: true).pop();
      }
      if(from == "details"){
        BottomNavCubit.get(context).setCurrentIndex(1);
        AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
      }
      if(response['success'] == 1){
        AppUtil.successToast(context, "productAddedToCart".tr());
      }else{
        AppUtil.successToast(context, response['error'][0]);
      }
      emit(AddCartLoadedState());
      cart();
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      emit(AddCartLoadedState());
      return Future.error(e);
    }
  }

  changeQuantity(context, String id,qty) async {
    try {
      total = 0;
      for (var element in cartModel!.data!.products!) {
        total += double.parse(element.price.toString().substring(3))*double.parse(element.quantity.toString());
      }
      await CategoriesRepository.changeQuantity({"key": id,"quantity": qty});
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }

  deleteItemFromCart(context, String id) async {
    try {
      for (var element in cartModel!.data!.products!) {
        if(element.id.toString() == id) {
          total -= double.parse(element.price.toString().substring(3))*double.parse(element.quantity.toString());
          break;
        }
      }
      await CategoriesRepository.deleteItemFromCart(id);
      emit(CartLoadedState());
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }


  double total = 0;
  CartModel? cartModel;
  cart() async {
    emit(CartLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.cart();
      if(response['data'] is List){
        response['data'] = {"products": []};
      }
      cartModel = CartModel.fromJson(response);
      if(cartModel!.data!.total==null){
        emit(CartEmptyState());
      }else{
        total = 0;
        for (var element in cartModel!.data!.products!) {
          total += double.parse(element.totalRaw.toString());
        }
        // for (var element in cartModel!.data!.products!) {
        //   total += double.parse(element.price.toString().substring(3))*double.parse(element.quantity.toString());
        // }
        emit(CartLoadedState());
      }
    } catch (e) {
      emit(CartErrorState());
      return Future.error(e);
    }
  }

  ProductsModel? wishlist;
  wishList({fromMain}) async {
    emit(WishListLoadingState());
    try {
      Map<String,dynamic> response = await CategoriesRepository.wishList();
      wishlist = ProductsModel.fromJson(response);
      if(wishlist!.data!.isEmpty){
        emit(WishListEmptyState());
        if(fromMain){
          productsOffers();
          oliveProducts();
          honeyProducts();
          fruitsProducts();
        }
      }else{
        for (var element in wishlist!.data!) {
          element.fav = true;

        }
        if(fromMain){
          productsOffers();
          oliveProducts();
          honeyProducts();
          fruitsProducts();
        }

        emit(WishListLoadedState());
      }
    } catch (e) {
      emit(WishListErrorState());
      return Future.error(e);
    }
  }

  addToWishList(context, String id) async {
    for (var element in products) {
      if(element.id.toString() == id.toString()){
        element.fav = true;
        break;
      }
    }
    for (var element in offers) {
      if(element.id.toString() == id.toString()){
        element.fav = true;
        break;
      }
    }
    for (var element in oliveProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = true;
        break;
      }
    }

    for (var element in honeyProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = true;
        break;
      }
    }

    for (var element in fruitsProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = true;
        break;
      }
    }

    emit(WishChangeState());
    try {
      await CategoriesRepository.addToWishList(id);
      wishList(fromMain: false);
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }

  deleteFromWishList(context, String id) async {
    for (var element in products) {
      if(element.id.toString() == id.toString()){
        element.fav = false;
        break;
      }
    }
    for (var element in offers) {
      if(element.id.toString() == id.toString()){
        element.fav = false;
        break;
      }
    }

    for (var element in oliveProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = false;
        break;
      }
    }


    for (var element in honeyProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = false;
        break;
      }
    }

    for (var element in fruitsProductsList) {
      if(element.id.toString() == id.toString()){
        element.fav = false;
        break;
      }
    }


    wishlist!.data!.removeWhere((element) => element.id.toString() == id.toString());
    emit(WishChangeState());
    try {
      await CategoriesRepository.deleteFromWishList(id);
      wishList(fromMain: false);
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }

  manageFavProducts(List<Products> products){
    for (var element in wishlist!.data!) {
      for (int i = 0; i < products.length; i++){
        if(element.id.toString() == products[i].id.toString()){
          products[i].fav = true;
        }
      }
    }
    emit(ProductsLoadedState());
  }


  var couponController = TextEditingController();
  bool couponApplied = false;
  addCoupon(context) async {
    try {
      AppUtil.dialog2(context, "", [
        const LoadingWidget(),
        const SizedBox(height: 30,)
      ],backgroundColor: Colors.transparent,barrierDismissible: false);
      Map<String,dynamic> response = await CategoriesRepository.addCoupon(couponController.text);
      if(response['success'] == 1) {
        couponApplied = true;
        await cart();
        Navigator.of(context,rootNavigator: true).pop();
        AppUtil.successToast(context, "couponApplied".tr());
      }else{
        Navigator.of(context,rootNavigator: true).pop();
        AppUtil.errorToast(context, response['error'][0]);
      }
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }

  deleteCoupon(context) async {
    couponController.text = "";
    try {
      AppUtil.dialog2(context, "", [
        const LoadingWidget(),
        const SizedBox(height: 30,)
      ],backgroundColor: Colors.transparent,barrierDismissible: false);
      Map<String,dynamic> response = await CategoriesRepository.deleteCoupon();
      if(response['success'] == 1) {
        couponApplied = false;
        await cart();
        Navigator.of(context,rootNavigator: true).pop();
      }else{
        Navigator.of(context,rootNavigator: true).pop();
        AppUtil.errorToast(context, response['error'][0]);
      }
    } catch (e) {
      AppUtil.errorToast(context, e.toString());
      return Future.error(e);
    }
  }


}