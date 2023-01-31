

import 'package:flutter/material.dart';
import 'package:test_auth/Data/Api/image_firebase_api.dart';
import 'package:test_auth/Data/Models/files_model.dart';
import 'package:test_auth/Screens/HomeScreens/ShowScreens/image_page.dart';
import 'package:test_auth/Widgets/pdf_viewer.dart';

class ShowMainPage extends StatefulWidget {
  @override
  _ShowMainPageState createState() => _ShowMainPageState();
}

class _ShowMainPageState extends State<ShowMainPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = ImageFirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(



    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
        leading: ClipOval(
          child:

          file.url.contains( '.pdf')
              ?
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoEiPihPI2dvUX1smKI175sDLRkIjdbWr2Kw&usqp=CAU',
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ): Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          )
          ,
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () =>  file.url.contains( '.pdf')? Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PdfViewer("${file.url}") ,
        )): Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>ImagePage(file: file) ,),
        )),
  );

  Widget buildHeader(int length) => Container(
    decoration: BoxDecoration(
      color: Colors.grey[600]?.withOpacity(0.5),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      title: Text(
        '$length Files',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}