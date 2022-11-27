abstract class CheckoutStates{}
class CheckoutInitState extends CheckoutStates{}

class CheckoutChangeState extends CheckoutStates{}
class PaymentChangeState extends CheckoutStates{}

class CountriesLoadingState extends CheckoutStates{}
class CountriesLoadedState extends CheckoutStates{}
class CountriesErrorState extends CheckoutStates{}

class StatesLoadingState extends CheckoutStates{}
class StatesLoadedState extends CheckoutStates{}
class StatesErrorState extends CheckoutStates{}

class CitiesLoadingState extends CheckoutStates{}
class CitiesLoadedState extends CheckoutStates{}
class CitiesErrorState extends CheckoutStates{}

class SaveAddressLoadingState extends CheckoutStates{}
class SaveAddressLoadedState extends CheckoutStates{}

class SaveShippingMethodLoadingState extends CheckoutStates{}
class SaveShippingMethodLoadedState extends CheckoutStates{}

class SavePaymentMethodLoadingState extends CheckoutStates{}
class SavePaymentMethodLoadedState extends CheckoutStates{}

class ShippingMethodsLoadingState extends CheckoutStates{}
class ShippingMethodsLoadedState extends CheckoutStates{}
class ShippingMethodsErrorState extends CheckoutStates{}

class PaymentMethodsLoadingState extends CheckoutStates{}
class PaymentMethodsLoadedState extends CheckoutStates{}
class PaymentMethodsErrorState extends CheckoutStates{}

class CreditCardChangeState extends CheckoutStates{}

class AddressesChangeState extends CheckoutStates{}
class CheckBoxChangeState extends CheckoutStates{}

