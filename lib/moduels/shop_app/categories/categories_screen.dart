import 'package:app01/layout/shop_app/cubit/cubit.dart';
import 'package:app01/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopp_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder: (context,state){
        return ListView.separated(
          itemBuilder: (context,index)=> buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=> Divider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    ) ;

  }
  Widget buildCatItem(DataModel data)=> Row(
    children: [
      Image(
        image: NetworkImage(data.image!),
        width: 80.0,
        height: 80.0,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width:  20.0,
      ),
      Text(
        data.name!,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Icon(
          Icons.arrow_forward_ios
      ),
    ],
  );
}
