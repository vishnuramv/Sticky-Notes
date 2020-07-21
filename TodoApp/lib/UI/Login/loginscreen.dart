import 'package:TodoApp/bloc/blocs/user_bloc_provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
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
                  if (userNameController.text != null || firstNameController.text != null || lastNameController.text != null || emailController.text != null || passwordController.text != null) {
                  bloc.registerUser(userNameController.text, firstNameController.text ?? "", lastNameController.text, emailController.text, passwordController.text);
                  }
                } 
              )
            ],
          ),
        ),
      ),
    );
  }
}
