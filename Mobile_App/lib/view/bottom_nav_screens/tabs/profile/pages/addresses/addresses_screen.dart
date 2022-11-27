import 'package:aljouf/bloc/layout/checkout/checkout_cubit.dart';
import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'add_address_screen.dart';
class AddressesScreen extends StatefulWidget {
  final String? from;
  const AddressesScreen({Key? key, this.from}) : super(key: key);

  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    final checkoutCubit = CheckoutCubit.get(context);
    if(cubit.addressesModel == null){
      cubit.addresses();
    }
    return Scaffold(
      appBar: customAppBar(title: "addresses".tr(),actions: [IconButton(onPressed: (){
        AppUtil.mainNavigator(context, const AddAddressScreen());
      }, icon: const Icon(Icons.add,color: Colors.black,size: 30,))]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileCubit,ProfileStates>(
          buildWhen: (_,state) => state is AddressesLoadingState || state is AddressesLoadedState || state is AddressesErrorState || state is AddressesEmptyState,
          builder: (context, state) {
            if(state is AddressesLoadingState){
              return const LoadingWidget();
            }
            if(state is AddressesEmptyState){
              return const EmptyWidget();
            }

            if(state is AddressesErrorState){
              return const ErrorFetchWidget();
            }

            return ListView(
              children: List.generate(cubit.addressesModel!.data!.addresses!.length, (index) {
                return InkWell(
                  onTap: widget.from==null?null:(){
                    if(widget.from == "checkoutShipping") {
                      checkoutCubit.selectedAddress = cubit.addressesModel!.data!.addresses![index];
                    }else{
                      checkoutCubit.selectedBillingAddress = cubit.addressesModel!.data!.addresses![index];
                    }
                    checkoutCubit.emit(AddressesChangeState());
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "${cubit.addressesModel!.data!.addresses![index].firstname} ${cubit.addressesModel!.data!.addresses![index].lastname}",color: AppUI.blackColor,fontWeight: FontWeight.w600,),
                              const SizedBox(height: 10,),
                              CustomText(text: cubit.addressesModel!.data!.addresses![index].country,color: AppUI.greyColor,),
                              const SizedBox(height: 10,),
                              CustomText(text: cubit.addressesModel!.data!.addresses![index].address1,color: AppUI.greyColor.withOpacity(0.7),),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  AppUtil.mainNavigator(context, AddAddressScreen(address: cubit.addressesModel!.data!.addresses![index]));
                                },
                                  child: SvgPicture.asset("${AppUI.iconPath}edit_address.svg")),
                              const SizedBox(width: 10,),
                              InkWell(
                                  onTap: () async {
                                    AppUtil.dialog2(context, '', const[
                                      LoadingWidget(),
                                      SizedBox(height: 30,)
                                    ],backgroundColor: Colors.transparent,barrierDismissible: false);
                                    await cubit.deleteAddress(cubit.addressesModel!.data!.addresses![index].addressId);
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset("${AppUI.iconPath}delete_address.svg")),
                            ],
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                );
              }),
            );
          }
        ),
      ),
    );
  }
}
