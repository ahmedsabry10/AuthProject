
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_auth/Screens/AuthScreens/EmailAuth/email_login_screen.dart';
import 'package:test_auth/Screens/AuthScreens/FaceTest/page/face_recognition/camera_page.dart';
import 'package:test_auth/Screens/AuthScreens/FaceTest/page/login_page.dart';
import 'package:test_auth/Screens/AuthScreens/FaceTest/utils/local_db.dart';
import 'package:test_auth/Screens/AuthScreens/FaceBook/facebook_login.dart';
import 'package:test_auth/Screens/HomeScreens/main_page.dart';

import 'Screens/HomeScreens/ShowScreens/main_files_show.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  await Hive.initFlutter();
  await HiveBoxes.initialize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  MyApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch:Colors.blue ,
          scaffoldBackgroundColor:Colors.white,
          appBarTheme: const AppBarTheme(
              titleSpacing: 20.0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              )
          ),
          bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              subtitle1: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3
              )
          ),
          fontFamily: 'Jannah'
      ),
      debugShowCheckedModeBanner: false,
      home: FaceLoginPage(),
    );
  }
}


