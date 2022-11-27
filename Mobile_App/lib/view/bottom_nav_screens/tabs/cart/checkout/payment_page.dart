import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/layout/checkout/checkout_cubit.dart';
class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    cubit.paymentMethods();
    return BlocBuilder<CheckoutCubit,CheckoutStates>(
      buildWhen: (_,state) => state is PaymentChangeState || state is PaymentMethodsLoadingState || state is PaymentMethodsLoadedState || state is PaymentMethodsErrorState,
      builder: (context, state) {
        if(state is PaymentMethodsLoadingState){
          return const LoadingWidget();
        }
        if(state is PaymentMethodsErrorState){
          return const ErrorFetchWidget();
        }

        return Container(
          color: AppUI.whiteColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CustomCard(
                    //   onTap: (){
                    //     cubit.changePaymentState("cash");
                    //   },
                    //   elevation: 0,height: 120,width: 90,border: cubit.paymentState == "cash" ? AppUI.mainColor : AppUI.greyColor,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset("${AppUI.iconPath}cach.svg",color :cubit.paymentState == "cash" ? AppUI.mainColor : AppUI.greyColor),
                    //       const SizedBox(height: 10,),
                    //       CustomText(text: "cashOnDelivery".tr(),textAlign: TextAlign.center,color: cubit.paymentState == "cash" ? AppUI.mainColor : AppUI.greyColor,)
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(width: 20,),
                    CustomCard(
                      onTap: (){
                        cubit.changePaymentState("credit");
                        cubit.selectedPaymentMethod = cubit.paymentMethodsModel!.data!.paymentMethods![0];
                      },
                      elevation: 0,height: 120,width: 100,border: cubit.paymentState == "credit" ? AppUI.mainColor : AppUI.greyColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("${AppUI.iconPath}credit.svg",color :cubit.paymentState == "credit" ? AppUI.mainColor : AppUI.greyColor),
                          const SizedBox(height: 10,),
                          CustomText(text: "creditCard".tr(),textAlign: TextAlign.center,color: cubit.paymentState == "credit" ? AppUI.mainColor : AppUI.greyColor,)
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
                    CustomCard(
                      onTap: (){
                        cubit.changePaymentState("apple");
                        cubit.selectedPaymentMethod = cubit.paymentMethodsModel!.data!.paymentMethods![1];
                      },
                      elevation: 0,height: 120,width: 100,border: cubit.paymentState == "apple" ? AppUI.mainColor : AppUI.greyColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("${AppUI.iconPath}apple.svg",color :cubit.paymentState == "apple" ? AppUI.mainColor : AppUI.greyColor),
                          const SizedBox(height: 10,),
                          CustomText(text: "applePay".tr(),textAlign: TextAlign.center,color: cubit.paymentState == "apple" ? AppUI.mainColor : AppUI.greyColor,)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                BlocBuilder<CheckoutCubit,CheckoutStates>(
                    buildWhen: (_,state) => state is CreditCardChangeState || state is PaymentChangeState,
                    builder: (context, state) {
                      if(cubit.paymentState == "apple"){
                        return const SizedBox();
                      }
                      return Form(
                        key: cubit.paymentFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCreditCard(cardHolder: cubit.cardHolderController.text, cardNum: cubit.cardNumberController.text, expiryDate: cubit.expiryDateController.text, cvv: cubit.cvvController.text),
                            const SizedBox(height: 20,),
                            CustomText(text: "NameOfCardholder".tr(),color: AppUI.greyColor,),
                            const SizedBox(height: 4,),
                            CustomInput(controller: cubit.cardHolderController, textInputType: TextInputType.text,onChange: (v){
                              cubit.emit(CreditCardChangeState());
                            },),
                            const SizedBox(height: 10,),
                            CustomText(text: "cardNumber".tr(),color: AppUI.greyColor,),
                            const SizedBox(height: 4,),
                            CustomInput(controller: cubit.cardNumberController, textInputType: TextInputType.number,onChange: (v){
                              cubit.emit(CreditCardChangeState());
                            },),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: "expiryDate".tr(),color: AppUI.greyColor,),
                                      const SizedBox(height: 4,),
                                      CustomInput(controller: cubit.expiryDateController,hint: "12/28",maxLength: 5, textInputType: TextInputType.text,onChange: (v){
                                        if(v.length==2){
                                          cubit.expiryDateController.text = "/${cubit.expiryDateController.text}";
                                        }
                                        cubit.emit(CreditCardChangeState());
                                      },),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: "CVV".tr(),color: AppUI.greyColor,),
                                      const SizedBox(height: 4,),
                                      CustomInput(controller: cubit.cvvController,maxLength: 3, textInputType: TextInputType.text,onChange: (v){
                                        cubit.emit(CreditCardChangeState());
                                      },),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                ),

                const SizedBox(height: 30,),
                BlocBuilder<CheckoutCubit,CheckoutStates>(
                    buildWhen: (_,state) => state is SavePaymentMethodLoadingState || state is SavePaymentMethodLoadedState,
                    builder: (context, state) {
                      if(state is SavePaymentMethodLoadingState){
                        return const LoadingWidget();
                      }
                      return CustomButton(text: "next".tr(),width: double.infinity,onPressed: (){
                        if(cubit.paymentState != "apple"){
                          if(cubit.paymentFormKey.currentState!.validate()){
                            cubit.savePaymentMethod(context,cubit.paymentState);
                          }
                        }else{
                          cubit.savePaymentMethod(context,cubit.paymentState);
                        }
                      },);
                    }
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        );
      }
    );
  }
}
