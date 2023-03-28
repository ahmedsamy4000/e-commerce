import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/cubit/register_cubit/states.dart';
import 'package:shop/dio/dio.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  String? test;
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_off_rounded;
    emit((RegisterPasswordVisibility()));
  }

  void userRegister(
      {required String userName,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name': userName,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      Fluttertoast.showToast(
          msg: value.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(RegisterSuccesState());
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      emit(RegisterErrorState(error['message'].toString()));
    });
  }
}
