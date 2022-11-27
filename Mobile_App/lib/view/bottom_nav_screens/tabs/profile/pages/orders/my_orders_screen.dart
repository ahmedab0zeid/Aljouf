import 'package:aljouf/bloc/layout/bottom_nav_cubit.dart';
import 'package:aljouf/bloc/layout/orders/orders_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/bottom_nav_tabs_screen.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/widgets/order_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/layout/orders/orders_cubit.dart';
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = OrdersCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        BottomNavCubit.get(context).setCurrentIndex(4);
        AppUtil.removeUntilNavigator(context, const BottomNavTabsScreen());
        return false;
      },
      child: Scaffold(
        appBar: customAppBar(title: "myOrders".tr()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                color: AppUI.mainColor
              ),
              child: BlocBuilder<OrdersCubit,OrdersStates>(
                buildWhen: (_,state) => state is OrdersChangeState,
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.changeOrdersStates("2");
                                  getOrders();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: cubit.currentState=="2"?AppUI.whiteColor:AppUI.mainColor
                                  ),
                                    child: CustomText(text: "processing".tr(),color: cubit.currentState=="2"?AppUI.mainColor:AppUI.whiteColor,)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.changeOrdersStates("3");
                                  getOrders();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: cubit.currentState=="3"?AppUI.whiteColor:AppUI.mainColor
                                  ),
                                    child: CustomText(text: "shipped".tr(),color: cubit.currentState=="3"?AppUI.mainColor:AppUI.whiteColor,)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.changeOrdersStates("5");
                                  getOrders();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: cubit.currentState=="5"?AppUI.whiteColor:AppUI.mainColor
                                  ),
                                    child: CustomText(text: "completed".tr(),color: cubit.currentState=="5"?AppUI.mainColor:AppUI.whiteColor,)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  cubit.changeOrdersStates("7");
                                  getOrders();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: cubit.currentState=="7"?AppUI.whiteColor:AppUI.mainColor
                                  ),
                                    child: CustomText(text: "canceled".tr(),color: cubit.currentState=="7"?AppUI.mainColor:AppUI.whiteColor,)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppUI.whiteColor
              ),
              child:  BlocBuilder<OrdersCubit,OrdersStates>(
                  buildWhen: (_,state) => state is OrdersChangeState || state is OrdersLoadingState || state is OrdersLoadedState || state is OrdersErrorState || state is OrdersEmptyState ,
                  builder: (context, state) {
                    if(state is OrdersLoadingState && cubit.page == 1){
                      return const LoadingWidget();
                    }

                    if(state is OrdersErrorState && cubit.page == 1){
                      return const ErrorFetchWidget();
                    }

                    if(state is OrdersEmptyState && cubit.page == 1){
                      return const EmptyWidget();
                    }

                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        controller: cubit.ordersScrollController,
                        children: List.generate(cubit.ordersList.length, (index) {
                          return OrderCard(state: cubit.currentState,order: cubit.ordersList[index],);
                        }),
                      ),
                      SizedBox(
                        height: state is OrdersLoadingState && cubit.page>1? 90 : 0,
                        width: double.infinity,
                        child: Center(
                          child: state is OrdersEmptyState && cubit.page > 1
                              ? Text("noMoreData".tr())
                              : const LoadingWidget(),
                        ),
                      )
                    ],
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  getOrders() async {
    final cubit = OrdersCubit.get(context);
    cubit.page = 1;
    cubit.orders();
    cubit.ordersScrollController.addListener(() {
      if (cubit.ordersScrollController.position.pixels ==
          cubit.ordersScrollController.position.maxScrollExtent) {
        cubit.page++;
        cubit.orders();
      }
    });
  }
}
