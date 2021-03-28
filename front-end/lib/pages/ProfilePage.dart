import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/sea-background.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          width: double.infinity,
          height: 200,
          child: Container(
            alignment: Alignment(0.0, 2.5),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/winston-churchill.jpg'),
              radius: 60.0,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 60,
      ),
      Text("Winston Churchill",
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      SizedBox(
        height: 15,
      ),
      Text("winniechurch99",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      SizedBox(
        height: 15,
      ),
      Text("winstonchurchill@example.com",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400)),
      SizedBox(
        height: 15,
      ),
      Card(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Score",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "15",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Friends",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "2000",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 50,
      ),
      RaisedButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          color: Colors.blue,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 100.0,
              maxHeight: 40.0,
            ),
            alignment: Alignment.center,
            child: Text(
              "Edit account settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500),
            ),
          ))
    ])));
  }
}
