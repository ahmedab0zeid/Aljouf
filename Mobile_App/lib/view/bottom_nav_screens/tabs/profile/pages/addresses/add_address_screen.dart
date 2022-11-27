import 'package:aljouf/models/profile/addresses_model.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/cart/checkout/address_page.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/addresses/select_address_from_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AddAddressScreen extends StatefulWidget {
  final Addresses? address;
  const AddAddressScreen({Key? key, this.address}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: widget.address==null?"addNewAddress".tr():"editAddress".tr(),actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: (){
              AppUtil.mainNavigator(context, const SelectAddressFromMap());
            },
              child: SvgPicture.asset("${AppUI.iconPath}location_address.svg")),
        )
      ]),
      body: SingleChildScrollView(child: Container(color: AppUI.shimmerColor.withOpacity(0.2),child: AddressPage(address: widget.address))),
    );
  }
}
