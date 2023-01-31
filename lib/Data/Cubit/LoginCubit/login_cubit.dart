
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:test_auth/Data/Cubit/LoginCubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);




  void userLogin({
    required String email,
    required String password,

  }){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));

    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix =Icons.remove_red_eye ;
  bool isPassword=true;
  void changePasswordVisibility(){
    suffix=isPassword ?Icons.remove_red_eye_rounded :Icons.remove_red_eye;
    isPassword =! isPassword;
    emit(ChangePasswordVisibilityState());
  }
}