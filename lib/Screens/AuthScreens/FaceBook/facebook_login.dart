

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:test_auth/Screens/HomeScreens/main_page.dart';
import 'package:test_auth/Widgets/reusable_components.dart';

class FacebookLogin extends StatelessWidget {
  static const String routeName = "Login";
  const FacebookLogin({super.key});
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
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await signInWithFacebook();
                    navigateAndFinish(context, BasicMainPage());
                  },
                  child: const Text("signIn With FaceBook"))),
        ]));
  }
}
