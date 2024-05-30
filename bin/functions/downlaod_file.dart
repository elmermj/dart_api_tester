import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants.dart';

class DownloadFile {
  String fileUrl;
  String filename;

  DownloadFile({required this.fileUrl, required this.filename}){
    commence();
  }
  
  Future<void> commence() async {
    var response = await http.get(Uri.parse(SERVER_URL+fileUrl));
    try {
      if (response.statusCode == 200) {
        File file = File("bin/downloads/$filename");
        await file.create(recursive: true);
        await file.writeAsBytes(response.bodyBytes);
        print('File downloaded successfully: $fileUrl');
      } else {
        print('Failed to download file: $fileUrl');
      }
    } on Exception catch (e) {
      print('Failed to download file: $fileUrl');
      print(e);
    }
  }
}