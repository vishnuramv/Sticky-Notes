import 'package:TodoApp/UI/Intray/intray_page.dart';
import 'package:TodoApp/UI/Login/loginscreen.dart';
import 'package:flutter/material.dart';

import './models/global.dart';
import './UI/Intray/intray_page.dart';

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
      home: FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Text('Result: ${snapshot.data}');
          }
          return null;
        },
      ),
      debugShowCheckedModeBanner: false,
    );
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
