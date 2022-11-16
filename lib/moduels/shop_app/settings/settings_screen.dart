import 'package:app01/layout/shop_app/cubit/cubit.dart';
import 'package:app01/layout/shop_app/cubit/states.dart';
import 'package:app01/shared/components/components.dart';
import 'package:app01/shared/components/constans.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
      if(state is ShopSuccessUpdateUserStates) {
        showToast(text: 'User Information Updated Successfully ',
            state: ToastStates.SUCCESS
        );
      }

      },
      builder: (context,state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text= model!.data!.name;
        emailController.text= model!.data!.email;
        phoneController.text= model!.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null ,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    if(state is ShopLoadingUpdateUserStates)
                      LinearProgressIndicator(),
                    defaultFormField(
                        control: nameController,
                        type: TextInputType.name,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'Please enter your name';
                          }else{
                            return null;
                          }

                        },
                        label: 'Name',
                        prefixicon: Icons.person
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        control: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'Please enter your email';
                          }else{
                            return null;
                          }


                        },
                        label: 'Email',
                        prefixicon: Icons.email
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        control: phoneController,
                        type: TextInputType.phone,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'Please enter your phone';
                          }else{
                            return null;
                          }

                        },
                        label: 'Phone',
                        prefixicon: Icons.phone
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserModel(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'UPDATE'
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: (){
                          signOut(context);
                        },
                        text: 'LogOut'
                            ),

                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      }
    );
  }
}
