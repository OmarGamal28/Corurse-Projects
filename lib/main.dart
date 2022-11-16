import 'package:app01/layout/news_app/cubit/cubit.dart';
import 'package:app01/layout/shop_app/shop_layout.dart';

import 'package:app01/moduels/counter_app/counter/counter_screen.dart';
import 'package:app01/moduels/basics/home/home_screen.dart';
import 'package:app01/moduels/shop_app/on_boarding/on_boarding/on_boarding_screen.dart';

import 'package:app01/moduels/users/users_screen.dart';
import 'package:app01/moduels/bmi_app/bmicalculator/bmi_screen.dart';
import 'package:app01/shared/bloc_observe.dart';
import 'package:app01/shared/cubit/cubit.dart';
import 'package:app01/shared/cubit/states.dart';
import 'package:app01/shared/network/local/cash_helper.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:app01/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/todo_app/todo_layout.dart';
import 'moduels/counter_app/counter/counter_screen.dart';
import 'moduels/shop_app/login/shop_login_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();//عشان sync فا استخدمنا الميثود دي عشان ترن بالترتيب

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget ;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding !=null){
    if(token != null) widget= ShopLayout();
    else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget
{

   final  bool? isDark;

   final Widget? startWidget;
  MyApp({this.isDark,   this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()),
        BlocProvider(create: (context)=>AppCubit()..changeAppMode(
            fromShared: isDark!
        ), ),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesModel()..getFavorites()..getUserModel(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lighttheme, //light
            darkTheme: darktheme,//dark
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,//بغير من light to dark
            home:startWidget,
          );
        },

      ),
    );

  }

}

