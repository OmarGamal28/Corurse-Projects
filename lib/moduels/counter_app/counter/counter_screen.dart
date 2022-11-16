
import 'package:app01/moduels/counter_app/counter/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class CounterScreen extends StatelessWidget {

  int counter =1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit() ,
      child: BlocConsumer<CounterCubit,CounterStates>(
      listener: (context,state){
        if(state is MinusState){
          print('minus state${state.counter}'); //ال state دي الي هيف السطر الي فوقيها
        }
        if (state is PlusState){
          print('plus state ${state.counter}');
        }
      },
        builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'counter'
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TextButton(
                  onPressed: (){

                    CounterCubit.get(context).minus();


                  },
                  child: Text(
                    'MINUS',

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){

                    CounterCubit.get(context).plus();

                  },
                  child: Text(
                    'PLUS',

                  ),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}


