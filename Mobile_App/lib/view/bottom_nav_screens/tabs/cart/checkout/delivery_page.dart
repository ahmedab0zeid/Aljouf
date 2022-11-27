import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/layout/checkout/checkout_cubit.dart';
import '../../../../../shared/components.dart';
class DeliveryPage extends StatelessWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    cubit.shippingMethods();
    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(
          color: AppUI.whiteColor,
          child: BlocBuilder<CheckoutCubit,CheckoutStates>(
            buildWhen: (_,state) => state is ShippingMethodsLoadingState || state is ShippingMethodsLoadedState || state is ShippingMethodsErrorState,
            builder: (context, state) {
              if(state is ShippingMethodsLoadingState){
                return const LoadingWidget();
              }
              if(state is ShippingMethodsErrorState){
                return const ErrorFetchWidget();
              }
              return Column(
                children: List.generate(cubit.shippingMethodsModel!.data!.shippingMethods!.length, (index) {
                  return Row(
                    children: [
                      Radio(value: index, groupValue: cubit.shippingMethodsGroupValue, onChanged: (int? v){
                        cubit.shippingMethodsGroupValue = v!;
                        cubit.emit(ShippingMethodsLoadedState());
                      },activeColor: AppUI.mainColor,),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: cubit.shippingMethodsModel!.data!.shippingMethods![index].quote![0].title),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              CustomText(text: "${"cost".tr()}: ${cubit.shippingMethodsModel!.data!.shippingMethods![index].quote![0].cost} SR",fontSize: 12,color: AppUI.greyColor,),
                              const SizedBox(width: 30,),
                              CustomText(text: "${"tax".tr()}: ${cubit.shippingMethodsModel!.data!.shippingMethods![index].quote![0].taxClassId} SR",fontSize: 12,color: AppUI.greyColor),
                            ],
                          )
                        ],
                      )
                    ],
                  );
                }),
              );
            }
          ),
        ),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CheckoutCubit,CheckoutStates>(
              buildWhen: (_,state) => state is SaveShippingMethodLoadingState || state is SaveShippingMethodLoadedState,
              builder: (context, state) {
                if(state is SaveShippingMethodLoadingState){
                  return const LoadingWidget();
                }
                return CustomButton(text: "next".tr(),width: double.infinity,onPressed: (){
                cubit.saveShippingMethod(context);
              },);
            }
          ),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
