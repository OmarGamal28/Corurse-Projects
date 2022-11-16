import 'package:app01/moduels/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../moduels/todo_app/archive_tasks/archive_tasks_screen.dart';
import '../../shared/cubit/states.dart';


class HomeLayout extends StatelessWidget
{

  late Database database;
  var scafoldKey=GlobalKey<ScaffoldState>();
  var control = TextEditingController();
  var time = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var date = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is AppInsertDataBase){
            Navigator.pop(context);
          }
        },
        builder:(context,state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
          key: scafoldKey,
          appBar: AppBar(
            title: Text(
                cubit.title[cubit.currentindex]
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {

              if(cubit.isbottomsheetshown){
                if(formkey.currentState!.validate())
                {
                  cubit.insertToDatabase(title: control.text, date: date.text, time: time.text);

                }
              }else{
                scafoldKey.currentState?.showBottomSheet(
                      (context) => Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            control: control ,
                            type: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty){
                                return ('please enter title');
                              }
                              return null;
                            },
                            label: 'Task Title',
                            prefixicon: Icons.title,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              control: time ,
                              type: TextInputType.datetime,
                              validate: (value){
                                if(value!.isEmpty){
                                  return ('please enter time');
                                }
                                return null;
                              },
                              label: 'Time Title',
                              prefixicon: Icons.watch_later_outlined,
                              onTap: (){
                                showTimePicker(context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then(( value)
                                {
                                  time.text=value!.format(context).toString();
                                  print(value.format(context));
                                });
                              }
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              control: date ,
                              type: TextInputType.datetime,
                              validate: (value){
                                if(value!.isEmpty){
                                  return ('please enter date');
                                }
                                return null;
                              },
                              label: 'Date Title',
                              prefixicon: Icons.calendar_today,
                              onTap: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2022-12-28')
                                ).then((value) {
                                  date.text=DateFormat.yMMMd().format(value!);
                                });


                              }
                          )
                        ],
                      ),
                    ),
                  ),
                  elevation: 15.0,
                ).closed.then((value) {
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
              }

            },
            child: Icon(
                cubit.fab
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,//fixed width
              currentIndex: cubit.currentindex,
              onTap: (index){
                cubit.changeIndex(index);
              },


              items:[
                BottomNavigationBarItem(icon:
                Icon(
                    Icons.menu
                ),
                    label: 'Tasks'


                ),
                BottomNavigationBarItem(icon:
                Icon(
                    Icons.check_circle_outline
                ),
                    label: 'Done'


                ),
                BottomNavigationBarItem(icon:
                Icon(
                    Icons.archive_outlined
                ),
                    label: 'Archive'


                ),
              ]
          ),
          body:  ConditionalBuilder(
            condition: state is! AppDataBaseLoadingState,
            builder: (context)=> cubit.screen[cubit.currentindex], //لو كوندشن تمام
            fallback: (context)=> Center(child: CircularProgressIndicator()), //لو مش تمام
          ) ,

        );
        },


      ),
    );
  }



}


