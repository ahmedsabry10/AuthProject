import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_auth/Data/Cubit/RegisterCubit/register_states.dart';
import 'package:test_auth/Data/Models/email_user_model.dart';


class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffix =Icons.remove_red_eye ;
  bool isPassword=true;
  void changePasswordVisibility(){
    suffix=isPassword ?Icons.remove_red_eye_rounded :Icons.remove_red_eye;
    isPassword =! isPassword;
    emit(ChangePasswordVisibilityState());
  }

  //RegisterModel registerModel;


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    print('hello');

    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ... ',
      cover: 'https://www.givenow.com.au/img/default-cover.png',
      image: 'https://kuduconsulting.co.zm/wp-content/uploads/2017/11/default-portrait-image-generic-profile.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(CreateUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }



}