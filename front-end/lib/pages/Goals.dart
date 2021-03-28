import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:goal_app/pages/SingleGoal.dart';
import 'PlaceholderWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Goals extends StatefulWidget {
  Goals({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GoalsState createState() => _GoalsState();
}

class GoalObj {
  final String goalId;
  final String name;
  final String groupId;
  final String description;
  final String frequency;

  GoalObj({@required this.name, @required this.groupId, @required this.goalId, @required this.description, @required this.frequency});

  factory GoalObj.fromJson(Map<String, dynamic> json) {
    return GoalObj(
      groupId: json["groupId"],
      name: json["name"],
      goalId: json["_id"],
      description: json["description"],
      frequency: json["frequency"],
    );
  }
}

Future<List<GoalObj>> fetchGoals() async {
  var url = Uri.https("ic-small-steps.herokuapp.com", "/goals/userid/6060868b8f121e001512bd4f");
  final response = await http.get(url, headers: {"x-auth-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjA2MDg2OGI4ZjEyMWUwMDE1MTJiZDRmIn0sImlhdCI6MTYxNjkzODYzNSwiZXhwIjoxNjE3MzcwNjM1fQ.XOLhTd0daIVZ5ByimpQlMpc1FUz3p9VdrAByKO96aMI"},);
  print("made request");
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return List<GoalObj>.from(jsonDecode(response.body).map((x) => GoalObj.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load group');
  }
}

class _GoalsState extends State<Goals> {
  int currentIndex;
  List<GoalObj> entries = [];
  int remainingGoals;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGoals().then((value) => {
      print(value),
      setState(() {
        entries = value;
        remainingGoals = entries.length;
        currentIndex = 0;
      })
    });
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  refresh1() {
    setState(() {
      remainingGoals = remainingGoals + 1;
    });
  }

  refresh2() {
    setState(() {
      remainingGoals = remainingGoals - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 15),
          Center(child: RichText(
            text: TextSpan(
              text: remainingGoals.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepOrangeAccent,
              ),
              children: [
                TextSpan(
                  text: ' Tasks Remaining',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[900],
                  )
                )
              ]
            ),
          ),
          ),
          Flexible(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: entries.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Goal(name: entries[index].name, notifyParent1: refresh1, notifyParent2: refresh2);
                //   Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //     color: Colors.lightBlue,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 5,
                //         blurRadius: 7,
                //         offset: Offset(0, 3), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       SizedBox(width: 12),
                //       Icon(Icons.check_box_outline_blank),
                //       SizedBox(width: 12),
                //       Center(child: Text('Entry ${entries[index]}')),
                //       // Yeah don't ask me why but it works...
                //       Spacer(),
                //       Spacer(),
                //       Spacer(),
                //       Spacer(),
                //       Spacer(),
                //       Spacer(),
                //       Expanded(child: Icon(Icons.arrow_forward_ios_sharp))
                //     ],
                //   )
                // );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      )


    );
  }
}

class Goal extends StatefulWidget {
  final Function() notifyParent1;
  final Function() notifyParent2;
  Goal({Key key, this.name, @required this.notifyParent1, @required this.notifyParent2}) : super(key: key);
  final String name;
  // String name;
  // Goal(String name) {
  //   this.name = name;
  // }
  @override
  _Goal createState() => _Goal();
}

class _Goal extends State<Goal> {
  bool _isChecked = false;

  void _toggleChecked() {
    setState(() {
      if (_isChecked) {
        _isChecked = false;
        widget.notifyParent1();
      } else {
        _isChecked = true;
        widget.notifyParent2();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingleGoal()));
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: (_isChecked ? Colors.lightGreen[200] : Colors.orange[200]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: AssetImage('images/winston-churchill.jpg'),
                  radius: 15.0,
                ),
                SizedBox(width: 10),
                Center(child: Text('${widget.name}')),
                // Yeah don't ask me why but it works...
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Expanded(child:
                // IconButton(
                //   icon: Icon(Icons.arrow_forward_ios_sharp),
                //   onPressed: () {/* TODO: Function here */},
                // ),
                IconButton(
                  icon: (_isChecked ? Icon(Icons.check_box_outlined) : Icon(Icons.check_box_outline_blank)),
                  onPressed: _toggleChecked,
                ),

                ),
                SizedBox(width: 10)
              ],
            )
        )
    );
  }

}