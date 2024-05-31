import 'dart:convert';

import 'package:intl/intl.dart';

import '../constants.dart';
import '../log.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class Login {
  String username;
  String password;
  late String token;

  Login({required this.username, required this.password});
  
  Future<String?> commence() async {
    print('Login commenced');
    var url = Uri.parse('${SERVER_URL}api/users/login');
    var body = {'username': username, 'password': password};
    final response = await http.post(url, body: jsonEncode(body), headers: DEFAULT_HEADER_NON_TOKEN);
    final responsebody = json.decode(response.body);
    final metadata = responsebody['metadata'];
    Log.yellow("Metadata : $metadata");
    Log.yellow("Username : ${metadata['username']}");
    // Log.yellow("Created At : ${metadata['created_at'].toString()}");
    // String iso8601String = response['metadata']['created_at']; // Example received string
    String iso8601String = metadata['createdAt'].toString();
    Log.yellow(iso8601String);
    DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    DateTime createdAt = DateTime.parse(metadata['createdAt']).toLocal();
    Log.yellow(DateTime.now().toUtc().toString());
    final authResponse = UserModel(
        id: metadata['id'], 
        token: responsebody['token'], 
        username: metadata['username'], 
        realname: metadata['realname'], 
        email: metadata['email'], 
        // createdAt: DateFormat("yyyyMMddHHmmss").parse(metadata['created_at'])
        createdAt: createdAt,
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