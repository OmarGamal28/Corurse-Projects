import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'First App',
        ),
        actions: [
          IconButton(
            icon: Icon(
                Icons.notification_important,

            ),
            onPressed: (){
              print("hello");
            },
          ),
          IconButton(
              icon: Text(
                "omar"
              ),
              onPressed: (){print("welcome");}
          ),



        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                      image:NetworkImage('https://img.a.transfermarkt.technology/portrait/big/28003-1631171950.jpg?lm=1'),
                    width: 200.0,
                    height:200.0,
                    fit : BoxFit.cover
                  ),
                  Container(
                    width: 200.0,
                    color: Colors.black.withOpacity(0),//شفافيه
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Leo Messi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }


}