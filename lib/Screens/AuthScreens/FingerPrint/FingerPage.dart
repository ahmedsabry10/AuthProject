import 'package:flutter/material.dart';
import 'package:test_auth/Data/Api/local_auth_api.dart';
import 'package:test_auth/Screens/AuthScreens/EmailAuth/email_login_screen.dart';
import 'package:test_auth/Screens/AuthScreens/FaceBook/facebook_login.dart';
import 'package:test_auth/Widgets/reusable_components.dart';



class FingerAuth extends StatefulWidget {
  const FingerAuth({Key? key}) : super(key: key);

  @override
  State<FingerAuth> createState() => _FingerAuthState();
}

class _FingerAuthState extends State<FingerAuth> {
  bool showBiometric = false;
  bool isAuthenticated = false;
  @override
  void initState() {
    isBiometricsAvailable();
    super.initState();
  }

  isBiometricsAvailable() async {
    showBiometric = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showBiometric)
              ElevatedButton(
                child: const Text(
                  'FingerPrint Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  isAuthenticated = await BiometricHelper().authenticate();
                  setState(() {
                    if (isAuthenticated)
                      navigateAndFinish(context, LoginScreen());

                  });
                },
              ),


          ],
        ),
      ),
    );
  }
}