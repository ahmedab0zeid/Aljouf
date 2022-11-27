import 'package:flutter/material.dart';

class AppUI{

  static MaterialColor mainColor = const MaterialColor(0xff02814C,{
    50:Color.fromRGBO(4,131,184, .1),
    100:Color.fromRGBO(4,131,184, .2),
    200:Color.fromRGBO(4,131,184, .3),
    300:Color.fromRGBO(4,131,184, .4),
    400:Color.fromRGBO(4,131,184, .5),
    500:Color.fromRGBO(4,131,184, .6),
    600:Color.fromRGBO(4,131,184, .7),
    700:Color.fromRGBO(4,131,184, .8),
    800:Color.fromRGBO(4,131,184, .9),
    900:Color.fromRGBO(4,131,184, 1),
  });

  static Color orangeColor = const Color(0xffFF850C);
  static Color secondColor = const Color(0xffB4A524);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff383838);
  static Color iconColor = const Color(0xff707070);
  static Color inputColor = const Color(0xffF2F2ED);
  static var blueColor = const Color(0xff6993FF);
  static var ratingColor = const Color(0xffFFC60C);
  static var backgroundColor = const Color(0xffF4F0D1).withOpacity(0.5);
  static Color activeColor = Colors.green;
  static Color shimmerColor = Colors.grey[300]!;
  static Color checkoutBackground = Colors.grey[100]!;
  static Color greyColor = Colors.grey;
  static Color errorColor = const Color(0xffE31313);

  static String imgPath = "assets/images/";
  static String iconPath = "assets/icons/";

}