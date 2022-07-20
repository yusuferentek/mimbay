

import 'package:flutter/material.dart';

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewer extends StatelessWidget {
  final String path;
    PdfViewer({required this.path});

 

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Document'),
          actions: [
            InkWell(
              child: const Icon(Icons.share),
              onTap: () async {
                if(path==null) return;
                await Share.shareFiles([path]);
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: PdfView(path: path),
      );
 
    }
  }

  

