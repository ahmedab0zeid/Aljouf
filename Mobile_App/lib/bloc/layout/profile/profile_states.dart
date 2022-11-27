abstract class ProfileStates{}
class ProfileInitState extends ProfileStates{}

class ProfileLoadingState extends ProfileStates{}
class ProfileLoadedState extends ProfileStates{}
class ProfileErrorState extends ProfileStates{}

class EditProfileLoadingState extends ProfileStates{}
class EditProfileLoadedState extends ProfileStates{}
class EditProfileErrorState extends ProfileStates{}

class AllStaticPageLoadingState extends ProfileStates{}
class AllStaticPageLoadedState extends ProfileStates{}
class AllStaticPageErrorState extends ProfileStates{}

class StaticPageLoadingState extends ProfileStates{}
class StaticPageLoadedState extends ProfileStates{}
class StaticPageErrorState extends ProfileStates{}

class AddressesLoadingState extends ProfileStates{}
class AddressesLoadedState extends ProfileStates{}
class AddressesErrorState extends ProfileStates{}
class AddressesEmptyState extends ProfileStates{}

class AddAddressesLoadingState extends ProfileStates{}
class AddAddressesLoadedState extends ProfileStates{}

class ChangePassLoadingState extends ProfileStates{}
class ChangePassLoadedState extends ProfileStates{}

class PassVisibilityChangeState extends ProfileStates{}
