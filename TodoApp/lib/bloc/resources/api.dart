import 'dart:async';
import 'dart:convert';
import 'package:TodoApp/models/classes/task.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/classes/user.dart';

class ApiProvider {
  Client client = Client();

  final _apikey = 'ur_apikey';

  Future signinUser(String emailadress, String password, String apiKey) async {
    final response =
        await client.post("https://todoapp-flt.herokuapp.com/api/signin",
            headers: {"Authorization": apiKey},
            body: jsonEncode({
              "emailadress": emailadress,
              "password": password,
            }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<User> registerUser(String username, String firstname, String lastname,
      String emailadress, String password) async {
    print("\n\n\n\nhello\n\n\n\n");
    final response = await client.post(
        // 'http://127.0.0.1:5000/api/register',
        // 'http://10.0.2.2:5000/api/register', for android emulator use 10.0.2.2:
        'https://todoapp-flt.herokuapp.com/api/register',
        // headers: "",
        body: jsonEncode({
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'emailadress': emailadress,
          'password': password
        }));
    final Map result = json.decode(response.body);
    print(result['data']['username'].toString());
    if (response.statusCode == 201) {
      await saveApiKey(result['data']['api_key']);
      return User.fromJson(result['data']);
    } else {
      throw Exception('failed to load');
    }
  }

  Future<List<Task>> getUserTask(String apiKey) async {
    final response = await client.get(
      "https://todoapp-flt.herokuapp.com/api/tasks",
      headers: {"Authorization": apiKey},
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // await saveApiKey(result["data"]["api_key"]);
      List<Task> tasks = [];
      for (Map json_ in result["data"]) {
        try {
          tasks.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      for (Task task in tasks) {
        print(task.taskId);
      }
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future addUserTask(String apiKey, String taskTitle, String taskNote
      ) async {
    print(apiKey);
    final response =
        await client.post("https://todoapp-flt.herokuapp.com/api/tasks",
            headers: {"Authorization": apiKey},
            body: jsonEncode({
              "title": taskTitle,
              "note": taskNote,
              "deadline": "",
              "repeats": "",
              "reminders": "",
              "completed": false,
            }));
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      print("success");
    } else {
      // If that call was not successful, throw an error.
      print(json.decode(response.body));
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', api_key);
  }
}
