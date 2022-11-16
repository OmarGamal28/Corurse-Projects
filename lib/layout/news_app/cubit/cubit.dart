import 'package:app01/layout/news_app/cubit/states.dart';
import 'package:app01/moduels/news_app/business/business_screen.dart';
import 'package:app01/moduels/news_app/sceince/science_screen.dart';

import 'package:app01/moduels/news_app/sports/sports_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit():super(NewsInitialState());
   static NewsCubit get(context)=> BlocProvider.of(context);
  int currentindex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business
        ),
      label: "Business"
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports,
        ),
        label: "Sports"
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
        label: "Science"
    ),

  ];
  void changeBottomNavBar(int index){
    currentindex =index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();

    emit(BottomNavBarState());
  }
  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];
  List<dynamic> business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apikey':'946884fe5f39459092bc65bfa4e7374c'
        }
    ).then((value) {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science=[];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {'country':'eg',
            'category':'science',
            'apikey':'946884fe5f39459092bc65bfa4e7374c'}
      ).then((value) {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(GetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetScienceErrorState(error.toString()));
      });
    }else{
      emit(GetScienceSuccessState());
    }

  }

  List<dynamic> sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'946884fe5f39459092bc65bfa4e7374c'
          }
      ).then((value) {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetSportsErrorState(error.toString()));
      });
    } else{
      emit(GetSportsSuccessState());
    }

  }


  List<dynamic> search=[];
  void getSearch(value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {

          'category':'$value',
          'apikey':'946884fe5f39459092bc65bfa4e7374c'
        }
    ).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }


}