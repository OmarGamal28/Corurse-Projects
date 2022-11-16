import 'package:app01/layout/shop_app/shop_layout.dart';
import 'package:app01/moduels/shop_app/login/cubit/cubit.dart';
import 'package:app01/moduels/shop_app/register/shop_register_screen.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/network/local/cash_helper.dart';
import 'package:app01/shared/network/remote/dio_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../shared/components/constans.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status==true){
                print(state.loginModel.data!.token);
                print(state.loginModel.message);
                CacheHelper.saveData(key: 'token', value:state.loginModel.data!.token ).then((value) {
                  token=state.loginModel.data!.token!;
                  navigateAndFinish(context, ShopLayout());
                });
              }else{
                print(state.loginModel.message);
                showToast(
                    text:state.loginModel.message!,
                    state: ToastStates.ERROR
                );
              }
            }
        },
        builder: ( context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offer',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            control: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty){
                                return ('please enter email');
                              }

                            },
                            label: 'Email Adreess',
                            prefixicon: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          control: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value){
                            if(value!.isEmpty){
                              return ('please enter password correct');
                            }

                          },

                          onSumbit: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                          label: 'Password',
                          prefixicon: Icons.lock,
                          sufix: ShopLoginCubit.get(context).sufixx,
                          sufixxpresed: (){
                            ShopLoginCubit.get(context).passVisibility();

                          },
                          isPass: ShopLoginCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder:(context)=>defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }

                              },
                              text: 'LOGIN',
                              isUpperCase: true),
                          fallback:(context)=> Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Dont have an account?'
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTp(context, ShopRegisterScreen());
                                },
                                text: 'REGISTER'
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
        },

      ),
    );
  }
}
