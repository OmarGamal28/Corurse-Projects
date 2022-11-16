import 'package:app01/layout/news_app/cubit/cubit.dart';
import 'package:app01/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var control = TextEditingController();
    var list = NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                    control: control,
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);

                    },
                    type: TextInputType.text,
                    validate: ( value){
                      if (value!.isEmpty){
                        return "enter value";
                      }
                      return null;

                    },
                    label: 'search',
                    prefixicon: Icons.search
                ),
                Expanded(
                    child: articleBuilder(list, context,isSearch: true)
                )

              ],
            ),
          ),

        );
      },

    );
  }
}
