import 'package:app01/moduels/counter_app/counter/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(InitialState());
  static CounterCubit get(context)=> BlocProvider.of(context); //object من class جوه class ذات نفسه
  //او بمعني تاني بيرجعلي object من class
  int counter = 1;
  void plus(){
    counter++;
    emit(PlusState(counter));
  }
  void minus(){
    counter--;
    emit(MinusState(counter));
  }

}