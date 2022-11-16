import 'package:app01/layout/news_app/cubit/states.dart';
import 'package:app01/moduels/news_app/search/search_screen.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/cubit/cubit.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder:(context,state){
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTp(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search
                  )
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(
                      Icons.brightness_4_sharp
                  )
              )
            ],

          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.bottomItems ,
            currentIndex: cubit.currentindex,
            onTap: (index){
              cubit.changeBottomNavBar(index);

            },

          ),
        );
      }

    );
  }
}
