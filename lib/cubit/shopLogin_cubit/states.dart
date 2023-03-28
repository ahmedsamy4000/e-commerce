abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccesState extends ShopLoginStates {}

class ShopLoginEroorState extends ShopLoginStates {
  final String error;
  ShopLoginEroorState(this.error);
}

class ChangePasswordVisibility extends ShopLoginStates {}
