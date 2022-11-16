import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import 'Cubit/cubit_search.dart';
import 'Cubit/state_search.dart';

class SearchScreenShop extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){

        },
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        control: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'enter text to search';
                          }else{
                            return null;
                          }
                        },
                        label: 'SEARCH',
                        prefixicon:Icons.search,
                        onSumbit: (String text)
                        {
                          if(formKey.currentState!.validate()){
                            SearchCubit.get(context).Search(text);
                          }


                        }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=> buildListProduct(SearchCubit.get(context).searchModel.data!.data[index],context, isOldPrice: false),
                          separatorBuilder: (context,index)=> Divider(),
                          itemCount: SearchCubit.get(context).searchModel.data!.data.length ,
                        ),
                      ),

                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
