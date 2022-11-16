import 'package:app01/models/shopp_app/login_model.dart';
import 'package:app01/moduels/shop_app/login/cubit/states.dart';
import 'package:app01/moduels/shop_app/register/cubit/states.dart';
//import 'package:app01/moduels/shop_app/on_boarding/on_boarding/login/cubit/states.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

static ShopRegisterCubit get(context)=> BlocProvider.of(context);
late ShopLoginModel loginModel;
void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
emit(ShopRegisterLoadingState());
DioHelper.postData(
    url: REGISTER,//end point
    data: {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    }

).then((value) {
  print(value.data['message']);
  loginModel= ShopLoginModel.fromJson(value.data);
  emit(ShopRegisterSuccessState(loginModel));
}).catchError((error){
  print(error.toString());
  emit(ShopRegisterErrorState(error.toString()));
});
}
IconData sufixx=Icons.visibility_outlined;
bool isPassword = true;
void passVisibility(){
  isPassword = !isPassword;
  sufixx = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  emit(ShopRegisterPassVisibility());
}
}