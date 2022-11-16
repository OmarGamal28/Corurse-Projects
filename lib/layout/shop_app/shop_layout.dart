import 'package:app01/layout/shop_app/cubit/cubit.dart';
import 'package:app01/layout/shop_app/cubit/states.dart';
import 'package:app01/moduels/news_app/search/search_screen.dart';
import 'package:app01/moduels/shop_app/login/shop_login_screen.dart';
import 'package:app01/moduels/shop_app/search/search_screen.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){

    },
      builder:(context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Matgark'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTp(context, SearchScreenShop());
                  },
                  icon: Icon(
                      Icons.search
                  ),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
              currentIndex: cubit.currentIndex,
              items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home
                ),
              label: 'HOME'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.apps
                ),
                label: 'CATEGORIES'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.favorite
                ),
                label: 'FAVORITES'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.settings
                ),
                label: 'SETTINGS'
            ),
          ]),
        );
      },

    );
  }
}
