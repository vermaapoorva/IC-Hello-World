import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tether',
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
      // home: LoginScreen(title: 'Goals'),
      home: MyHomePage(title: "Goals"),
      // home: LoginScreen(),
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key key, this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   // _MyHomePageState createState() => _MyHomePageState();
//   _LoginScreen createState() => _LoginScreen();
// }

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Future<String> submit(LoginData ld) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: "Goals")));
      print("Changing page");
      return Future.delayed(
        Duration(seconds: 2),
            () => 'Large Latte',
      );
    }

    return FlutterLogin(
      title: 'Tether',
      // logo: 'images/lake.jpg',
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
