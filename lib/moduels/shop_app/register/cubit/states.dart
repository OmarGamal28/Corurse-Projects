import 'package:app01/models/shopp_app/login_model.dart';

abstract class ShopRegisterState{}
class ShopRegisterInitialState extends ShopRegisterState{}
class ShopRegisterLoadingState extends ShopRegisterState{}
class ShopRegisterSuccessState extends ShopRegisterState{
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterPassVisibility extends ShopRegisterState{}

