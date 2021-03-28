import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'PlaceholderWidget.dart';
import 'SingleGroup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class Group {
  final String groupId;
  final String creator;
  final String name;

  Group({@required this.name, @required this.groupId, @required this.creator});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json["_id"],
      creator: json["creator"],
      name: json["name"],
    );
  }
}

Future<List<Group>> fetchGroups() async {
  var url = Uri.https("ic-small-steps.herokuapp.com", "/groups/userid/605fb0866ab50868f0c1bcbb");
  final response = await http.get(url, headers: {"x-auth-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjA1ZmIwODY2YWI1MDg2OGYwYzFiY2JiIn0sImlhdCI6MTYxNjkwNTY1MywiZXhwIjoxNjE3MzM3NjUzfQ.ROJ43aYbDjkbpGPnbEqo2-ilYMAhxwI6mLVWG0lvXbY"},);
  print("made request");
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return List<Group>.from(jsonDecode(response.body).map((x) => Group.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load group');
  }
}

class _GroupsState extends State<Groups> {

  List<Group> groups = [];

  @override
  initState() {
    super.initState();
    fetchGroups().then((value) => {
      print(value),
      setState(() {
        groups = value;
      })
    });
    print(groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: groups.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 5),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/winston-churchill.jpg'),
                            radius: 20.0,
                          ),
                          title: Text(groups[index].name),
                          subtitle: Text('Description goes here.'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            /// TODO - functionality still to determine
                            TextButton(
                              child: const Text('VIEW'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleGroup()
                                    )
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    )
    );
  }
}
