import 'package:app01/shared/cubit/states.dart';
import 'package:app01/shared/network/local/cash_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../moduels/todo_app/archive_tasks/archive_tasks_screen.dart';
import '../../moduels/todo_app/done_tasks/done_tasks_screen.dart';
import '../../moduels/todo_app/new_tasks/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates>{
  late Database database;
  List<Map> newtasks = [];
  List<Map> archivetasks = [];
  List<Map> donetasks = [];
  IconData fab= Icons.add;
  bool isbottomsheetshown = false;

  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int  currentindex =0;
  List <Widget> screen =[
    NewTasksScreen(),
    ArchiveTasksScreen(),
    DoneTasksScreen(),
  ];
  List <String> title =[ //لو عايز تتنقل مبين اي حاجه استخدم list
    'New Tasks',
    "Done Tasks",
    "Archive Tasks"
  ];
  void changeIndex(int index){
    currentindex = index;
    emit(ChangeBottomNavState());
  }
  void createDatabase()  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version){
        print('DataBase created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY autoincrement,title TEXT not null ,date TEXT not null ,time TEXT not null,status TEXT not null )').then((value)
        {
          print('table created');
        }).catchError((e){
          print('e ${e.toString()}');
        });


      },
      onOpen:(database)
      {
       getData(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

   insertToDatabase({
    required String title,
    required String date,
    required String time,
  })async{
     await database.transaction((txn)
    {
      return txn.rawInsert('INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")')
          .then((value) { //ال value  دي الي هي ال id  وبتتعمل لوحدها عشان primar key  عشان كده برضه مكتبناش ال id مع ال values
        print("$value inserted");
        emit(AppInsertDataBase());
        getData(database);

      }).catchError((e){
        print('error ${e.toString()}');
      });

    });
  } // خلناها فيوتشر عشان لما استدعيها فوق اعمل عليها then عشان ابقي ضامن انها خلصلت


  void getData (database){
    newtasks=[];//عشان نصفر ولما نضيف حاجه منضفش القديم برضه
    archivetasks=[];
    donetasks=[];
    emit(AppDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element){
        if(element['status']=='new'){
          newtasks.add(element);
        }
        else if(element['status']=='done'){
          donetasks.add(element);
        }else archivetasks.add(element);



      });
      emit(AppGetDataBase());


    });


  }
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  })
  {
    isbottomsheetshown =isShow;
    fab = icon;
    emit(ChangeBottomSheetState());

  }
  void updateData({
  required String status,
    required int id
})
  {
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ]).then((value) {
          getData(database);
          emit(AppUpdateDataBaseState());
     });

  }

bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if (fromShared  != null)
      {
        isDark = fromShared;
        emit(AppChangeMoodState());
      }

    else
      {
        isDark = !isDark;
        CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
          emit(AppChangeMoodState());
        });
      }


  }

}
