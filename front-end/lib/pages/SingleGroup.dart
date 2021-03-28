import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleGroup extends StatefulWidget {
  @override
  SingleGroupState createState() => SingleGroupState();
}

class SingleGroupState extends State<SingleGroup> {
  String groupName = "Group name";
  List<GroupMemberDisplay> groupMemberList;
  final groupMembers = [
    "Apoorva Verma",
    "Gavin Wu",
    "Rohan Gupta",
    "Rahil Shah",
    "Alex Usher"
  ];
  final goalsForGroup = [
    "Drink more water",
    "Exercise for 20 minutes",
    "Get out of the house for half an hour"
  ];
  bool isEnable = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mountain.png'), fit: BoxFit.cover)),
          child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.png'),
                    radius: 60.0),
              ))),
      SizedBox(
        height: 60,
      ),
      Text(groupName,
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Expanded(
            child: !isEnable
                ? Text(groupName, style: TextStyle(fontSize: 20.0))
                : TextFormField(
                    initialValue: groupName,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(() {
                        isEnable = false;
                        groupName = value;
                      });
                    },
                  )),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEnable = true;
              });
            })
      ]),
      SizedBox(height: 10),
      Text("Group members",
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      Flexible(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: groupMembers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(groupMembers[index]));
              })),
      Row(children: <Widget>[
        Expanded(
            child: !isEnable
                ? Text("Add new member", style: TextStyle(fontSize: 20.0))
                : TextFormField(
                    initialValue: "Add new member",
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(() {
                        isEnable = false;
                        groupMembers.add(value);
                      });
                    },
                  )),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                isEnable = true;
              });
            })
      ]),
      SizedBox(
        height: 10,
      ),
      Text("Here are your goals",
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      Flexible(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: goalsForGroup.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(goalsForGroup[index]));
              })),
      SizedBox(
        height: 10,
      ),
      Row(children: <Widget>[
        Expanded(
            child: !isEnable
                ? Text("Add new goal", style: TextStyle(fontSize: 20.0))
                : TextFormField(
                    initialValue: "Add new goal",
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(() {
                        isEnable = false;
                        goalsForGroup.add(value);
                      });
                    },
                  )),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                isEnable = true;
              });
            })
      ]),
    ])));
  }

  Widget buildRow(GroupMemberDisplay groupMember) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundImage: new AssetImage('images/winston-churchill.jpeg'),
      ),
      title: new Text(groupMember.name, style: TextStyle(fontSize: 20.0)),
      subtitle: new Text(groupMember.username),
    );
  }
}

class GroupMemberDisplay {
  final String username;
  final String name;

  const GroupMemberDisplay(this.name, this.username);
}
