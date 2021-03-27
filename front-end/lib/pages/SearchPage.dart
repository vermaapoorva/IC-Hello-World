import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UserSearch());
            }),
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  final history = [];
  final exampleStrings = ['Apoorva', 'Rohan', 'Rahil', 'Alex', 'Gavin'];

  // The clear button of the search bar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  // The back arrow when you are in the middle of a search
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  // This needs to be a profile
  @override
  Widget buildResults(BuildContext context) {
    history.add(query);
    return Card(
      color: Colors.red,
      child: Center(
        child: Text('This needs to be a profile')
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? history
        : exampleStrings.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
            // change to profile picture of the profile
            leading: Icon(Icons.account_circle),
            title: Text(suggestionList[index])),
        itemCount: suggestionList.length);
  }
}
