import 'package:aljouf/bloc/layout/orders/orders_states.dart';
import 'package:aljouf/models/profile/orders_model.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/orders_repository.dart';

class OrdersCubit extends Cubit<OrdersStates>{
  OrdersCubit():super(OrdersInitState());
  static OrdersCubit get(context) => BlocProvider.of(context);

  String currentState = '2';
  changeOrdersStates(state){
    currentState = state;
    emit(OrdersChangeState());
  }

  OrdersModel? ordersModel;
  List<Data> ordersList = [];
  int page = 1;
  ScrollController ordersScrollController = ScrollController();
  orders() async {
    emit(OrdersLoadingState());
    try {
      Map<String,dynamic> response = await OrdersRepository.orders(currentState, page);
      ordersModel = OrdersModel.fromJson(response);
      if(ordersModel!.data!.isEmpty){
        emit(OrdersEmptyState());
      }else {
        ordersList.addAll(ordersModel!.data!);
        emit(OrdersLoadedState());
      }
    } catch (e) {
      emit(OrdersErrorState());
      return Future.error(e);
    }
  }

  reOrders(orderId,productId,context) async {
    emit(ReOrdersLoadingState());
    try {
      Map<String,dynamic> response = await OrdersRepository.reOrders(orderId,productId);
      Navigator.of(context,rootNavigator: true).pop();
      if(response['success'] == 1){
        AppUtil.successToast(context, "productReOrders".tr());
      }else{
        AppUtil.errorToast(context, response['error'][0]);
      }
      emit(ReOrdersLoadedState());
    } catch (e) {
      emit(ReOrdersErrorState());
      return Future.error(e);
    }
  }

}