import 'package:aljouf/models/profile/orders_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class TrackOrderScreen extends StatefulWidget {
  final Data order;
  final String? state;
  const TrackOrderScreen({Key? key, required this.order, this.state}) : super(key: key);

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "${"orderNum".tr()}: #${widget.order.orderId}"),
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset("${AppUI.imgPath}track_map.png"),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: AppUI.whiteColor,
                  padding: const EdgeInsets.only(top: 150),
                  child: Column(
                    children: [
                      CustomText(text: "orderStatus".tr()),
                      const SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: AppUI.mainColor,
                                  child: Icon(Icons.check,color: AppUI.whiteColor,size: 16,),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 3,
                                  width: AppUtil.responsiveWidth(context)*0.27,
                                  color: AppUI.mainColor,
                                ),
                                const SizedBox(height: 10,),
                                CustomText(text: "processing".tr(),color: AppUI.mainColor,)
                              ],
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: widget.state == "5" || widget.state == "3"?AppUI.mainColor:AppUI.whiteColor,
                                  child: Icon(Icons.check,color: AppUI.whiteColor,size: 16,),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 3,
                                  width: AppUtil.responsiveWidth(context)*0.27,
                                  color: widget.state == "5" || widget.state == "3"?AppUI.mainColor:AppUI.mainColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 10,),
                                CustomText(text: "shipped".tr(),color: AppUI.mainColor,)
                              ],
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: widget.state == "5"?AppUI.mainColor:AppUI.whiteColor,
                                  child: Icon(Icons.check,color: AppUI.whiteColor,size: 16,),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 3,
                                  width: AppUtil.responsiveWidth(context)*0.27,
                                  color: widget.state == "5"?AppUI.mainColor:AppUI.mainColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 10,),
                                CustomText(text: "completed".tr(),color: AppUI.mainColor,)
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 105,
                backgroundColor: AppUI.whiteColor,
                child: CircularPercentIndicator(
                  radius: 180.0,
                  lineWidth: 15.0,
                  percent: 1/3,
                  center: Text(widget.order.status.toString()),
                  backgroundColor: AppUI.mainColor.withOpacity(0.2),
                  progressColor: AppUI.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
