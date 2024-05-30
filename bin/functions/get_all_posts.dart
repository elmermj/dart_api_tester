import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

import '../models/post_response.dart';
import 'downlaod_file.dart';

class GetAllPosts {
  String username;
  String token;

  GetAllPosts({required this.username, required this.token}) {
    commence();
  }

  commence() async {
    var url = Uri.parse('${SERVER_URL}api/posts/$username/timeline');
    var header = DEFAULT_HEADER(token);
    var response = await http.post(
      url,
      headers: header,
    );
    
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<PostResponse> posts = jsonResponse.map((json) => PostResponse.fromJson(json)).toList();
      
      for (int i = 0; i < posts.length; i++) {
        var post = posts[i];

        String filename = '${post.fileName!}.${post.fileUrl!.split('.').last}';
        DownloadFile(fileUrl: post.fileUrl!, filename: filename);
      }
      
      print(
        'Posts fetched successfully: \n'
        '${posts.map((post) => post.toJson()).toList()}',
      );
    } else {
      print('Failed to fetch posts: ${response.reasonPhrase}');
    }

  }
}