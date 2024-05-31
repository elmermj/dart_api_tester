// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'constants.dart';
import 'log.dart';

import 'functions/get_all_posts.dart';
import 'functions/login.dart';

Future<void> registerUser() async {
  var url = Uri.parse('http://localhost:8080/api/auth/signup');

  var request = http.MultipartRequest('POST', url);
  request.fields.addAll({
    'username': 'example_user',
    'password': 'example_password',
    'email': 'user@example.com',
    'name': 'John',
  });

  // Add image file
  var file = File('bin/Picture2.png');
  request.files.add(await http.MultipartFile.fromPath('image', file.path));
  request.headers.addAll({'Content-Type': 'multipart/form-data'});

  var response = await request.send();
  if (response.statusCode == 200) {
    print('User registered successfully');
  } else {
    print('${response.statusCode} Failed to register user: ${response.reasonPhrase} ${request.headers}');
    print('REQUEST FIELDS ::: \n ${request.fields} \n ${request.files} \n ${request.headers} \n ${request.url}');
  }
}

Future<void> main() async {
  String username = "mattelmer";
  String? token = await Login(username: username, password: "123456789").commence();
  print(jsonEncode(token));
  GetUserPosts(username: username, token: token!);
  Log.yellow('Get timeline Auth Token : $token');
  int page = 0;
  int size = 2;
  String requestURL = '${SERVER_URL}api/posts/$username/timeline?page=$page&size=$size';
  Log.yellow('FROM ::: $requestURL');
  final response = await http.post(Uri.parse(requestURL), headers: {
    'Authorization': token!,
    'Content-Type': 'application/json',
  });
  Log.yellow('Get timeline response (DS) [${response.statusCode}]: ${response.body}');
}