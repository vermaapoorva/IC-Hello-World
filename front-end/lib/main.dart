import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'pages/HomePage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const API_URL = "";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Small Steps',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(title: 'Achieve'),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<String> submit(LoginData ld) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: "Small Steps")));
      print("Changing page");
      return Future.delayed(
        Duration(seconds: 2),
            () => 'Failed Login',
      );
    }

    return FlutterLogin(
      title: 'Small Steps',
      // logo: 'images/mountain.png',
      emailValidator: invalidUsername,
      passwordValidator: invalidPassword,
      onLogin: submit,
      messages: LoginMessages(
        usernameHint: "Username"
      ),
      // onRecoverPassword: _recoverPassword,
    );
  }

  String invalidUsername(String a) {
    if (a == "pass") {
      print("Username accepted");
      return null;
    }
    return "Invalid Username";
  }

  String invalidPassword(String a) {
    if (a == "pass") {
      print("Password accepted");
      return null;
    }
    return "Invalid Password";
  }
}
