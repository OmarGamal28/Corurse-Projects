//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPaass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    control: emailcontroller,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value!.isEmpty){
                        return"enter your email";

                      }
                      return null;

                    },
                    label: 'Email Address',
                    prefixicon: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    isPass: isPaass,
                    control: passwordcontroller,
                    type: TextInputType.visiblePassword,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'enter your password';

                      }else {
                        return null;
                      }

                    },
                    label: 'Password',
                    prefixicon: Icons.lock,
                    sufix: isPaass? Icons.visibility: Icons.visibility_off,
                    sufixxpresed: (){
                      setState(() {
                        isPaass = !isPaass;
                      });

                    }

                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(width: double.infinity ,
                      background: Colors.blue,
                      function:()
                      {
                        if(formKey.currentState!.validate())
                        {
                          print(emailcontroller.text);
                          print(passwordcontroller.text);
                        }
                      },
                      text: 'login'

                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have email?'
                      ),
                      TextButton(onPressed: (){},
                        child: Text(
                          'Register Now'
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
