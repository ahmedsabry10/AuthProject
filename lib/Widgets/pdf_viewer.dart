import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';



class PdfViewer extends StatelessWidget {

  @override
  late final String url ;
  PdfViewer(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child:PDF().cachedFromUrl(
            url,
            placeholder: (progress) => Center(child: Text('$progress %')),
            errorWidget: (error) => Center(child: Text(error.toString())),
          )
      ),
    );
  }
}
