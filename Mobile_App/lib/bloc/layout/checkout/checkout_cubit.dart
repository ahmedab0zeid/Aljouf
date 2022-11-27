import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/checkout/checkout_states.dart';
import 'package:aljouf/models/checkout/addresses/cities_model.dart';
import 'package:aljouf/models/checkout/addresses/countries_model.dart';
import 'package:aljouf/models/checkout/addresses/payment_methods.dart';
import 'package:aljouf/models/checkout/addresses/states_model.dart';
import 'package:aljouf/models/checkout/shipping_methods.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/orders/my_orders_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

import '../../../models/profile/addresses_model.dart';
import '../../../repositories/checkout_repository.dart';
import '../../../shared/components.dart';

class CheckoutCubit extends Cubit<CheckoutStates>{

  CheckoutCubit(): super(CheckoutInitState());
  static CheckoutCubit get(context) => BlocProvider.of(context);

  int checkoutState = 0;
  changeCheckoutState(state){
    checkoutState = state;
    emit(CheckoutChangeState());
  }
  // address page
  var addAddressFormKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var address1 = TextEditingController();
  var address2 = TextEditingController();
  var postCode = TextEditingController();
  var paymentFormKey = GlobalKey<FormState>();
  bool checkBox = false;
  // payment page
  String paymentState = "credit";
  changePaymentState(state){
    paymentState = state;
    emit(PaymentChangeState());
  }

  Addresses? selectedAddress;
  Addresses? selectedBillingAddress;


  CountriesModel? countriesModel;
  Country? selectedCountry;
  countries() async {
    emit(CountriesLoadingState());
    try {
      Map<String,dynamic> response = await CheckoutRepository.countries();
      countriesModel = CountriesModel.fromJson(response);
      emit(CountriesLoadedState());
    } catch (e) {
      emit(CountriesErrorState());
      return Future.error(e);
    }
  }

  StatesModel? statesModel;
  Zone? selectedState;
  states() async {
    emit(StatesLoadingState());
    try {
      Map<String,dynamic> response = await CheckoutRepository.states(selectedCountry!.countryId);
      statesModel = StatesModel.fromJson(response);
      emit(StatesLoadedState());
    } catch (e) {
      emit(StatesErrorState());
      return Future.error(e);
    }
  }

  CitiesModel? citiesModel;
  Cities? selectedCity;
  cities() async {
    emit(CitiesLoadingState());
    try {
      Map<String,dynamic> response = await CheckoutRepository.cities(selectedState!.zoneId);
      citiesModel = CitiesModel.fromJson(response);
      emit(CitiesLoadedState());
    } catch (e) {
      emit(CitiesErrorState());
      return Future.error(e);
    }
  }

  saveShippingAddress(context) async {
    emit(SaveAddressLoadingState());
    Map<String,String> formData = {
      "firstname": selectedAddress!.firstname!,
      "lastname": selectedAddress!.lastname!,
      "city": selectedAddress!.city!,
      "address_1": selectedAddress!.address1!,
      "address_2": selectedAddress!.address2!,
      "country_id": selectedAddress!.countryId!.toString(),
      "postcode": selectedAddress!.postcode!,
      "zone_id": selectedAddress!.zoneId!.toString(),
      "company": selectedAddress!.company!,
      "default": "0"
    };
    try {
      Map<String,dynamic> response = await CheckoutRepository.saveShippingAddress(formData);
      if(response['success'] == 1){
        await saveBillingAddress();
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
      emit(SaveAddressLoadedState());
    } catch (e) {
      emit(SaveAddressLoadedState());
      return Future.error(e);
    }
  }


  saveBillingAddress() async {
    Map<String,String> formData = {
      "firstname": selectedBillingAddress!.firstname!,
      "lastname": selectedBillingAddress!.lastname!,
      "email": selectedBillingAddress!.email??"m@m.com",
      "city": selectedBillingAddress!.city!,
      "address_1": selectedBillingAddress!.address1!,
      "address_2": selectedBillingAddress!.address2!,
      "country_id": selectedBillingAddress!.countryId!.toString(),
      "postcode": selectedBillingAddress!.postcode!,
      "zone_id": selectedBillingAddress!.zoneId!.toString(),
      "company": selectedBillingAddress!.company!,
      "default": "0"
    };
    try {
      Map<String,dynamic> response = await CheckoutRepository.saveBillingAddress(formData);
      if(response['success'] == 1){
        changeCheckoutState(1);
      }
    } catch (e) {
      return Future.error(e);
    }
  }


  ShippingMethodesModel? shippingMethodsModel;
  int shippingMethodsGroupValue = 0;
  shippingMethods() async {
    emit(ShippingMethodsLoadingState());
    try {
      Map<String,dynamic> response = await CheckoutRepository.shippingMethods();
      shippingMethodsModel = ShippingMethodesModel.fromJson(response);
      emit(ShippingMethodsLoadedState());
    } catch (e) {
      emit(ShippingMethodsErrorState());
      return Future.error(e);
    }
  }

  PaymentMethodesModel? paymentMethodsModel;
  PaymentMethods? selectedPaymentMethod;
  paymentMethods() async {
    emit(PaymentMethodsLoadingState());
    try {
      Map<String,dynamic> response = await CheckoutRepository.paymentMethods();
      paymentMethodsModel = PaymentMethodesModel.fromJson(response);
      emit(PaymentMethodsLoadedState());
      selectedPaymentMethod = paymentMethodsModel!.data!.paymentMethods![0];
    } catch (e) {
      emit(PaymentMethodsErrorState());
      return Future.error(e);
    }
  }

  saveShippingMethod(context) async {
    emit(SaveShippingMethodLoadingState());
    Map<String,String> formData = {
      "shipping_method": shippingMethodsModel!.data!.shippingMethods![shippingMethodsGroupValue].quote![0].code!.toString(),
      "comment": "comment"
    };
    try {
      Map<String,dynamic> response = await CheckoutRepository.saveShippingMethods(formData);
      if(response['success'] == 1){
        changeCheckoutState(2);
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
      emit(SaveShippingMethodLoadedState());
    } catch (e) {
      emit(SaveShippingMethodLoadedState());
      return Future.error(e);
    }
  }

  var cardHolderController = TextEditingController();
  var cardNumberController = TextEditingController();
  var expiryDateController = TextEditingController();
  var cvvController = TextEditingController();

  savePaymentMethod(context, String paymentState) async {
    emit(SavePaymentMethodLoadingState());
    Map<String,String> formData = {
      "payment_method": selectedPaymentMethod!.code!,
      "agree": "1",
      "comment": "comment"
    };
    try {
      Map<String,dynamic> response = await CheckoutRepository.savePaymentMethods(formData);
      if(response['success'] == 1){
        if(paymentState == "apple"){
          payWithPayTaps(context);
        }else{
          await payWithPayfort(context);
        }

      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
      emit(SavePaymentMethodLoadedState());
    } catch (e) {
      emit(SavePaymentMethodLoadedState());
      return Future.error(e);
    }
  }

  payWithPayTaps(context) async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "profile id",
        serverKey: "your server key",
        clientKey: "your client key",
        cartId: "cart id",
        cartDescription: "cart desc",
        merchantName: "merchant name",
        screentTitle: "Pay with Card",
        locale: PaymentSdkLocale.EN, //PaymentSdkLocale.EN or PaymentSdkLocale.DEFAULT
        amount: CategoriesCubit.get(context).total,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        merchantApplePayIndentifier: "merchant.com.bundleID",
        linkBillingNameWithCardHolderName: true
    );
    var theme = IOSThemeConfigurations();
    theme.logoImage = "${AppUI.imgPath}logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.simplifyApplePayValidation = true;
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) async {
      if (event["status"] == "success") {
        await confirmOrder(context);
        var transactionDetails = event["data"];
        print(transactionDetails);
      } else if (event["status"] == "error") {
        // Handle error here.
      } else if (event["status"] == "event") {
        // Handle events here.
      }
    });
  }

  payWithPayfort(context) async {
    Map formData = {
      "command": "CAPTURE",
      "access_code": "zx0IPmPy5jp1vAz8Kpg7",
      "merchant_identifier": "CycHZxVj",
      "merchant_reference": "XYZ9239-yu898",
      "amount": CategoriesCubit.get(context).total.toString(),
      "currency": "AED",
      "language": "en",
      "fort_id": "149295435400084008",
      "signature": "7cad05f0212ed933c9a5d5dffa31661acf2c827a",
      "order_description": "iPhone 6-S",
      "card_holder_name": cardHolderController.text,
      "expiry_date": expiryDateController.text,
      "card_number": cardNumberController.text.trim(),
      "cvv": cvvController.text
    };
    int response = await CheckoutRepository.payWithPayfort(formData);
    if (response == 200) {
      await confirmOrder(context);
    }
  }

  confirmOrder(context) async {
    try {
      Map<String,dynamic> response = await CheckoutRepository.confirmOrder();
      if(response['success'] == 1){
        await clearSessions(context);
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  clearSessions(context) async {
    try {
      Map<String,dynamic> response = await CheckoutRepository.clearSessions();
      if(response['success'] == 1){
        await CategoriesCubit.get(context).cart();
        AppUtil.dialog2(context, "", [
          Image.asset("${AppUI.imgPath}order_success.png",height: 80,),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "orderSent".tr(),fontWeight: FontWeight.w600,fontSize: 16,),
            ],
          ),
          const SizedBox(height: 15,),
          CustomButton(text: "continueShopping".tr(),onPressed: (){
            Navigator.of(context,rootNavigator: true).pop();
            AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
          },),
          const SizedBox(height: 10,),
          CustomButton(text: "goToOrder".tr(),color: AppUI.whiteColor,borderColor: AppUI.mainColor.withOpacity(0.3),textColor: AppUI.blackColor,onPressed: (){
            Navigator.of(context,rootNavigator: true).pop();
            AppUtil.mainNavigator(context, const MyOrdersScreen());
          },),
          const SizedBox(height: 30,),
        ]);
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
    } catch (e) {
      return Future.error(e);
    }
  }


}