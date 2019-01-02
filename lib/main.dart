import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Autogenerated> fetchPost() async {
  final response = await http
      .get('http://www.howmanypeopleareinspacerightnow.com/peopleinspace.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Autogenerated.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

// #### JSON START ####

class Autogenerated {
  int number;
  List<People> people;

  Autogenerated({this.number, this.people});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    if (json['people'] != null) {
      people = new List<People>();
      json['people'].forEach((v) {
        people.add(new People.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    if (this.people != null) {
      data['people'] = this.people.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class People {
  String name;
  String title;
  String country;
  String launchdate;
  String bio;

  People({this.name, this.title, this.country, this.launchdate, this.bio});

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    country = json['country'];
    launchdate = json['launchdate'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['country'] = this.country;
    data['launchdate'] = this.launchdate;
    data['bio'] = this.bio;
    return data;
  }
}

// #### JSON END ####

void main() => runApp(MyApp(autogenerated: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Autogenerated> autogenerated;

  MyApp({Key key, this.autogenerated}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'How Many People Are In Space Right Now?',
      theme: ThemeData.dark(),
      home: FutureBuilder<Autogenerated>(
        future: autogenerated,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new PeopleNumberPage(
                title: 'People In Space',
                autogeneratedNumber: snapshot.data.number);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return new Container();
        },
      ),
    );
  }
}

class PeopleNumberPage extends StatefulWidget {
  final int autogeneratedNumber;
  final String title;

  PeopleNumberPage({Key key, this.autogeneratedNumber, this.title}) : super(key: key);

  @override
  _PeopleNumberPageState createState() => new _PeopleNumberPageState(autogeneratedNumber);
}

class _PeopleNumberPageState extends State<PeopleNumberPage> {
  final int autogeneratedNumber;

  _PeopleNumberPageState(this.autogeneratedNumber) : super();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/space_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
            child: new Text(autogeneratedNumber.toString(), style: new TextStyle(fontSize: 188.0, color: Colors.white.withOpacity(0.8))),
            alignment: AlignmentDirectional(0.0, -0.4),
            )
          ),
        ],
      ),
    );
  }
}