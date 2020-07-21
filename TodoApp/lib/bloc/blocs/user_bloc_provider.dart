import '../resources/repository.dart';
import '../../models/classes/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _respository = Repository();
  final _userGetter = PublishSubject<User>();
  Stream<User> get getUser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname,
      String emailadress, String password) async {
    User user = await _respository.registerUser(
        username, firstname, lastname, emailadress, password);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

final bloc = UserBloc();
