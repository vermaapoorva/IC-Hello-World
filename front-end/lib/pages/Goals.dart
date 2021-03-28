import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:goal_app/pages/SingleGoal.dart';
import 'PlaceholderWidget.dart';

class Goals extends StatefulWidget {
  Goals({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  int currentIndex;
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'A', 'B', 'C', 'D', 'A', 'B', 'C', 'D', 'A', 'B', 'C', 'D'];
  int remainingGoals;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
    remainingGoals = entries.length;
  }

  Future<List<Goal>> fetchGoals() async {
    var url = Uri.https("ic-small-steps.herokuapp.com", "/goals/userid/605fb0866ab50868f0c1bcbb");
    final response = await http.get(url, headers: {"x-auth-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjA1ZmIwODY2YWI1MDg2OGYwYzFiY2JiIn0sImlhdCI6MTYxNjkwNTY1MywiZXhwIjoxNjE3MzM3NjUzfQ.ROJ43aYbDjkbpGPnbEqo2-ilYMAhxwI6mLVWG0lvXbY"},);
    print("made request");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return List<Goal>.from(jsonDecode(response.body).map((x) => Goal.fromJson(x)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load group');
    }
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
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
              text: '5',
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
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Goal(name: entries[index]);
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
  Goal({Key key, this.name}) : super(key: key);
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
      } else {
        _isChecked = true;
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
                Center(child: Text('Entry ${widget.name}')),
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