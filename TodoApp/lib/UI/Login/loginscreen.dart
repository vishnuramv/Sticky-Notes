import 'package:TodoApp/bloc/blocs/user_bloc_provider.dart';
import 'package:TodoApp/models/global.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // final VoidCallback signupPressed;
  final VoidCallback login;

  final bool newUser;
  const LoginPage({Key key, this.newUser, this.login}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("\n\n\n\n\n" + widget.newUser.toString());
    return Scaffold(
      backgroundColor: darkGrey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Center(
              child: getSignInPage(),
            ),
          ),
        ),
      ),
      // body: Center(
      //   child: getSignInPage(),
      // ),
    );
  }

  Widget getSignInPage() {
    TextEditingController emailText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
    print("\n\n\n\n\n\n hello");
    return Container(
      // margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 80),
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            // color: blue,
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Sticky Notes",
                  style: welcomeTitle,
                ),
                Text(
                  "Post your thoughts and notes here...!",
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
                Text(
                  "Let's Get In",
                  style: logTitle,
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: emailText,
                    autofocus: false,
                    style: TextStyle(fontSize: 18, color: darkGrey),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email Address",
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 8, top: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: passwordText,
                    autofocus: false,
                    style: TextStyle(fontSize: 18, color: darkGrey),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        contentPadding:
                            EdgeInsets.only(left: 20, bottom: 8, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
                RaisedButton(
                    color: darkGrey,
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Text(
                      'Sign in',
                      style: blueTodoTitle,
                    ),
                    onPressed: () {
                      if (emailText.text != null || passwordText.text != null) {
                        userBloc
                            .signinUser(emailText.text, passwordText.text, "")
                            .then((_) {
                          widget.login();
                        });
                      }
                    })
              ],
            ),
          ),
          Container(
            // color: blue,
            child: Column(
              children: <Widget>[
                Text("Don't have an account?",
                    style: TextStyle(
                        color: Colors.lightBlueAccent[200], fontSize: 12)),
                FlatButton(
                  child: Text('Create account', style: blueText),
                  onPressed: () {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              // minWidth: MediaQuery.of(context).size.width,
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            child: IntrinsicHeight(
                              child: Container(
                                margin: EdgeInsets.only(top: 100, bottom: 150),
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                                constraints: BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: blue),
                                  child: Container(
                                  padding: EdgeInsets.all(40),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(bottom: 10)),
                                            Text(
                                              "Sticky Notes",
                                              style: signTitle,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "Post your thoughts here...!",
                                              style: darkText,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),


                                      Column(
                                        children: <Widget>[
                                          TextField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "Email Id",
                                              contentPadding:
                                                  EdgeInsets.only(left: 5),
                                                  ),
                                            controller: emailController,
                                          ),
                                          TextField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "Username",
                                              contentPadding:
                                                  EdgeInsets.only(left: 5),
                                                  ),
                                            controller: userNameController,
                                          ),
                                          TextField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "First name",
                                              contentPadding:
                                                  EdgeInsets.only(left: 5),
                                                  ),
                                            controller: firstNameController,
                                          ),
                                          TextField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "Last name",
                                              contentPadding:
                                                  EdgeInsets.only(left: 5),
                                                  ),
                                            controller: lastNameController,
                                          ),
                                          TextField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "Password",
                                              contentPadding:
                                                  EdgeInsets.only(left: 5),
                                                  ),
                                            controller: passwordController,
                                          ),
                                        ],
                                      ),
                                      
                                      
                                      Column(
                                        children: <Widget>[
                                          FlatButton(
                                              color: darkGrey,
                                              child: Text('Sign up',style: whiteText,),
                                              onPressed: () {
                                                if (userNameController.text != null ||
                                                    firstNameController.text != null ||
                                                    lastNameController.text != null ||
                                                    emailController.text != null ||
                                                    passwordController.text != null) {
                                                  userBloc
                                                      .registerUser(
                                                          userNameController.text,
                                                          firstNameController.text ?? "",
                                                          lastNameController.text,
                                                          emailController.text,
                                                          passwordController.text)
                                                      .then((_) {
                                                    widget.login();
                                                  });
                                                }
                                              }),
                                          FlatButton(
                                              color: darkGrey,
                                              child: Text('Back to login',style: whiteText,),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
