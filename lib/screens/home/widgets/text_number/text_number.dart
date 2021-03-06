import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/people.dart';
import 'package:hmpaisrn/screens/list/list.dart';

class TextNumber extends StatelessWidget {
  final int autogeneratedNumber;
  final List<People> people;
  final double fontSize;
  final Color fontColor;
  final bool offline;

  //passing props in react style
  TextNumber(
      {this.autogeneratedNumber,
      this.people,
      this.fontSize,
      this.fontColor,
      this.offline});

  @override
  Widget build(BuildContext context) {
    if (offline) {
      return new Center(
        child: Container(
          child: new Text("Offline",
              style: new TextStyle(fontSize: fontSize, color: fontColor)),
          alignment: AlignmentDirectional(0.0, -0.4),
        ),
      );
    } else
      return new GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ListScreen(people: people)));
          },
          child: new Center(
            child: Container(
              child: new Text(autogeneratedNumber.toString(),
                  style: new TextStyle(fontSize: fontSize, color: fontColor)),
              alignment: AlignmentDirectional(0.0, -0.4),
            ),
          ));
  }
}
