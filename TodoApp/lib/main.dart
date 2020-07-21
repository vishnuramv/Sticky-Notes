import 'package:TodoApp/UI/Intray/intray_page.dart';
import 'package:TodoApp/UI/Login/loginscreen.dart';
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
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      // home: FutureBuilder(
      //   future: getUser(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     // switch (snapshot.connectionState) {
      //     //   case ConnectionState.none:
      //     //     return Text('Press button');
      //     //   case ConnectionState.active:
      //     //   case ConnectionState.waiting:
      //     //     return Text('Awaiting');
      //     //   case ConnectionState.done:
      //     //     if (snapshot.hasError) return Text('Error: ${snapshot.error}');
      //     //     return Text('Result: ${snapshot.data}');
      //     // }

      //     // return null;

      //     if (snapshot.connectionState == ConnectionState.none &&
      //         snapshot.hasData == null) {
      //       return Container();
      //     }
      //     return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (context, index) {
      //           return Column(
      //             children: <Widget>[],
      //           );
      //         });
      //   },
      // ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future getUser() async {
    var result = await http.get('http://127.0.0.1:5000/api/register');
    // if (result.statusCode == 200) {
    print(result.body);
    return result;
    // } else {
    // print('error');
    // }

    // String apiKey= await getApiKey();
    // if (apiKey.length <=0){

    // }
  }

  asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future<String> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey;
    try {
      apiKey = prefs.getString('API_Token');
    } catch (Exception) {
      apiKey = "";
    }
    return apiKey;
    // print('Pressed $apiKey times.');
    // await prefs.setString('API_Token', apiKey);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // bloc.registerUser('test3', 'test', '3', 'test3@.com', '1234test');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(),
                  new Container(
                    color: Colors.orange,
                  ),
                  new Container(
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
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
                    top: 140,
                    left: MediaQuery.of(context).size.width * 0.5 - 30),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                  backgroundColor: Colors.lightBlueAccent[100],
                  onPressed: () {},
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGrey,
                unselectedLabelColor: Colors.lightBlueAccent,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
