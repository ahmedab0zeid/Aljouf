import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../bloc/layout/checkout/checkout_cubit.dart';
import '../../../../../bloc/layout/checkout/checkout_states.dart';
import '../../../../../shared/components.dart';
import '../../../../../utilities/app_ui.dart';
import '../../../../../utilities/app_util.dart';
import '../../profile/pages/addresses/addresses_screen.dart';

class ChooseAddressPage extends StatelessWidget {
  const ChooseAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomText(text: "shippingAddress".tr()),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<CheckoutCubit, CheckoutStates>(
            buildWhen: (_, state) => state is AddressesChangeState,
            builder: (context, state) {
              if (cubit.selectedAddress == null) {
                return Container(
                  color: AppUI.whiteColor,
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      AppUtil.mainNavigator(
                          context,
                          const AddressesScreen(
                            from: "checkoutShipping",
                          ));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset("${AppUI.iconPath}location.svg"),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "chooseShippingAddress".tr(),
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              AppUtil.mainNavigator(
                                  context,
                                  const AddressesScreen(
                                    from: "checkoutShipping",
                                  ));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ))
                      ],
                    ),
                  ),
                );
              }
              return Container(
                color: AppUI.whiteColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                            "${AppUI.iconPath}location_address.svg"),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "addressDetails".tr(),
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () async {
                              await AppUtil.mainNavigator(context,
                                  const AddressesScreen(from: "checkoutShipping"));
                              if(cubit.checkBox){
                                cubit.selectedBillingAddress = cubit.selectedAddress;
                              }
                            },
                            child: CustomText(
                              text: "change".tr(),
                              color: AppUI.mainColor,
                              fontSize: 12,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      text: cubit.selectedAddress!.address1,
                      color: AppUI.blackColor,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomText(
                      text: cubit.selectedAddress!.address2,
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                  ],
                ),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<CheckoutCubit, CheckoutStates>(
            buildWhen: (_, state) => state is CheckBoxChangeState,
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  if(!cubit.checkBox && cubit.selectedAddress == null){
                    return AppUtil.errorToast(context, "selectShippingAddress".tr());
                  }
                  cubit.checkBox = !cubit.checkBox;
                  if(cubit.checkBox){
                    cubit.selectedBillingAddress = cubit.selectedAddress;
                  }
                  cubit.emit(CheckBoxChangeState());
                },
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      margin: EdgeInsets.only(
                          right: AppUtil.rtlDirection(context) ? 16 : 0,
                          left: AppUtil.rtlDirection(context) ? 0 : 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(width: 0.5, color: AppUI.mainColor),
                          color: cubit.checkBox ? AppUI.mainColor : null),
                      alignment: Alignment.center,
                      child: cubit.checkBox
                          ? Icon(
                              Icons.check,
                              color: AppUI.whiteColor,
                              size: 15,
                            )
                          : null,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomText(text: "makeBillingAddressAsShippingAddress".tr())
                  ],
                ),
              );
            }),
        BlocBuilder<CheckoutCubit, CheckoutStates>(
            buildWhen: (_, state) => state is CheckBoxChangeState,
            builder: (context, state) {
              if (cubit.checkBox) {
                return const SizedBox();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(text: "billingAddress".tr()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CheckoutCubit, CheckoutStates>(
                      buildWhen: (_, state) => state is AddressesChangeState,
                      builder: (context, state) {
                        if (cubit.selectedBillingAddress == null) {
                          return Container(
                            color: AppUI.whiteColor,
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                AppUtil.mainNavigator(
                                    context,
                                    const AddressesScreen(
                                      from: "checkoutBilling",
                                    ));
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "${AppUI.iconPath}location.svg"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    text: "chooseBillingAddress".tr(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        AppUtil.mainNavigator(
                                            context,
                                            const AddressesScreen(
                                              from: "checkoutBilling",
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(
                          color: AppUI.whiteColor,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "${AppUI.iconPath}location_address.svg"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    text: "addressDetails".tr(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        AppUtil.mainNavigator(
                                            context,
                                            const AddressesScreen(
                                                from: "checkoutBilling"));
                                      },
                                      child: CustomText(
                                        text: "change".tr(),
                                        color: AppUI.mainColor,
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomText(
                                text: cubit.selectedAddress!.address1,
                                color: AppUI.blackColor,
                                fontSize: 12,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              CustomText(
                                text: cubit.selectedAddress!.address2,
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              );
            }),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<CheckoutCubit,CheckoutStates>(
            buildWhen: (_,state) => state is SaveAddressLoadingState || state is SaveAddressLoadedState,
            builder: (context, state) {
              if(state is SaveAddressLoadingState){
                return const LoadingWidget();
              }
              return CustomButton(
                text: "next".tr(),
                width: double.infinity,
                onPressed: (){
                  if(cubit.selectedAddress == null){
                    return AppUtil.errorToast(context, "selectShippingAddresses".tr());
                  }
                  if(cubit.selectedBillingAddress == null){
                    return AppUtil.errorToast(context, "selectBillingAddress".tr());
                  }
                  cubit.saveShippingAddress(context);
                },
              );
            }
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
