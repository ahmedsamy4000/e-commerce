import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shop_cubit/states.dart';
import 'package:shop/dio/dio.dart';
import 'package:shop/models/catageories_model.dart';
import 'package:shop/models/favourites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/my_favourites_model.dart';
import 'package:shop/models/shop_login_model.dart';
import 'package:shop/shop_screens/categories_screen.dart';
import 'package:shop/shop_screens/favorites_screen.dart';
import 'package:shop/shop_screens/main_menu_screen.dart';
import 'package:shop/shop_screens/settings.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  var currentIndex = 0;
  List<Widget> screens = [
    const MainScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Categories', 'Favourites', 'Settings'];
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favourites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];
  void changeItem(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: 'home',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favourites.addAll({element['id']: element['in_favorites']});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoryModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesSuccessState());
    DioHelper.postData(
      url: 'favorites',
      data: {'product_id': productId},
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);

      if (changeFavouritesModel?.status == false) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavData();
      }
      emit(ShopChangeFavouritesSuccessState());
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavouritesErrorState());
    });
  }

  FavouritesModel? favouritesModel;
  void getFavData() {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: 'favorites',
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserModelState());
    DioHelper.getData(
      url: 'profile',
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserModelState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserModelState());
    });
  }
}
