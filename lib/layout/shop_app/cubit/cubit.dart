import 'package:app01/layout/shop_app/cubit/states.dart';
import 'package:app01/models/shopp_app/change_favorites_model.dart';
import 'package:app01/models/shopp_app/home_model.dart';
import 'package:app01/moduels/shop_app/Favorites/favorites_screen.dart';
import 'package:app01/moduels/shop_app/categories/categories_screen.dart';
import 'package:app01/moduels/shop_app/products/products_screen.dart';
import 'package:app01/moduels/shop_app/settings/settings_screen.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopp_app/categories_model.dart';
import '../../../models/shopp_app/favorites_model.dart';
import '../../../models/shopp_app/login_model.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cash_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex= 0;
  List<Widget> bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ChangeBottomNavStates());
  }
  HomeModel? homeModel;
   Map<int,bool> favorites={};
  void getHomeData(){
   emit(ShopLoadingHomeDataStates()) ;
   DioHelper.getData(url: HOME,token: token).then((value) {

     homeModel = HomeModel.fromJson(value.data);
     print(homeModel?.status);

     homeModel?.data.products.forEach((element) {
       favorites.addAll({
         element.id: element.inFavorites
       });
     });
     print(favorites.toString());


     emit(ShopSuccessHomeDataStates());
   }).catchError((error){
     print(error.toString());

   });

  }


  CategoriesModel? categoriesModel;
  void getCategoriesModel(){

    DioHelper.getData(url: GET_CATEGORIES,).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(homeModel?.status);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates());

    });

  }

ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites (int productId){
    favorites[productId] =  !favorites[productId]!;
    emit(ShopChangeFavoritesStates());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId
        },
      token: CacheHelper.getData(key: 'token'),
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if  (!changeFavoritesModel!.status){
        favorites[productId] =  !favorites[productId]!;

      }else{
        getFavorites();
      }
      emit(ShopSuccessFavoritesStates(changeFavoritesModel!));

    }).catchError((e){
      favorites[productId] =  !favorites[productId]!;
      emit(ShopErrorFavoritesStates());
    });

  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavStates());
    DioHelper.getData(url: FAVORITES,token:CacheHelper.getData(key: 'token')).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);

      print(favoritesModel!.data!.data.toString());
      emit(ShopSuccessGetFavStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavStates());

    });

  }

  ShopLoginModel? userModel;
  void getUserModel(){
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: PROFILE,token:CacheHelper.getData(key: 'token')).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name);
      emit(ShopSuccessUserDataStates(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataStates());

    });

  }

  void updateUserModel({
    required String name,
    required String email,
    required String phone,

})
  {
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token:CacheHelper.getData(key: 'token'),
      data: {
          'name': name,
        'email': email,
        'phone': phone,

      }
    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserStates(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserStates());

    });

  }
}