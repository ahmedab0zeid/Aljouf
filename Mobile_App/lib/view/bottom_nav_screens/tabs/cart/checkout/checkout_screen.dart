import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/cart/checkout/payment_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/layout/checkout/checkout_cubit.dart';
import '../../../../../bloc/layout/checkout/checkout_states.dart';
import 'address_page.dart';
import 'choose_address_page.dart';
import 'delivery_page.dart';
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return WillPopScope(
      onWillPop: () async{
        if(CheckoutCubit.get(context).checkoutState == 0){
          return true;
        }else{
          cubit.changeCheckoutState(--CheckoutCubit.get(context).checkoutState);
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: AppUI.checkoutBackground,
        appBar: customAppBar(title: "checkout".tr()),
        body: BlocBuilder<CheckoutCubit,CheckoutStates>(
          buildWhen: (_,state)=> state is CheckoutChangeState,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    height: 120,
                    color: AppUI.whiteColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                cubit.changeCheckoutState(0);
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: cubit.checkoutState == 0 ? AppUI.mainColor : cubit.checkoutState > 0 ?AppUI.mainColor: AppUI.shimmerColor,
                                child: CircleAvatar(
                                  backgroundColor: cubit.checkoutState==0 ? AppUI.whiteColor : cubit.checkoutState > 0 ? AppUI.mainColor : AppUI.shimmerColor,
                                  radius: 15,
                                  child: cubit.checkoutState > 0 ? Icon(Icons.check,color: AppUI.whiteColor,) : CircleAvatar(
                                    radius: 7,
                                    backgroundColor: cubit.checkoutState ==0 ? AppUI.mainColor:AppUI.shimmerColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,width: AppUtil.responsiveWidth(context)*0.2,color: AppUI.mainColor,
                            ),
                            InkWell(
                              onTap: (){
                                // cubit.changeCheckoutState(1);
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: cubit.checkoutState==1 ? AppUI.mainColor : cubit.checkoutState>1 ? AppUI.mainColor : AppUI.shimmerColor,
                                child: CircleAvatar(
                                  backgroundColor: cubit.checkoutState==1 ? AppUI.whiteColor:cubit.checkoutState>1 ? AppUI.mainColor : AppUI.shimmerColor,
                                  radius: 15,
                                  child: cubit.checkoutState > 1 ? Icon(Icons.check,color: AppUI.whiteColor,) : CircleAvatar(
                                    radius: 7,
                                    backgroundColor: cubit.checkoutState == 1 ? AppUI.mainColor:AppUI.shimmerColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,width: AppUtil.responsiveWidth(context)*0.2,color: AppUI.mainColor,
                            ),
                            InkWell(
                              onTap: (){
                                // cubit.changeCheckoutState(2);
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: cubit.checkoutState==2 ? AppUI.mainColor:cubit.checkoutState>2 ? AppUI.mainColor:AppUI.shimmerColor,
                                child: CircleAvatar(
                                  backgroundColor: cubit.checkoutState==2 ? AppUI.whiteColor : cubit.checkoutState>2 ? AppUI.mainColor : AppUI.shimmerColor,
                                  radius: 15,
                                  child: cubit.checkoutState > 2 ? Icon(Icons.check,color: AppUI.whiteColor,) : CircleAvatar(
                                    radius: 7,
                                    backgroundColor: cubit.checkoutState == 2 ? AppUI.mainColor:AppUI.shimmerColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, right: 18,left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: "address".tr()),
                                ],
                              )),Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: "delivery".tr()),
                                ],
                              )),Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: "payment".tr()),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  cubit.checkoutState == 0 ? ChooseAddressPage() : cubit.checkoutState == 1 ? const DeliveryPage() : const PaymentPage()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
