import 'package:aljouf/bloc/layout/orders/orders_cubit.dart';
import 'package:aljouf/models/profile/orders_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utilities/app_ui.dart';
import '../../../../../../utilities/app_util.dart';
class OrderDetailsScreen extends StatefulWidget {
  final List<Products> products;
  final String orderId;
  const OrderDetailsScreen({Key? key, required this.products, required this.orderId}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = OrdersCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: "products".tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: List.generate(widget.products.length, (index) {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(imageUrl: widget.products[index].image!,fit: BoxFit.fill,height: 70,width: 70,placeholder: (context, url) => Image.asset("${AppUI.imgPath}productJouf.png",height: 70,width: 70,),
                      errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}productJouf.png",height: 70,width: 70,),
                    ),
                    const SizedBox(height: 5,),
                    CustomText(text: "#${widget.products[index].productId}  . ${widget.products[index].quantity} ${"items".tr()}",color: AppUI.greyColor,fontSize: 12,fontWeight: FontWeight.w100,),
                    const SizedBox(height: 5,),
                    SizedBox(
                        width: AppUtil.responsiveWidth(context)*0.6,
                        child: CustomText(text: widget.products[index].name,fontSize: 16,fontWeight: FontWeight.w500,)),
                    const SizedBox(height: 5,),
                    if(index!=widget.products.length-1)
                      const Divider()
                  ],
                ),
                CustomButton(text: "reOrder".tr(),width: AppUtil.responsiveWidth(context)*0.3,height: 45,radius: 9,onPressed: () async {
                  AppUtil.dialog2(context, "", [
                    const LoadingWidget(),
                    const SizedBox(height: 30,),
                  ],backgroundColor: Colors.transparent,barrierDismissible: false);
                  await cubit.reOrders(widget.orderId, widget.products[index].productId,context);
                },)
              ],
            );
          }),
        ),
      ),
    );
  }
}
