import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:goal_app/pages/ProfilePage.dart';
import 'package:goal_app/pages/SearchPage.dart';
import 'package:goal_app/pages/Goals.dart';
import 'package:goal_app/pages/PlaceholderWidget.dart';
import 'package:goal_app/pages/Groups.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;
  final List<Widget> _children = [
    Goals(),
    ProfilePage(),
    SearchPage(),
    Groups(),
    PlaceholderWidget(Colors.blue),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The easiest way for creating RFlutter Alert
    _onAlertPressed(context) {
      Alert(
        context: context,
        title: "RFLUTTER ALERT",
        desc: "Flutter is more awesome with RFlutter Alert.",
      ).show();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAlertPressed(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: Colors.deepPurple,
              ),
              title: Text("Account")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: UserSearch());
                  }),
              activeIcon: Icon(
                Icons.search,
                color: Colors.indigo,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.group,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.group,
                color: Colors.green,
              ),
              title: Text("Groups"))
        ],
      ),
    );
  }
}