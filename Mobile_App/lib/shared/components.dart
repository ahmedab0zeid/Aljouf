
import 'dart:math';
import 'dart:ui' as ui;
import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/models/home/products_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utilities/app_ui.dart';
import '../utilities/app_util.dart';
import '../view/bottom_nav_screens/tabs/home/products/product_details/product_details_screen.dart';
import 'dart:math' as math;

class GradientCircularProgressIndicator extends StatelessWidget {
  final double? radius;
  final List<Color>? gradientColors;
  final double strokeWidth;

  const GradientCircularProgressIndicator({Key? key,
    @required this.radius,
    @required this.gradientColors,
    this.strokeWidth = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius!),
      painter: GradientCircularProgressPainter(
        radius: radius!,
        gradientColors: gradientColors!,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    @required this.radius,
    @required this.gradientColors,
    @required this.strokeWidth,
  });
  final double? radius;
  final List<Color>? gradientColors;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius!);
    double offset = strokeWidth! / 2;
    Rect rect = Offset(offset, offset) &
    Size(size.width - strokeWidth!, size.height - strokeWidth!);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!;
    paint.shader =
        SweepGradient(colors: gradientColors!, startAngle: 0.0, endAngle: 2 * pi)
            .createShader(rect);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


AppBar customAppBar ({required title,Widget? leading,List<Widget>? actions,int elevation = 0,Widget? bottomChild,Color? backgroundColor,bottomChildHeight,leadingWidth,toolbarHeight,textColor}){
  return AppBar(
    backgroundColor: backgroundColor??AppUI.whiteColor,
    elevation: double.parse(elevation.toString()),
    toolbarHeight: toolbarHeight,
    title: title is Widget? title : CustomText(text: title, fontSize: 18.0,color: textColor??AppUI.blackColor,fontWeight: FontWeight.w500,),
    centerTitle: true,
    leading: leading,
    leadingWidth: leadingWidth??110,
    actions: actions,
    bottom: bottomChild==null?null:PreferredSize(preferredSize: Size.fromHeight(bottomChildHeight??120),child: bottomChild,),
  );
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  const CustomAppBar({Key? key,required this.title,this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
      ),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
          color: AppUI.whiteColor,
        ),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(!AppUtil.rtlDirection(context)?Icons.arrow_forward_ios:Icons.arrow_back_ios,color: AppUI.blackColor,size: 19,)),
              CustomText(text: title,fontSize: 18,fontWeight: FontWeight.w500,),
              leading?? const SizedBox(width: 20,)
            ],
          ),
        ),
      ),
    );
  }
}


class CustomText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  const CustomText({Key? key,@required this.text,this.fontSize = 14,this.textAlign,this.fontWeight = FontWeight.w400,this.color,this.textDecoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text??"",textAlign: textAlign==null?AppUtil.rtlDirection(context)?TextAlign.right:TextAlign.left:textAlign,style: TextStyle(color: color??AppUI.blackColor,fontSize: fontSize,fontWeight: fontWeight,decoration: textDecoration),textDirection: AppUtil.rtlDirection(context)?ui.TextDirection.rtl:ui.TextDirection.ltr,);
  }
}



class CustomButton extends StatelessWidget {
  final Color? color;
  final int radius;
  final String text;
  final Color? textColor,borderColor;
  final Function()? onPressed;
  final double? width,height;
  final Widget? child;
  const CustomButton({Key? key,required this.text,this.onPressed,this.color,this.borderColor,this.radius = 15,this.textColor = Colors.white,this.width,this.child,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height??56,
          width: width??AppUtil.responsiveWidth(context)*0.91,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(double.parse("$radius")),
            color: color??AppUI.mainColor,
            border: borderColor==null?null:Border.all(color: borderColor!)
          ),
          alignment: Alignment.center,
          child: child??CustomText(text: text, fontSize: 16.0,fontWeight: FontWeight.w100,color: textColor,)),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? height,width;
  final Color? color;
  final double? elevation,radius,padding;
  final Color? border;
  final Function()? onTap;
  const CustomCard({Key? key,required this.child,this.height,this.width,this.color,this.elevation,this.border,this.onTap,this.radius,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??15)
        ),
        elevation: elevation??4,
        child: Container(
          padding: EdgeInsets.all(padding??15),
          width: width==null?double.infinity:width==-1?null:width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius??15),
            border: border!=null?Border.all(color: border!):null,
            color: color??AppUI.whiteColor,
          ),
          child: child,
        ),
      ),
    );
  }
}



class CustomInput extends StatelessWidget {
  final String? hint,lable;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function()? onTap;
  final Function(String v)? onChange,onSubmit;
  final bool obscureText,readOnly,autofocus,validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines , maxLength;
  final double radius;
  final TextAlign? textAlign;
  final Color? borderColor,fillColor;
  const CustomInput({Key? key,required this.controller,this.hint,this.onSubmit,this.lable,required this.textInputType,this.obscureText = false,this.prefixIcon,this.suffixIcon,this.onTap,this.onChange,this.maxLines,this.textAlign,this.readOnly = false,this.autofocus = false,this.radius = 20.0,this.maxLength,this.validation=true,this.borderColor,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      // maxLength: maxLength,
      keyboardType: textInputType,
      textAlign: textAlign!=null?textAlign!:AppUtil.rtlDirection(context)?TextAlign.right:TextAlign.left,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validation?(v){
        if(v!.isEmpty) {
          return "fieldRequired".tr();
        }
        return null;
      }:null,
      autofocus: autofocus,
      maxLines: maxLines??1,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon==null?null:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: suffixIcon,
        ),
        labelText: lable,
        // labelStyle: TextStyle(color: AppUI.secondColor),
        filled: true,
        fillColor: fillColor??AppUI.whiteColor,
        suffixIconConstraints: suffixIcon==null?null:const BoxConstraints(
            minWidth: 63
        ),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: AppUtil.responsiveHeight(context)*0.021),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius),topRight: Radius.circular(radius) ),
            borderSide: BorderSide(color: borderColor??AppUI.shimmerColor)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius),topRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor??AppUI.shimmerColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius),topRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor??AppUI.shimmerColor,width: 0.5)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),bottomLeft: Radius.circular(radius),bottomRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor??AppUI.mainColor)
        ),

      ),
    );
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

}

class ErrorFetchWidget extends StatelessWidget {
  const ErrorFetchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: "errorFetch".tr(),fontSize: 18,),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: "noDataAvailable".tr(),fontSize: 18,),
    );
  }
}

class InternetConnectionWidget extends StatelessWidget {
  const InternetConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: "checkYourInternetConnection".tr(),fontSize: 18,),
    );
  }
}

class CustomDropDownMenu extends StatelessWidget {
  final Function()? onTapElement;
  final element;
  const CustomDropDownMenu({Key? key,this.onTapElement,this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppUI.mainColor),
      ),
      constraints: const BoxConstraints(
          maxHeight: 140
      ),
      child: ListView(
        shrinkWrap: true,
        children: List.generate(8, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTapElement,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: element??"الرياض"),
                  if(index!=7)
                    const Divider()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final String type;
  final Products? product;
  final Function()? onFav,addToCart;
  final bool fromFav;
  const ProductCard({Key? key,this.type = "grid",this.fromFav = false, this.product,this.onFav,this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Products? cartItem;
        for (var element in CategoriesCubit.get(context).cartModel!.data!.products!) {
          if(element.productId.toString() == product!.id.toString()){
            cartItem = element;
            break;
          }
        }
        AppUtil.mainNavigator(context, ProductDetailsScreen(product: product!,cartItem: cartItem));
      },
      child: type=="grid"?Stack(
        children: [
          CustomCard(
            radius: 15,elevation: 0,border: AppUI.mainColor.withOpacity(0.2),padding: 0,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl: product!.image??"",fit: BoxFit.fill,height: 270,placeholder: (context, url) => Stack(
                          children: [
                            Image.asset("${AppUI.imgPath}productJouf.png",height: 270,width: double.infinity),
                            // Image.asset("${AppUI.imgPath}boy.png",height: 270,width: double.infinity,fit: BoxFit.fill,),
                          ],
                        ),
                          errorWidget: (context, url, error) => Stack(
                            children: [
                              Image.asset("${AppUI.imgPath}productJouf.png",height: 270,width: double.infinity,),
                              // Image.asset("${AppUI.imgPath}boy.png",height: 270,width: double.infinity,fit: BoxFit.fill,),
                            ],
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                        child: Row(
                          children: [
                            if(product!.quantity>0)
                              if(product!.special.toString()!="0")
                              Row(
                                children: [
                                  CustomCard(
                                  height: 30,width: 40,elevation: 0,radius: 5,padding: 0,
                                  color: AppUI.orangeColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(fromFav)
                                        CustomText(text:"${(100-((double.parse(product!.special!.toString())/double.parse(product!.price!.toString()))*100)).round()}%",color: AppUI.whiteColor,fontSize: 10,)
                                      else
                                        CustomText(text:"${(100-((product!.special!/product!.price!)*100)).round()}%",color: AppUI.whiteColor,fontSize: 10,),
                                    ],
                                  )
                            )

                                ],
                              ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundColor: AppUI.shimmerColor.withOpacity(0.5),
                              child: IconButton(onPressed: onFav, icon: Icon(product!.fav!?Icons.favorite:Icons.favorite_border,color: AppUI.errorColor,)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: AppUtil.responsiveWidth(context)*0.4,
                                child: CustomText(text: product!.name!.length>40?"${product!.name!.substring(0,40)}...":product!.name,color: AppUI.iconColor.withOpacity(0.8),fontSize: 10,)),
                            const SizedBox(height: 7,),
                            Row(
                              children: [
                                CustomText(text: "${product!.special!=0?product!.special:product!.price} SR",color: AppUI.mainColor,fontWeight: FontWeight.w600,fontSize: 12,),
                                const SizedBox(width: 10,),
                                if(product!.special!=0)
                                CustomText(text: "${product!.price} SR",color: AppUI.iconColor,textDecoration: TextDecoration.lineThrough,fontSize: 9,),
                              ],
                            ),
                            // if(product!.salePrice!=null)
                            // CustomText(text: "456 SAR",color: AppUI.iconColor,textDecoration: TextDecoration.lineThrough,fontSize: 12,),
                            // CustomText(text: "hjhvhjvhjgvhjvhvhjvhjvh...",color: AppUI.blackColor,),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                                width: AppUtil.responsiveWidth(context)*0.424,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(text: "addToCart".tr(),width: AppUtil.responsiveWidth(context)*0.402,radius: 9,onPressed: product!.quantity>0?addToCart:(){
                                      AppUtil.errorToast(context, "outOfStock".tr());
                                    }),
                                  ],
                                )),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          if(product!.quantity<1)
            Transform.rotate(
              angle: AppUtil.rtlDirection(context)?-math.pi / 5:math.pi / 5,
              child:
              Stack(
                children: [
                  Container(height: 100,width: 16,margin: const EdgeInsets.only(bottom: 80),decoration: BoxDecoration(color: AppUI.errorColor,borderRadius: BorderRadius.only(topLeft: AppUtil.rtlDirection(context)?Radius.circular(0):Radius.circular(7),bottomLeft: AppUtil.rtlDirection(context)?Radius.circular(0):Radius.circular(8),topRight: !AppUtil.rtlDirection(context)?const Radius.circular(0):Radius.circular(7),bottomRight: !AppUtil.rtlDirection(context)?Radius.circular(0):Radius.circular(8))),),
                  CustomText(text: "outOfStock",fontSize: 10,color: Colors.transparent,)
                ],
              ),
            ),
          if(product!.quantity<1)
            Padding(
              padding: const EdgeInsets.only(top: 37),
              child: Transform.rotate(
                angle: AppUtil.rtlDirection(context)?math.pi / 3.3:-math.pi / 3.3,
                child: CustomText(text: "outOfStock".tr(),fontSize: 11,color: AppUI.whiteColor,),
              ),
            ),
        ],
      ):Column(
        children: [
          if(type.split(" ")[0] == "orders")
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  CustomText(text: "${"orderId".tr()} : #${product!.id}",fontWeight: FontWeight.w700,),
                  const Spacer(),
                  CustomText(text: type.split(" ")[1] == "current" ? "In Progress" : "Delivered",color: type.split(" ")[1] == "current" ? AppUI.mainColor : AppUI.activeColor,)
                ],
              ),
            ),
          Row(
            children: [
              if(type.split(" ")[0] == "orders")
              Expanded(
                flex: 2,
                child: CachedNetworkImage(imageUrl: product!.image!,placeholder: (context, url) => Stack(
                  children: [
                    Image.asset("${AppUI.imgPath}product_background.png",height: 150,fit: BoxFit.fill,),
                    Image.asset("${AppUI.imgPath}boy.png",height: 150,fit: BoxFit.fill,),
                  ],
                ),
                  errorWidget: (context, url, error) => Stack(
                    children: [
                      Image.asset("${AppUI.imgPath}product_background.png",height: 170,fit: BoxFit.fill,),
                      Image.asset("${AppUI.imgPath}boy.png",height: 170,fit: BoxFit.fill,),
                    ],
                  ),),
              )
              else
              Expanded(
                flex: 2,
                child: CachedNetworkImage(imageUrl: product!.image!,placeholder: (context, url) => Stack(
                  children: [
                    Image.asset("${AppUI.imgPath}product_background.png",height: 150,fit: BoxFit.fill,),
                    Image.asset("${AppUI.imgPath}boy.png",height: 150,fit: BoxFit.fill,),
                  ],
                ),
                  errorWidget: (context, url, error) => Stack(
                    children: [
                      Image.asset("${AppUI.imgPath}product_background.png",height: 170,fit: BoxFit.fill,),
                      Image.asset("${AppUI.imgPath}boy.png",height: 170,fit: BoxFit.fill,),
                    ],
                  ),),
              ),
              const SizedBox(width: 7,),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: type.split(" ")[0] == "orders"?product!.name:product!.name,color: AppUI.blueColor,),
                          CustomText(text: type.split(" ")[0] == "orders"?'':product!.description!.length<3?product!.description:"${product!.description!.substring(3,product!.description!.length>29?24:product!.description!.length-5)}...",color: AppUI.blackColor,),
                          // if(type.split(" ")[0] == "orders")
                          // CustomText(text: "${product!.total} SAR",color: AppUI.orangeColor,fontWeight: FontWeight.w600,)
                          // else
                          CustomText(text: "${product!.price} SAR",color: AppUI.orangeColor,fontWeight: FontWeight.w600,),
                          // Row(
                          //   children: [
                          //     CustomText(text: "Size",color: AppUI.iconColor,),
                          //     const SizedBox(width: 10,),
                          //     CustomText(text: "XS",color: AppUI.blackColor,),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCreditCard extends StatelessWidget {
  final String? cardHolder,cardNum,expiryDate,cvv;
  const CustomCreditCard({Key? key, this.cardHolder, this.cardNum, this.cvv, this.expiryDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.asset("${AppUI.imgPath}visaa.png",color: AppUI.mainColor,)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: cardNum??"4343234543453454",fontSize: 22,color: AppUI.whiteColor,),
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
