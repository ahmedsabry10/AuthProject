import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:test_auth/Data/Api/home_api.dart';
import 'package:test_auth/Screens/AuthScreens/EmailAuth/email_login_screen.dart';
import 'package:test_auth/Screens/AuthScreens/FaceBook/facebook_login.dart';
import 'package:test_auth/Screens/HomeScreens/ShowScreens/main_files_show.dart';
import 'package:test_auth/Widgets/button_widget.dart';
import 'package:test_auth/Widgets/reusable_components.dart';




class BasicMainPage extends StatefulWidget {
  @override
  _BasicMainPageState createState() => _BasicMainPageState();
}

class _BasicMainPageState extends State<BasicMainPage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          text: 'Cam',
                          icon: Icons.camera_alt,
                          onClicked: selectCameraFile,
                        ),
                      ),
                      SizedBox( width: 8.0,),
                      Expanded(
                        child: ButtonWidget(
                          text: 'File',
                          icon: Icons.attach_file,
                          onClicked: selectFile,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20 ),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 30),

                  /*
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: uploadFile,
                        child: Text(
                            'Upload File'
                        )),
                  ),


                   */

                  ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: uploadFile,
                  ),
                  SizedBox(height: 20),
                  task != null ? buildUploadStatus(task!) : Container(),

                  SizedBox(height: 20.0,),
                  ButtonWidget(
                      icon: Icons.file_copy,
                      text: "Show Files",
                      onClicked: (){
                        navigateTo(context, ShowMainPage());
                      }),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                          onPressed: (){
                            _signOut();
                            navigateAndFinish(context, LoginScreen());

                          },
                          child: Text(
                            'SignOut',
                            style: TextStyle(
                                color: Colors.blue
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future selectCameraFile()async{
    final XFile? pickedFile = await ImagePicker().pickImage(source:
    ImageSource.camera); //This opens the gallery and lets the user pick the image
    if (pickedFile == null) return; //Checks if the user did actually pick something

    setState(() => file = File(pickedFile.path));

  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}