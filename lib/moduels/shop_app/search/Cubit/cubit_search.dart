import 'package:app01/models/shopp_app/search_model.dart';
import 'package:app01/moduels/shop_app/search/Cubit/state_search.dart';
import 'package:app01/shared/network/end_points.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/constans.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchInitialState());
   static SearchCubit get(context)=> BlocProvider.of(context);
   late SearchModel searchModel;

   void Search(String text){
     emit(SearchLoadingState());
     DioHelper.postData(
         url: SEARCH,
         data: {
           'text': text
         },
       token: token,
     ).then((value) {
       searchModel = SearchModel.fromJson(value.data);
       emit(SearchSuccessState());

     }).catchError((e){
       print(e.toString());
       emit(SearchErrorState(e));

     });
   }

}