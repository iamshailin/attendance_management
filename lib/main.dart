import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage> {
  //final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance management"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                elevation: 10,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  //getData();
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  });
                },
                child: Text("Mark attendance"),
              ),
              RaisedButton(
                child: Text("Show Attendance"),
                elevation: 10,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /*void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }*/
}

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondPage();
  }
}

class _SecondPage extends State<SecondPage> {
  String dropdownValue1 = "FYMCA";
  String dropdownValue2 = "SEM 1";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue1,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue1 = newValue;
                });
              },
              items: <String>['FYMCA', 'SYMCA', 'TYMCA']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: dropdownValue2,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue2 = newValue;
                });
              },
              items: <String>['SEM 1', 'SEM 2']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  print(dropdownValue1);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThirdPage(dropdownValue1,dropdownValue2)),);
                });
              },
              elevation: 10,
              color: Colors.blue,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text("Get details"),
            )
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final String dropdownValue1;
  final String dropdownValue2;

  ThirdPage(this.dropdownValue1,this.dropdownValue2);

  @override
  Widget build(BuildContext context) {
    print(dropdownValue1);
    print(dropdownValue2);
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Students').document(dropdownValue1).collection(dropdownValue2).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading Data....");
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Text(snapshot.data.documents[0]['Name'])
              ],
            ),
          );
        },
      ),
    );
  }
}
