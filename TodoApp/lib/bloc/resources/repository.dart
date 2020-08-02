import 'dart:async';
import 'api.dart';
import '../../models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();
  Future<User> registerUser(String username, String firstname, String lastname,
          String emailadress, String password) =>
      apiProvider.registerUser(
          username, firstname, lastname, emailadress, password);
  Future signinUser(String emailadress, String password, String apiKey) =>
      apiProvider.signinUser(emailadress, password, apiKey);

  Future getUserTask(String apiKey) => apiProvider.getUserTask(apiKey);

  Future<Null> addUserTask(
      String apiKey, String taskTitle, String taskNote)  async {
    apiProvider.addUserTask(apiKey, taskTitle, taskNote);
  }
}
