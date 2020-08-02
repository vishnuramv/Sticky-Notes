import 'package:TodoApp/models/classes/task.dart';
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

  signinUser(String emailadress, String password, String apiKey) async {
    User user = await _respository.signinUser(emailadress, password, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

class TaskBloc {
  final _respository = Repository();
  final _taskSubject = BehaviorSubject<List<Task>>();
  String apiKey;

  var _tasks = <Task>[];

  TaskBloc(String api_key) {
    this.apiKey = api_key;
    _updateTasks(api_key).then((_) {
      _taskSubject.add(_tasks);
    });
  }

  Stream<List<Task>> get getTask => _taskSubject.stream;

  Future<Null> _updateTasks(String apiKey) async {
    _tasks = await _respository.getUserTask(apiKey);
  }

}

final userBloc = UserBloc();
