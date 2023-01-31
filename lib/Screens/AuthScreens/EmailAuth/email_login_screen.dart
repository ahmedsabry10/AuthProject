
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:test_auth/Data/Cubit/LoginCubit/login_cubit.dart';
import 'package:test_auth/Data/Cubit/LoginCubit/login_states.dart';
import 'package:test_auth/Screens/AuthScreens/EmailAuth/email_register_screen.dart';
import 'package:test_auth/Screens/HomeScreens/main_page.dart';
import 'package:test_auth/Widgets/reusable_components.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  var formKey=GlobalKey<FormState>();

  var emailController =TextEditingController();
  var passwordController =TextEditingController();


  //todo  add the package to pubspec.yaml
  //*flutter_facebook_auth: '^3.5.0'

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer <LoginCubit , LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if(state is LoginSuccessState)

          {
            showToast(
              text: "تم تسجيل الدخول بنجاح",
              state: ToastStates.SUCCESS,
            );
            navigateAndFinish(
              context,
              BasicMainPage(),
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

                        //password
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).isPassword,
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
                            LoginCubit.get(context).suffix != null?
                            IconButton(
                              icon:Icon(
                                  LoginCubit.get(context).suffix
                              ) ,
                              onPressed: (){
                                LoginCubit.get(context).changePasswordVisibility();
                              },
                            )
                                : null,



                          ),

                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! LoginLoadingState,
                          builder:(context)=>Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );

                                } else
                                  print('NUll');
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          fallback: (context)=>const Center(child:  CupertinoActivityIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
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
                                    RegisterScreen()
                                );
                              },
                              child: Text(
                                'Sign up'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic


                                ),
                              ),
                            ),

                          ],
                        ),


                        const SizedBox(
                          height: 10.0,
                        ),





                        TextButton(
                          onPressed: () async {
                            await signInWithFacebook();
                            navigateAndFinish(context, BasicMainPage());


                          },
                          child: Text(
                            'Sign With Facebook'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic
                            ),

                          ),
                        ),

                        /*
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blue,),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: MaterialButton(
                                    onPressed: () async {
                                      await signInWithFacebook();
                                    },
                                    child: const Image(
                                      height: 45,
                                      image:NetworkImage(
                                        'https://play-lh.googleusercontent.com/5pZMqQYClc5McEjaISPkvhF8pDmlbLqraTMwk1eeqTlnUSjVxPCq-MItIrJPJGe7xW4'
                                      ),)
                                    ),
                              ),

                            ],
                          ),


                           */


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