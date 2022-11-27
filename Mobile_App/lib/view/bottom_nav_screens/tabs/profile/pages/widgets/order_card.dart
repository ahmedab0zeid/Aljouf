import 'package:aljouf/models/profile/orders_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../orders/order_details_screen.dart';
import '../orders/track_order_screen.dart';
class OrderCard extends StatelessWidget {
  final String? state;
  final Data order;
  const OrderCard({Key? key,this.state, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(order.products!.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(imageUrl: order.products![index].image!,fit: BoxFit.fill,height: 70,width: 70,placeholder: (context, url) => Image.asset("${AppUI.imgPath}productJouf.png",height: 70,width: 70,),
                        errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}productJouf.png",height: 70,width: 70,),
                      ),
                      const SizedBox(height: 5,),
                      CustomText(text: "#${order.products![index].productId}  . ${order.products![index].quantity} ${"items".tr()}",color: AppUI.greyColor,fontSize: 12,fontWeight: FontWeight.w100,),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: AppUtil.responsiveWidth(context)*0.6,
                          child: CustomText(text: order.products![index].name,fontSize: 16,fontWeight: FontWeight.w500,)),
                      const SizedBox(height: 5,),
                      if(index!=order.products!.length-1)
                      const Divider()
                    ],
                  );
                }),
              ),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: state=="7"?AppUI.errorColor.withOpacity(0.1):state=="5"?AppUI.mainColor.withOpacity(0.1):AppUI.orangeColor.withOpacity(0.1)
                  ),
                  child: CustomText(text: state=="2"?"running".tr():state=="5"?"completed".tr():state=="3"?"shipped".tr():"canceled".tr(),color: state=="7"?AppUI.errorColor:state=="completed"?AppUI.mainColor:AppUI.orangeColor,)),
            ],
          ),
          Row(
            children: [
              CustomText(text: "${order.totalRaw!.length>5?order.totalRaw!.substring(0,5):order.totalRaw} SAR  ",fontWeight: FontWeight.w100,color: AppUI.mainColor,),
              CustomText(text: ". ${order.dateAdded}",color: AppUI.greyColor,fontSize: 12,fontWeight: FontWeight.w100,),
            ],
          ),
          const SizedBox(height: 15,),
          if(state == "2" || state == "3")
          CustomButton(text: "trackOrder".tr(),width: AppUtil.responsiveWidth(context)*0.9,onPressed: (){
            AppUtil.mainNavigator(context, TrackOrderScreen(order: order,state: state));
          },),
          if(state == "5")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(text: "reOrder".tr(),width: AppUtil.responsiveWidth(context)*0.4,onPressed: (){
                  AppUtil.mainNavigator(context, OrderDetailsScreen(orderId: order.orderId!,products: order.products!));
                },),
                const SizedBox(width: 15,),
                CustomButton(text: "trackOrder".tr(),width: AppUtil.responsiveWidth(context)*0.4,onPressed: (){
                  AppUtil.mainNavigator(context, TrackOrderScreen(order: order,state: state));
                },),
              ],
            ),
          if(state == "7")
            CustomButton(text: "reOrder".tr(),width: AppUtil.responsiveWidth(context)*0.9,onPressed: (){
              AppUtil.mainNavigator(context, OrderDetailsScreen(orderId: order.orderId!,products: order.products!));
            },),


        ],
      ),
    );
  }
}
