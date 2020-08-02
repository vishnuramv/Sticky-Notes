import 'package:TodoApp/bloc/blocs/user_bloc_provider.dart';
import 'package:TodoApp/models/classes/user.dart';
import 'package:TodoApp/models/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      backgroundColor: darkGrey,
      body: Center(
        child: widget.newUser ? getSignUpPage() : getSignInPage(),
      ),
    );
  }

  Widget getSignInPage() {
    TextEditingController emailText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
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
                  "Welcome",
                  style: welcomeTitle,
                ),
                Text(
                  "Keep track of your work!",
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

  Widget getSignUpPage() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: userNameController,
            decoration: InputDecoration(hintText: "Username"),
          ),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(hintText: "First name"),
          ),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(hintText: "Last name"),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          FlatButton(
              color: Colors.blueAccent,
              child: Text('Sign up'),
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
              })
        ],
      ),
    );
  }
}
