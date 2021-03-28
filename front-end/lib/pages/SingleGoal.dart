import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleGoal extends StatefulWidget {
  @override
  SingleGoalState createState() => SingleGoalState();
}

class SingleGoalState extends State<SingleGoal> {
  String groupName = "Goal Name";
  final groupMembers = [
    "Flat 10",
    "Family"
  ];
  bool isEnable = false;
  int currentIndex = 0;
  var isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/running_logo.png'),
                    fit: BoxFit.cover)),
            child: Container(
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                      backgroundImage: AssetImage('images/running.jfif'),
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
        SizedBox(height: 15),
        Row(children: <Widget>[
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
              }),
        ]),
        Row(children: <Widget>[
          Expanded(
              child: Container(
                  height: 60.0,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ToggleButtons(
                      constraints: BoxConstraints.expand(
                          width: constraints.maxWidth / 2 - 82),
                      children: <Widget>[
                        Text("Daily"),
                        Text("Weekly"),
                        Text("Monthly"),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    );
                  })))
        ]),
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
          ]))
          );
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
