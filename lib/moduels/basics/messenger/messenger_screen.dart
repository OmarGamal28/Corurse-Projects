import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20.0,//عشان خليها نفس مقاس البودي
        elevation: 0.0,//بيشيل اي فرق في الشاشه
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://img.a.transfermarkt.technology/portrait/big/28003-1631171950.jpg?lm=1'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
              icon:CircleAvatar(
                radius: 15.0,
                child: Icon(
                    Icons.camera_alt,
                    color: Colors.white ,
                    size: 16.0),
              ),


          ),
          IconButton(onPressed: (){},
            icon:CircleAvatar(
              radius: 15.0,
              child: Icon(
                  Icons.edit,
                  color: Colors.white ,
                  size: 16.0),
            ),


          ),
          
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300]
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search
                    ),
                    Text(
                      'Search'
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(

                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildstoryitem(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 20.0,)),

                ),
              SizedBox(height: 20,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),

                shrinkWrap: true,//عشان اقدر اتعمل اسكرول للشاشه كلها
                  itemBuilder: (context, index) => buildchatitem(),
                  separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                  itemCount: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildchatitem() =>  Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://img.a.transfermarkt.technology/portrait/big/28003-1631171950.jpg?lm=1'),
            radius: 20.0,
          ),
          CircleAvatar(
            radius: 5.0,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Omar Gamal Omar Gamal Omar Gamal  Omar Gamal Omar Gamal',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Where are you now Where are you now  Where are you now  Where are you now ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Text(
                    '02:00 pm'
                ),


              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildstoryitem()=> Container(
    width: 60.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://img.a.transfermarkt.technology/portrait/big/28003-1631171950.jpg?lm=1'),
              radius: 30.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 3.0,bottom: 3.0),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          'omar',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,

        ),

      ],
    ),
  );

}

