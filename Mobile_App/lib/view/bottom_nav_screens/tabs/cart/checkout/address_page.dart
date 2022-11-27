import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/models/checkout/addresses/cities_model.dart';
import 'package:aljouf/models/checkout/addresses/states_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/layout/checkout/checkout_cubit.dart';
import '../../../../../bloc/layout/profile/profile_states.dart';
import '../../../../../models/checkout/addresses/countries_model.dart';
import '../../../../../models/profile/addresses_model.dart';
class AddressPage extends StatelessWidget {
  final Addresses? address;
  const AddressPage({Key? key,this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    final profileCubit = ProfileCubit.get(context);
    if(profileCubit.profileModel == null){
      profileCubit.profile();
    }
    return Form(
      key: cubit.addAddressFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomText(text: "yourPersonalDetails".tr())
          ),
          Container(
            color: AppUI.whiteColor,
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ProfileCubit,ProfileStates>(
                buildWhen: (_,state) => state is ProfileLoadingState || state is ProfileLoadedState || state is ProfileErrorState,
                builder: (context, state) {
                  if(state is ProfileLoadingState){
                    return const LoadingWidget();
                  }

                  if(state is ProfileErrorState){
                    return const ErrorFetchWidget();
                  }
                  if(address==null) {
                    cubit.firstName.text =
                    profileCubit.profileModel!.data!.firstname!;
                    cubit.lastName.text =
                    profileCubit.profileModel!.data!.lastname!;
                    cubit.email.text = profileCubit.profileModel!.data!.email!;
                  }else{
                    cubit.firstName.text = address!.firstname!;
                    cubit.lastName.text = address!.lastname!;
                    cubit.selectedCountry = Country(countryId: int.parse(address!.countryId!.toString()),name: address!.country);
                    cubit.countryController.text = address!.country!;
                    cubit.selectedState = Zone(zoneId: int.parse(address!.zoneId!.toString()),name: address!.zone);
                    cubit.stateController.text = address!.zone!;
                    cubit.selectedCity = Cities(name: address!.city);
                    cubit.cityController.text = address!.city!;
                    cubit.address1.text = address!.address1!;
                    cubit.address2.text = address!.address2!;
                    cubit.postCode.text = address!.postcode!;
                  }
                  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "firstName".tr(),color: AppUI.greyColor,),
                    const SizedBox(height: 5,),
                    CustomInput(controller: cubit.firstName, textInputType: TextInputType.name),
                    const SizedBox(height: 15,),
                    CustomText(text: "lastName".tr(),color: AppUI.greyColor,),
                    const SizedBox(height: 5,),
                    CustomInput(controller: cubit.lastName, textInputType: TextInputType.name),
                    const SizedBox(height: 15,),
                    CustomText(text: "email".tr(),color: AppUI.greyColor,),
                    const SizedBox(height: 5,),
                    CustomInput(controller: cubit.email, textInputType: TextInputType.emailAddress),
                    const SizedBox(height: 15,),
                  ],
                );
              }
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomText(text: "shippingAddress".tr())
          ),
          Container(
            color: AppUI.whiteColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "country".tr(),color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                CustomInput(controller: cubit.countryController, textInputType: TextInputType.text,readOnly: true,suffixIcon: const Icon(Icons.keyboard_arrow_down),onTap: (){
                  AppUtil.dialog2(context, "country".tr(), List.generate(cubit.countriesModel!.data!.length, (index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            cubit.selectedCountry = cubit.countriesModel!.data![index];
                            cubit.countryController.text = AppUtil.rtlDirection(context)?cubit.countriesModel!.data![index].nameAr!:cubit.countriesModel!.data![index].name!;
                            cubit.states();
                            Navigator.of(context,rootNavigator: true).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomText(text: AppUtil.rtlDirection(context)?cubit.countriesModel!.data![index].nameAr:cubit.countriesModel!.data![index].name),
                          ),
                        ),
                        if(index!=cubit.countriesModel!.data!.length-1)
                        const Divider(),
                      ],
                    );
                  }));
                },),
                const SizedBox(height: 15,),
                CustomText(text: "state".tr(),color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                BlocBuilder<CheckoutCubit,CheckoutStates>(
                  buildWhen: (_,state) => state is StatesLoadingState || state is StatesLoadedState || state is StatesErrorState,
                  builder: (context, state) {
                    if(state is StatesLoadingState){
                      return const LoadingWidget();
                    }
                    return CustomInput(controller: cubit.stateController, textInputType: TextInputType.text,readOnly: true,suffixIcon: const Icon(Icons.keyboard_arrow_down),onTap: (){
                      if(cubit.selectedCountry==null){
                        return AppUtil.errorToast(context, "selectCountry".tr());
                      }else{
                        AppUtil.dialog2(context, "state".tr(), List.generate(cubit.statesModel!.data!.zone!.length, (index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.selectedState = cubit.statesModel!.data!.zone![index];
                                  cubit.stateController.text = AppUtil.rtlDirection(context)?cubit.statesModel!.data!.zone![index].nameAr!:cubit.statesModel!.data!.zone![index].name!;
                                  cubit.cities();
                                  Navigator.of(context,rootNavigator: true).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: CustomText(text: AppUtil.rtlDirection(context)?cubit.statesModel!.data!.zone![index].nameAr:cubit.statesModel!.data!.zone![index].name),
                                ),
                              ),
                              if(index!=cubit.statesModel!.data!.zone!.length-1)
                                const Divider(),
                            ],
                          );
                        }));
                      }
                    },);
                  }
                ),
                const SizedBox(height: 15,),
                CustomText(text: "city".tr(),color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                BlocBuilder<CheckoutCubit,CheckoutStates>(
                    buildWhen: (_,state) => state is CitiesLoadingState || state is CitiesLoadedState || state is CitiesErrorState,
                    builder: (context, state) {
                      if(state is CitiesLoadingState){
                        return const LoadingWidget();
                      }
                      return CustomInput(controller: cubit.cityController, textInputType: TextInputType.text,readOnly: true,suffixIcon: const Icon(Icons.keyboard_arrow_down),onTap: (){
                        if(cubit.selectedState==null){
                          return AppUtil.errorToast(context, "selectState".tr());
                        }else{
                          AppUtil.dialog2(context, "state".tr(), List.generate(cubit.citiesModel!.data!.cities!.length, (index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    cubit.selectedCity = cubit.citiesModel!.data!.cities![index];
                                    cubit.cityController.text = AppUtil.rtlDirection(context)?cubit.citiesModel!.data!.cities![index].nameAr!:cubit.citiesModel!.data!.cities![index].name!;
                                    Navigator.of(context,rootNavigator: true).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: CustomText(text:  AppUtil.rtlDirection(context)?cubit.citiesModel!.data!.cities![index].nameAr:cubit.citiesModel!.data!.cities![index].name),
                                  ),
                                ),
                                if(index!=cubit.citiesModel!.data!.cities!.length-1)
                                  const Divider(),
                              ],
                            );
                          }));
                        }
                      },);
                  }
                ),
                const SizedBox(height: 15,),
                CustomText(text: "address".tr(),color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                CustomInput(controller: cubit.address1, textInputType: TextInputType.text),
                const SizedBox(height: 15,),
                CustomText(text: "${"address".tr()} 2",color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                CustomInput(controller: cubit.address2, textInputType: TextInputType.text),
                const SizedBox(height: 15,),
                CustomText(text: "postCode".tr(),color: AppUI.greyColor,),
                const SizedBox(height: 5,),
                CustomInput(controller: cubit.postCode, textInputType: TextInputType.text),

              ],
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<ProfileCubit,ProfileStates>(
                buildWhen: (_,state) => state is AddAddressesLoadingState || state is AddAddressesLoadedState,
                builder: (context, state) {
                  if(state is AddAddressesLoadingState){
                    return const LoadingWidget();
                  }
                  return CustomButton(text: "save".tr(),width: double.infinity,onPressed: () async {
                  // cubit.changeCheckoutState(1);
                  if(cubit.addAddressFormKey.currentState!.validate()){
                    Map<String,String> formData = {
                      "firstname": cubit.firstName.text,
                      "lastname": cubit.lastName.text,
                      "city": cubit.selectedCity!.name!,
                      "address_1": cubit.address1.text,
                      "address_2": cubit.address2.text,
                      "country_id": cubit.selectedCountry!.countryId!.toString(),
                      "email": cubit.email.text,
                      "postcode": cubit.postCode.text,
                      "zone_id": cubit.selectedState!.zoneId.toString(),
                      "company": "company",
                      "default": "0"
                    };
                    Map<String,dynamic> response;
                    if(address==null) {
                     response = await profileCubit.addAddress(formData: formData);
                    }else{
                      response = await profileCubit.editAddress(formData: formData,id: address!.addressId);
                    }
                    if(response['success'] == 1){
                      cubit.cityController.text = '';
                      cubit.selectedCity = null;
                      cubit.stateController.text = '';
                      cubit.selectedState = null;
                      cubit.countryController.text = '';
                      cubit.selectedCountry = null;
                      cubit.address1.text = '';
                      cubit.address2.text = '';
                      cubit.postCode.text = '';
                      Navigator.pop(context);
                      AppUtil.successToast(context, address==null?"AddressAdded".tr():"addressEdited".tr());
                    }else{
                      AppUtil.errorToast(context, response['error'][0]);
                    }
                  }
                },);
              }
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
