import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  Color color;

  PlaceholderWidget(Color color) {
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: color,
      ),
    );
  }
}