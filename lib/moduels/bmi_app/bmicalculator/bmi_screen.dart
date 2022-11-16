import 'dart:math';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bmi_results/bmi_results-screen.dart';



class BmiScreen extends StatefulWidget {


  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height =120;
  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator'
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale =true;

                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isMale? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/image/male-gender (1).png'),
                              width: 90.0,
                              height: 90.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },

                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: !isMale? Colors.blue : Colors.grey[400]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                             image: AssetImage('assets/image/femenine.png'),
                              height: 90.0,
                              width: 90.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Cm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                          ),
                        ),

                      ],
                    ),
                    Slider(value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged:(value)
                        {
                         setState(() {
                           height=value;
                         });

                        } ,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[400],

                ),

              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              FloatingActionButton(

                                onPressed: (){
                                  setState(() {
                                    age--;
                                  });

                                },
                                mini: true,
                                heroTag: 'age-',
                                child: Icon(
                                  Icons.remove,

                                ) ,
                              ),
                              FloatingActionButton(

                                onPressed: (){
                                  setState(() {
                                    age++;
                                  });
                                },
                                mini: true,
                                heroTag: 'age+',
                                child: Icon(
                                  Icons.add,

                                ) ,
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$weight',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(

                                onPressed: (){
                                  setState(() {
                                    weight--;
                                  });
                                },
                                heroTag: 'weight-',
                                mini: true,
                                child: Icon(
                                  Icons.remove,

                                ) ,
                              ),
                              FloatingActionButton(

                                onPressed: (){
                                  setState(() {
                                    weight++;
                                  });
                                },
                                heroTag: 'weight+',
                                mini: true,
                                child: Icon(
                                  Icons.add,

                                ) ,
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed: ()
              {
              var result = weight /pow(height/100, 2);
              print(result.round());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>BmiResultsScreen(
                        age: age,
                        result: result.round(),
                        isMale: isMale,
                      ),
                  ),
              );
              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              height: 50.0,
            ),
          ),
          

        ],
      ),
    );
  }
}
