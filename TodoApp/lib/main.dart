import 'package:TodoApp/UI/Intray/intray_page.dart';
import 'package:TodoApp/UI/Login/loginscreen.dart';
import 'package:TodoApp/bloc/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './models/global.dart';
import './UI/Intray/intray_page.dart';
import './models/classes/user.dart';
import './bloc/blocs/user_bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dialogBackgroundColor: Colors.transparent,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiKey = "";
  TaskBloc taskBloc;

  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    // bloc.registerUser('test3', 'test', '3', 'test3@.com', '1234test');
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          taskBloc = TaskBloc(apiKey);
          print('api key:' + apiKey);
          print('data');
        } else {
          print('no data');
        }
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,
                // signinPressed: signinPressed,
                newUser: false,
              );
        // return LoginPage();
      },
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  // void signinPressed() {
  //   setState(() {
  //     build(context);
  //   });
  // }

  Future signinUser() async {
    String email = "";
    apiKey = await getApiKey();
    if (apiKey != null) {
      if (apiKey.length > 0) {
        userBloc.signinUser("", "", apiKey);
      } else {
        print("no api");
      }
    } else {
      apiKey = "";
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('API_Token');
  }

  Widget getHomePage() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(
                    apiKey: apiKey,
                  ),
                  // new Container(
                  //   color: Colors.orange,
                  // ),
                  new Container(
                    child: Center(
                      // child: FlatButton(
                      //   color: Colors.blueAccent,
                      //   child: Text("Log out"),
                      //   onPressed: () {
                      //     logout();
                      //   },
                      // ),
                      child: IconButton(
                          icon: Icon(Icons.power_settings_new),
                          iconSize: 250,
                          onPressed: () {
                            logout();
                          }),
                    ),
                    color: blue
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Intray',
                        style: intrayTitle,
                        textAlign: TextAlign.center,
                      ),
                      Container()
                    ]),
              ),
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.5 - 30),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                  backgroundColor: Colors.lightBlueAccent[100],
                  onPressed: _showAddDialog,
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home,
                    size: 35,),
                  ),
                  // Tab(
                  //   icon: new Icon(Icons.rss_feed),
                  // ),
                  Tab(
                    icon: new Icon(Icons.power_settings_new,size: 35,),
                  ),
                ],
                labelColor: blue,
                unselectedLabelColor: darkGrey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                labelPadding: EdgeInsets.all(1),
                // indicatorColor: Colors.transparent,
                
              ),
              // backgroundColor: darkGrey,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showAddDialog() {
    TextEditingController taskTitle = new TextEditingController();
    TextEditingController taskNote = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: darkGrey,
            // title: new Text("Add new Task",style: darkTodoTitle,),
            content: Container(
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints.expand(height: 350, width: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Add new Task",
                    style: darkTodoTitle,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Title",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkGrey),
                        ),
                      ),
                      controller: taskTitle,
                    ),
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Note",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkGrey),
                        ),
                      ),
                      controller: taskNote,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                          child: Text(
                            "Cancle",
                            style: darkButText,
                          ),
                          color: blue,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      FlatButton(
                          child: Text(
                            "Add",
                            style: darkButText,
                          ),
                          color: blue,
                          onPressed: () {
                            if (taskTitle.text != null) {
                              addTask(taskTitle.text, taskNote.text);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void addTask(String taskTitle, String taskNote) async {
    // print(apiKey);
    await _repository.addUserTask(this.apiKey, taskTitle, taskNote);
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
