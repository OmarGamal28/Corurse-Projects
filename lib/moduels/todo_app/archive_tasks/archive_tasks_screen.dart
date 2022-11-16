import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';



class ArchiveTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state)=>{},
      builder:(context,state){
        var tasks = AppCubit.get(context).archivetasks;
        return ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(tasks [index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            itemCount: tasks.length);
      },

    );
  }
}