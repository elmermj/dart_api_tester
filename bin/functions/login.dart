import 'dart:convert';

import '../constants.dart';
import '../log.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class Login {
  String username;
  String password;
  late String token;

  Login({required this.username, required this.password}){
    commence();
  }
  
  Future<String?> commence() async {
    print('Login commenced');
    var url = Uri.parse('${SERVER_URL}api/users/login');
    var body = {'username': username, 'password': password};
    final res = await http.post(url, body: jsonEncode(body), headers: DEFAULT_HEADER_NON_TOKEN);
    final response = json.decode(res.body);
    final metadata = response['metadata'];
    Log.yellow("Metadata : ${metadata.toString()}");
    Log.yellow("Username : ${metadata['username']}");
    Log.yellow("Created At : ${metadata['created_at'].toString()}");
    final authResponse = UserModel(
        id: metadata['id'], 
        token: response['token'], 
        username: metadata['username'], 
        realname: metadata['realname'], 
        email: metadata['email'], 
        // createdAt: DateFormat("yyyyMMddHHmmss").parse(metadata['created_at'])
        createdAt: DateTime.parse(metadata['created_at'].toString()),
      );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      token = data['token'];
      print('Login successful');
      return token;
    } else {
      print('Login failed: ${response.reasonPhrase}');
    }
    return null;
    
  }
}