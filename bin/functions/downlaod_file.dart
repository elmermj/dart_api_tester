import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../constants.dart';

class DownloadFile {
  String fileUrl;
  String filename;

  DownloadFile({required this.fileUrl, required this.filename}){
    commence();
  }
  
  Future<void> commence() async {
    Response? response;
    try {
      response = await http.get(Uri.parse(fileUrl));
    } catch (e) {
      print('Network error while trying to download file: $fileUrl');
      print(e.toString());
      return;
    }

    try {
      if (response.statusCode == 200) {
        File file = File("bin/downloads/$filename");
        await file.create(recursive: true);
        await file.writeAsBytes(response.bodyBytes);
        print('File downloaded successfully: $fileUrl');
      } else {
        print('Failed to download file: $fileUrl. HTTP status code: ${response.statusCode}');
      }
    } on FileSystemException catch (e) {
      print('File system error while saving the file: $fileUrl');
      print(e.toString());
    } catch (e) {
      print('An unexpected error occurred while downloading file: $fileUrl');
      print(e.toString());
    }
  }
}