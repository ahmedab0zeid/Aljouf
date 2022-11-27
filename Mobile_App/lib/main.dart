
import 'package:aljouf/bloc/layout/categories/categories_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/init_screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/auth_cubit/auth_cubit.dart';
import 'bloc/layout/bottom_nav_cubit.dart';
import 'bloc/layout/checkout/checkout_cubit.dart';
import 'bloc/layout/orders/orders_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp();
  await AppUtil.initNotification();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'lang',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit(),),
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => OrdersCubit(),),
        BlocProvider(create: (context) => CheckoutCubit()..countries()..shippingMethods()..paymentMethods(),),
        BlocProvider(create: (context) => CategoriesCubit()..fetchBanners()..fetchCategories()..wishList(fromMain: true)..cart(),),
        BlocProvider(create: (context) => ProfileCubit()..profile()..allStaticPages()..addresses(),),
      ],
      child: MaterialApp(
        title: 'الجوف',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          scaffoldBackgroundColor: AppUI.whiteColor,
          appBarTheme: AppBarTheme(color: Colors.white,iconTheme: IconThemeData(color: AppUI.blackColor)),
          primarySwatch: AppUI.mainColor,
          textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
