import 'package:flutter/material.dart';

class BmiResultsScreen  extends StatelessWidget {
 late int age;
 late bool isMale;
 late int result;
 BmiResultsScreen({
   required this.result,
   required this.isMale,
   required this.age

});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);

            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
            )
        ),
        title: Text(
          'BMI RESULTS'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender:${isMale? 'Male':'Female'}',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Result: ${result}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              'Age:${age}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
