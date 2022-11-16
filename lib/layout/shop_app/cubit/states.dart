import 'package:app01/models/shopp_app/login_model.dart';

import '../../../models/shopp_app/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}
class ChangeBottomNavStates extends ShopStates{}
class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates  extends ShopStates{}
class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates  extends ShopStates{}
class ShopSuccessFavoritesStates extends ShopStates{
  late final ChangeFavoritesModel model;
  ShopSuccessFavoritesStates(this.model);
}
class ShopChangeFavoritesStates extends ShopStates{}
class ShopErrorFavoritesStates  extends ShopStates{}

class ShopSuccessGetFavStates extends ShopStates{}
class ShopErrorGetFavStates  extends ShopStates{}
class ShopLoadingGetFavStates  extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataStates(this.loginModel);
}
class ShopErrorUserDataStates  extends ShopStates{}
class ShopLoadingUserDataStates  extends ShopStates{}


class ShopSuccessUpdateUserStates extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates  extends ShopStates{}
class ShopLoadingUpdateUserStates  extends ShopStates{}



