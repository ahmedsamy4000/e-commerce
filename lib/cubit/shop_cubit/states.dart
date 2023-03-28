import 'package:shop/models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavouritesSuccessState extends ShopStates {}

class ShopChangeFavouritesErrorState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopSuccessUserModelState extends ShopStates {
  final ShopLoginModel userModel;
  ShopSuccessUserModelState(this.userModel);
}

class ShopLoadingUserModelState extends ShopStates {}

class ShopErrorUserModelState extends ShopStates {}
