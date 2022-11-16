

import 'package:app01/models/shopp_app/favorites_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder: (context,state){
        return ConditionalBuilder(
          condition:  state is !ShopLoadingGetFavStates,
          builder: (context)=> ListView.separated(
            itemBuilder: (context,index)=> buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product,context),
            separatorBuilder: (context,index)=> Divider(),
            itemCount: ShopCubit.get(context).favoritesModel?.data.data.length ?? 0 ,
          ),
          fallback:(context) =>Center(child: CircularProgressIndicator()),
        );
      },
    ) ;
  }


}
