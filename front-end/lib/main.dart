import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'pages/HomePage.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
// import 'HomeScreen/HomeScreen.dart';

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
      home: MyHomePage(title: 'Goals'),
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
    return FlutterLogin(
      title: 'Tether',
      // logo: 'images/lake.jpg',
      emailValidator: invalidUsername,
      passwordValidator: invalidPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
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

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int currentIndex;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     currentIndex = 0;
//   }
//
//   void changePage(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//         backgroundColor: Colors.red,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       bottomNavigationBar: BubbleBottomBar(
//         hasNotch: true,
//         fabLocation: BubbleBottomBarFabLocation.end,
//         opacity: .2,
//         currentIndex: currentIndex,
//         onTap: changePage,
//         borderRadius: BorderRadius.vertical(
//             top: Radius.circular(
//                 16)), //border radius doesn't work when the notch is enabled.
//         elevation: 8,
//         items: <BubbleBottomBarItem>[
//           BubbleBottomBarItem(
//               backgroundColor: Colors.red,
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.home,
//                 color: Colors.red,
//               ),
//               title: Text("Home")),
//           BubbleBottomBarItem(
//               backgroundColor: Colors.deepPurple,
//               icon: Icon(
//                 Icons.account_circle,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.account_circle,
//                 color: Colors.deepPurple,
//               ),
//               title: Text("Account")),
//           BubbleBottomBarItem(
//               backgroundColor: Colors.indigo,
//               icon: Icon(
//                 Icons.search,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.search,
//                 color: Colors.indigo,
//               ),
//               title: Text("Search")),
//           BubbleBottomBarItem(
//               backgroundColor: Colors.green,
//               icon: Icon(
//                 Icons.group,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.group,
//                 color: Colors.green,
//               ),
//               title: Text("Groups"))
//         ],
//       ),
//     );
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextStyle style = TextStyle(fontFamily: 'Lato', fontSize: 20.0);
//
//   @override
//   Widget build(BuildContext context) {
//
//     final emailField = TextField(
//       obscureText: false,
//       style: style,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Email",
//           hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//           border:
//           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//     );
//     final passwordField = TextField(
//       obscureText: true,
//       style: style.copyWith(
//           color: Colors.white, fontWeight: FontWeight.bold),
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Password",
//           hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//           border:
//           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//     );
//     final loginButon = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Color(0xff01A0C7),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: () {},
//         child: Text("Login",
//             textAlign: TextAlign.center,
//             style: style.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );
//
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.blueAccent,
//           child: Padding(
//             padding: const EdgeInsets.all(36.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 155.0,
//                   child: Image.asset(
//                     "images/lake.jpg",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(height: 45.0),
//                 emailField,
//                 SizedBox(height: 25.0),
//                 passwordField,
//                 SizedBox(
//                   height: 35.0,
//                 ),
//                 loginButon,
//                 SizedBox(
//                   height: 15.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
