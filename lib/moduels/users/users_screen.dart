import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user/user_model.dart';


class UserScreen extends StatelessWidget {
  List<UserModel> users= [
    UserModel(id: 1, name: 'omar', phone: '01011102279'),
    UserModel(id: 1, name: 'ahmed', phone: '01011102279'),
    UserModel(id: 1, name: 'omar', phone: '01011102279'),
    UserModel(id: 1, name: 'omar', phone: '01011102279'),
    UserModel(id: 1, name: 'omar', phone: '01011102279'),
    UserModel(id: 1, name: 'omar', phone: '01011102279'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users"
        ),
      ),
      body: ListView.separated(itemBuilder: (context,index)=> builduser(users[index]) ,
          separatorBuilder: (context,index)=> Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ) ,
          itemCount: users.length,
      )
    );
  }
  Widget builduser (UserModel user)=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(

      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${user.id}',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${user.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
