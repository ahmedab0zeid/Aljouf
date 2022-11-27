abstract class OrdersStates{}
class OrdersInitState extends OrdersStates{}
class OrdersChangeState extends OrdersStates{}

class OrdersLoadingState extends OrdersStates{}
class OrdersLoadedState extends OrdersStates{}
class OrdersErrorState extends OrdersStates{}
class OrdersEmptyState extends OrdersStates{}

class ReOrdersLoadingState extends OrdersStates{}
class ReOrdersLoadedState extends OrdersStates{}
class ReOrdersErrorState extends OrdersStates{}
