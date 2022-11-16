import 'package:app01/moduels/shop_app/register/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/local/cash_helper.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener:(context,state){

            if(state is ShopRegisterSuccessState)
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
        builder: (context,state){
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offer',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            control: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty){
                                return ('please enter name');
                              } else{
                                return null;
                              }

                            },
                            label: 'Name',
                            prefixicon: Icons.person
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
                            label: 'Email Address',
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

                          },
                          label: 'Password',
                          prefixicon: Icons.lock,
                          sufix: ShopRegisterCubit.get(context).sufixx,
                          sufixxpresed: (){
                            ShopRegisterCubit.get(context).passVisibility();

                          },
                          isPass: ShopRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            control: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty){
                                return ('please enter phone');
                              }

                            },
                            label: 'Phone',
                            prefixicon: Icons.phone_android
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopRegisterLoadingState,
                          builder:(context)=>defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name:nameController.text ,
                                      phone: phoneController.text
                                  );
                                }

                              },
                              text: 'REGISTER',
                              isUpperCase: true),
                          fallback:(context)=> Center(child: CircularProgressIndicator()) ,
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
