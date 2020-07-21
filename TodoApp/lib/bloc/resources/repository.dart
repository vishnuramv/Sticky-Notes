import 'dart:async';
import 'api.dart';
import '../../models/classes/user.dart';


class Repository {
  final apiProvider = ApiProvider();
  Future<User> registerUser(String username, String firstname, String lastname, String emailadress, String password) => apiProvider.registerUser(username, firstname, lastname, emailadress, password); 
}