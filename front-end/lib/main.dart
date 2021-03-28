import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:goal_app/objects/Auth.dart';
import 'pages/HomePage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const API_URL = "ic-small-steps.herokuapp.com";

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

  bool success = true;

  void authCallback(http.Response response) {
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    // print(responseJson.userId);
    Auth authObj = Auth(responseJson['userid'], responseJson['token']);
    success = responseJson['token'] != null;
    print("Setting: " + success.toString());
    print(authObj.authToken);
  }

  Future<String> auth(String username, String password) {
    Future<http.Response> userInfo = http.post(
      Uri.https(MyApp.API_URL, 'auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    userInfo.then(authCallback);
    // final Map authObjMap = jsonDecode(userInfo);
    Future.delayed(const Duration(milliseconds: 500), () {
      return success;
    });

  }

  @override
  Widget build(BuildContext context) {

    Future<String> submit(LoginData ld) {
      Future<String> authReturn = auth(ld.name, ld.password);
      print("Setting: " + success.toString());
      if (success) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Small Steps")));
        print("Changing page");
        return authReturn;
      }
      else {
        return Future.delayed(Duration(milliseconds: 100), () {
          return "Could not sign in, Invalid username or password";
        });
      }
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
    if (true) {
      print("Username accepted");
      return null;
    }
    return "Invalid Username";
  }

  String invalidPassword(String a) {
    if (a.length >= 6) {
      print("Password accepted");
      return null;
    }
    return "Invalid Password";
  }
}
