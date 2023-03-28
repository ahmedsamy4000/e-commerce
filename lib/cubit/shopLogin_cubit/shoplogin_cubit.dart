import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/cubit/shopLogin_cubit/states.dart';

import 'package:shop/dio/dio.dart';

class ShopCubit extends Cubit<ShopLoginStates> {
  ShopCubit() : super(ShopLoginInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  String? test;
  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_off_rounded;
    emit(ChangePasswordVisibility());
  }

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      Fluttertoast.showToast(
          msg: value.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(ShopLoginSuccesState());
    }).catchError((error) {
      test = error['message'];
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      emit(ShopLoginEroorState(error['message'].toString()));
    });
  }
}
