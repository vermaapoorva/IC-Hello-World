// import 'package:flutter/material.dart';
// import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
// import 'PlaceholderWidget.dart';
//
// class Groups extends StatefulWidget {
//   Groups({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _GroupsState createState() => _GroupsState();
// }
//
// class _GroupsState extends State<Groups> {
//   int currentIndex;
//   final List<String> entries = <String>['A', 'B', 'C', 'D', 'A', 'B', 'C', 'D', 'A', 'B', 'C', 'D', 'A', 'B', 'C', 'D'];
//   int remainingGroups;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     currentIndex = 0;
//     remainingGroups = entries.length;
//   }
//
//   void changePage(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             RichText(
//               text: TextSpan(
//                 text: 'Your groups',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   color: Colors.orange,
//                 ),
//               ),
//             ),
//             Flexible(
//               child: ListView.separated(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 padding: const EdgeInsets.all(20),
//                 itemCount: entries.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                         color: Colors.lightBlue,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 5,
//                             blurRadius: 7,
//                             offset: Offset(0, 3), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(width: 12),
//                           Icon(Icons.check_box_outline_blank),
//                           SizedBox(width: 12),
//                           Center(child: Text('Entry ${entries[index]}')),
//                           // Yeah don't ask me why but it works...
//                           Spacer(),
//                           Spacer(),
//                           Spacer(),
//                           Spacer(),
//                           Spacer(),
//                           Spacer(),
//                           Expanded(child: Icon(Icons.arrow_forward_ios_sharp))
//                         ],
//                       )
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) => const Divider(),
//               ),
//             ),
//           ],
//         )
//
//
//     );
//   }
// }