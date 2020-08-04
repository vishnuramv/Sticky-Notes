import 'package:TodoApp/UI/Intray/intray_page.dart';
import 'package:TodoApp/UI/Login/loginscreen.dart';
import 'package:TodoApp/bloc/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String apiKey = "";
  TaskBloc taskBloc;

  String fname;
  MyHomePageState({this.fname});

  User users;

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
          // print(users.firstname);
        } else {
          print('no data');
        }
        return apiKey.length > 0
            ? getHomePage()
            :
            //  firstPage();
            LoginPage(
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

  void signIn() {
    LoginPage(
      login: login,
      newUser: false,
    );
  }

  void signUp() {
    LoginPage(
      login: login,
      newUser: true,
    );
  }

  Widget firstPage() {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 80),
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // color: blue,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Sticky Notes",
                  style: welcomeTitle,
                ),
                Text(
                  "Stick your thoughts here....!",
                  style: welcomeSubTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  color: darkGrey,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  child: Text(
                    'Sign in',
                    style: blueTodoTitle,
                  ),
                  onPressed: signIn,
                  //  () {
                  //   // loginOrup = false;
                  //   LoginPage(
                  //     login: login,
                  //     newUser: false,
                  //   );
                  // }
                ),
                Text("Or",
                    style: TextStyle(
                        color: Colors.lightBlueAccent[200], fontSize: 12)),
                RaisedButton(
                  color: darkGrey,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  child: Text(
                    'Sign Up',
                    style: blueTodoTitle,
                  ),
                  onPressed: signUp,
                  // () {
                  //   // loginOrup = true;
                  //   LoginPage(
                  //     login: login,
                  //     newUser: true,
                  //   );
                  // }
                ),
              ],
            ),
          ),
          // Container(
          //   // color: blue,
          //   child: Column(
          //     children: <Widget>[
          //       Text("Don't have an account?",
          //           style: TextStyle(
          //               color: Colors.lightBlueAccent[200], fontSize: 12)),
          //       // Text("Create an account?", style: TextStyle(color: blue, fontSize: 15)),
          //       FlatButton(
          //         child: Text('Create account', style: blueText),
          //         onPressed: () {
          //           // widget.newUser = false;
          //         },
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
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
                      color: blue),
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
                        'Sricky Notes',
                        style: intrayTitle,
                        textAlign: TextAlign.center,
                      ),
                      // Container()
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
                    icon: Icon(
                      Icons.home,
                      size: 35,
                    ),
                  ),
                  // Tab(
                  //   icon: new Icon(Icons.rss_feed),
                  // ),
                  Tab(
                    icon: new Icon(
                      Icons.power_settings_new,
                      size: 35,
                    ),
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
              constraints: BoxConstraints.expand(height: 500 , width: 350),
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
