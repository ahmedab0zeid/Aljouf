
import 'package:flutter/cupertino.dart';

import '../../../../../../shared/components.dart';
import '../../../../../../utilities/app_ui.dart';

class CustomCreditCard extends StatelessWidget {
  final String? cardHolder,cardNum,expiryDate,cvv;
  const CustomCreditCard({Key? key, this.cardHolder, this.cardNum, this.cvv, this.expiryDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset("${AppUI.imgPath}visa.png"),
        Positioned(
          right: 30,top: 30,
          child:  Image.asset("${AppUI.imgPath}visa_text.png",width: 60,),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: cardNum ?? "4343234543453454",fontSize: 22,color: AppUI.whiteColor,),
              const SizedBox(height: 20,),
              Row(
                children: [
                  CustomText(text: "Card Holder",fontSize: 12,fontWeight: FontWeight.w100,color: AppUI.whiteColor,),
                  const Spacer(),
                  CustomText(text: "Expire",fontSize: 12,fontWeight: FontWeight.w100,color: AppUI.whiteColor,),
                ],
              ),
              Row(
                children: [
                  CustomText(text: cardHolder??"ahmed mohamed".toUpperCase(),color: AppUI.whiteColor,),
                  const Spacer(),
                  CustomText(text: expiryDate??"03/22",color: AppUI.whiteColor,),
                ],
              ),

            ],
          ),
        )
      ],
    );
  }
}
