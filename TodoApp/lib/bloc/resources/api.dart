import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../../models/classes/user.dart';

class ApiProvider {
  Client client = Client();

  final _apikey = 'ur_apikey';

  Future<User> registerUser(String username, String firstname, String lastname,
      String emailadress, String password) async {
    print("\n\n\n\nhello\n\n\n\n");
    final response = await client.post(
        'http://127.0.0.1:5000/api/register',
        // 'http://10.0.2.2:5000/api/register', //for android emulator use 10.0.2.2:
        // headers: "",
        body: jsonEncode({
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'emailadress': emailadress,
          'password': password
        }));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }
}
