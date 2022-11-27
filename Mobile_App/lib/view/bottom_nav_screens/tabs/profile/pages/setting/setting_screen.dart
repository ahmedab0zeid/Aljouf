import 'package:aljouf/shared/components.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/setting/static_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utilities/app_ui.dart';
import '../../../../../../utilities/app_util.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "settings".tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "privacyPolicy".tr(),id: "3"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}privacy.svg"),
              ),
              title: CustomText(text: "privacyPolicy".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(
                height: 10,
                child: Divider(thickness: 0.6,)),

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "termsAndConditions".tr(),id: "5"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}terms.svg"),
              ),
              title: CustomText(text: "termsAndConditions".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(
                height: 10,
                child: Divider(thickness: 0.6,)),

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "contactUS".tr(),id: "5"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}contact.svg"),
              ),
              title: CustomText(text: "contactUS".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(
                height: 10,
                child: Divider(thickness: 0.6,)),

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "returnsAndReplacement".tr(),id: "8"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}logout.svg"),
              ),
              title: CustomText(text: "returnsAndReplacement".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(
                height: 10,
                child: Divider(thickness: 0.6,)),

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "paymentAndDelivery".tr(),id: "9"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}delivery.svg"),
              ),
              title: CustomText(text: "paymentAndDelivery".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),

            const SizedBox(
                height: 10,
                child: Divider(thickness: 0.6,)),

            ListTile(
              onTap: (){
                AppUtil.mainNavigator(context, StaticPage(title: "aboutUS".tr(),id: "4"));
              },
              contentPadding: const EdgeInsets.all(0),
              leading: CustomCard(
                height: 40,width: 40,radius: 13,elevation: 0,color: AppUI.greyColor.withOpacity(0.1),padding: 0,
                child: SvgPicture.asset("${AppUI.iconPath}about.svg"),
              ),
              title: CustomText(text: "aboutUS".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
