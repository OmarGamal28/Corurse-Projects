import 'package:app01/models/shopp_app/login_model.dart';
import 'package:app01/moduels/shop_app/login/cubit/states.dart';
//import 'package:app01/moduels/shop_app/on_boarding/on_boarding/login/cubit/states.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

static ShopLoginCubit get(context)=> BlocProvider.of(context);
late ShopLoginModel loginModel;
void userLogin({
  required String email,
  required String password, 
}){
emit(ShopLoginLoadingState());
DioHelper.postData(
    url: LOGIN,//end point
    data: {
      'email':email,
      'password':password
    }

).then((value) {
  print(value.data['message']);
  loginModel= ShopLoginModel.fromJson(value.data);
  emit(ShopLoginSuccessState(loginModel));
}).catchError((error){
  print(error.toString());
  emit(ShopLoginErrorState(error.toString()));
});
}
IconData sufixx=Icons.visibility_outlined;
bool isPassword = true;
void passVisibility(){
  isPassword = !isPassword;
  sufixx = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  emit(ShopLoginpassVisibility());
}
}