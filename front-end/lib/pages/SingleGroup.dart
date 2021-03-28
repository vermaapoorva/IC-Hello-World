import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleGroup extends StatefulWidget {
  @override
  SingleGroupState createState() => SingleGroupState();
}

class SingleGroupState extends State<SingleGroup> {
  String groupName = "Group name";
  bool isEnable = false;

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
      Text("Group name insert here",
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
            })
      ])
    ])));
  }
}
