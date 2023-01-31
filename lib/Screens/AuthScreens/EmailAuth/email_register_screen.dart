
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_auth/Data/Cubit/RegisterCubit/register_cubit.dart';
import 'package:test_auth/Data/Cubit/RegisterCubit/register_states.dart';
import 'package:test_auth/Screens/AuthScreens/EmailAuth/email_login_screen.dart';
import 'package:test_auth/Widgets/reusable_components.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey=GlobalKey<FormState>();

  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),

      child: BlocConsumer <RegisterCubit , RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(
              context,
              LoginScreen(),
            );

          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://media.istockphoto.com/vectors/letter-s-and-puddle-water-logo-template-design-vector-emblem-design-vector-id1329175476?k=20&m=1329175476&s=170667a&w=0&h=35yLGDKif6pjZ6o3mMziApSh9ebIT1nT-7QCESG7FM4='
                                )
                            ),



                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),




                        //name
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          enabled: true,


                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your name";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'User Name',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic
                            ),
                            prefixIcon: Icon(
                              Icons.people,
                              color: Colors.blue,

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(
                                color: Colors.blue,

                                width: .3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        //phone
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          enabled: true,


                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Phone";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Phone',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.blue,

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(
                                color: Colors.blue,

                                width: .3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),

                        //email
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          enabled: true,


                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.blue,

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(
                                color: Colors.blue,

                                width: .3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),

                        //password
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: RegisterCubit.get(context).isPassword,
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            } else
                              return null;
                          },


                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic
                            ),

                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue,

                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(
                                color: Colors.blue,

                                width: .3,
                              ),
                            ),


                            suffixIcon:
                            RegisterCubit.get(context).suffix != null?
                            IconButton(
                              icon:Icon(
                                RegisterCubit.get(context).suffix,
                                color: Colors.blue,

                              ) ,
                              onPressed: (){
                                RegisterCubit.get(context).changePasswordVisibility();
                              },
                            )
                                : null,



                          ),

                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! RegisterLoadingState,
                          builder:(context)=>Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,

                                  );

                                  navigateAndFinish(
                                    context,
                                    LoginScreen(),
                                  );

                                } else
                                  print('NUll');
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          fallback: (context)=>const Center(child: CupertinoActivityIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              ' have an account?',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),


                            TextButton(
                              onPressed: (){
                                navigateAndFinish(
                                    context,
                                    LoginScreen()
                                );
                              },
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style:  TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic


                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(
                          height: 20.0,
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
