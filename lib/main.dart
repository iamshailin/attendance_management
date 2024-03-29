import 'package:cloud_firestore/cloud_firestore.dart' as prefix0;
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
      debugShowCheckedModeBanner: false,
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
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Show()));
                  });
                },
                elevation: 10,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                child: Text("Show Defaulters"),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowDefaulters()));
                  });
                },
                elevation: 10,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              RaisedButton(
                child: Text("Add student"),
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddStudent()));
                  });
                },
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

class AddStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent> {
  String dropdownValue1 = "FYMCA";
  String dropdownValue2 = "SEM 1";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Add(dropdownValue1, dropdownValue2)),
                  );
                });
              },
              elevation: 10,
              color: Colors.blue,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text("Add student"),
            )
          ],
        ),
      ),
    );
  }
}

class Add extends StatefulWidget {
  final String dropdownValue1;
  final String dropdownValue2;
  Add(this.dropdownValue1, this.dropdownValue2);
  @override
  State<StatefulWidget> createState() {
    return _Add(dropdownValue1, dropdownValue2);
  }
}

class _Add extends State<Add> {
  final String dropdownValue1;
  final String dropdownValue2;
  String Name;
  String UID;
  final db = Firestore.instance;
  _Add(this.dropdownValue1, this.dropdownValue2);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Enter Full Name"),
              onChanged: (text) {
                Name = text;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter UID"),
              onChanged: (text) {
                UID = text;
                print(UID);
              },
            ),
            RaisedButton(
              onPressed: () async {
                await db
                    .collection('Students')
                    .document(dropdownValue1)
                    .collection(dropdownValue2)
                    .document(UID)
                    .setData({"Name": Name});
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstPage()));
              },
              elevation: 10,
              color: Colors.blue,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}

class ShowDefaulters extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShowDefaulters();
  }
}

class _ShowDefaulters extends State<ShowDefaulters> {
  String dropdownValue1 = "FYMCA";
  String dropdownValue2 = "SEM 1";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Defaulter(dropdownValue1, dropdownValue2)),
                  );
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

class Defaulter extends StatefulWidget {
  final String dropdownValue1;
  final String dropdownValue2;
  Defaulter(this.dropdownValue1, this.dropdownValue2);
  @override
  State<StatefulWidget> createState() {
    return _Defaulter(dropdownValue1, dropdownValue2);
  }
}

class _Defaulter extends State<Defaulter> {
  final String dropdownValue1;
  final String dropdownValue2;
  _Defaulter(this.dropdownValue1, this.dropdownValue2);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Defaulters"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('Students')
                .document(dropdownValue1)
                .collection(dropdownValue2)
                /* .where(dropdownValue3, isEqualTo: true)*/
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Loading Data....");
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, int i) {
                      print(snapshot.data.documents[i]);
                      //print(snapshot.data.documents[i].documentID);
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("UID: " +
                                      snapshot.data.documents[i].documentID),
                                  Text("Name: " +
                                      snapshot.data.documents[i]['Name']),
                                  _def(snapshot, i)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _def(AsyncSnapshot snapshot, int i) {
  double per = snapshot.data.documents[i]['DBMS'] /
      snapshot.data.documents[i]['DBMSTotal'] *
      100;
  if (per < 75) {
    return Text(
      "DBMS: " + per.toString() + "%",
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  } else {
    return Text("DBMS: " + per.toString() + "%");
  }
}

class Show extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Show();
  }
}

class _Show extends State<Show> {
  String dropdownValue1 = "FYMCA";
  String dropdownValue2 = "SEM 1";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Attend(dropdownValue1, dropdownValue2)),
                  );
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

class Attend extends StatefulWidget {
  final String dropdownValue1;
  final String dropdownValue2;
  Attend(this.dropdownValue1, this.dropdownValue2);
  @override
  State<StatefulWidget> createState() {
    return _Attend(dropdownValue1, dropdownValue2);
  }
}

class _Attend extends State<Attend> {
  final String dropdownValue1;
  final String dropdownValue2;
  _Attend(this.dropdownValue1, this.dropdownValue2);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('Students')
                .document(dropdownValue1)
                .collection(dropdownValue2)
                /* .where(dropdownValue3, isEqualTo: true)*/
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Loading Data....");
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, int i) {
                      print(snapshot.data.documents[i]);
                      //print(snapshot.data.documents[i].documentID);
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("UID: " +
                                      snapshot.data.documents[i].documentID),
                                  Text("Name: " +
                                      snapshot.data.documents[i]['Name']),
                                  Row(
                                    children: <Widget>[
                                      Text("DBMS: " +
                                          snapshot.data.documents[i]['DBMS']
                                              .toString()),
                                      Text("Total: " +
                                          snapshot.data.documents[i]['DBMSTotal']
                                              .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
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
  String dropdownValue3 = "DBMS";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
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
            DropdownButton<String>(
              value: dropdownValue3,
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
                  dropdownValue3 = newValue;
                });
              },
              items: <String>['DBMS', 'AI']
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThirdPage(
                            dropdownValue1, dropdownValue2, dropdownValue3)),
                  );
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

class ThirdPage extends StatefulWidget {
  final String dropdownValue1;
  final String dropdownValue2;
  final String dropdownValue3;
  ThirdPage(this.dropdownValue1, this.dropdownValue2, this.dropdownValue3);
  @override
  State<StatefulWidget> createState() {
    return _ThirdPage(dropdownValue1, dropdownValue2, dropdownValue3);
  }
}

class _ThirdPage extends State<ThirdPage> {
  final String dropdownValue1;
  final String dropdownValue2;
  final String dropdownValue3;
  var Alist = new List();
  bool _val1 = false;
  bool _isCheckes = false;
  var myMap = new Map();
  Map<String, bool> ated = Map();
  _ThirdPage(this.dropdownValue1, this.dropdownValue2, this.dropdownValue3);
  List<bool> inputs = new List<bool>();
  List<String> IDs = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for (int j = 0; j < 60; j++) {
        inputs.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(dropdownValue1);
    //print(dropdownValue2);
    //print(dropdownValue3);
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('Students')
                .document(dropdownValue1)
                .collection(dropdownValue2)
                /* .where(dropdownValue3, isEqualTo: true)*/
                .snapshots(),
            builder: (context, snapshot) {
              //print(snapshot.data.documents.length);

              //print(IDs);
              if (!snapshot.hasData)
                return Text("Loading Data....");
              else {
                var temp = snapshot.data.documents.length;
                for (int i = 0; i < temp; i++) {
                  if (!IDs.contains(snapshot.data.documents[i].documentID))
                    IDs.add(snapshot.data.documents[i].documentID);
                }
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, int i) {
                      //print(snapshot.data.documents[i].documentID);
                      return Card(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new CheckboxListTile(
                                  value: inputs[i],
                                  title: Text("UID: " +
                                      snapshot.data.documents[i].documentID),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  subtitle: Text("Name: " +
                                      snapshot.data.documents[i]['Name']),
                                  onChanged: (bool val) {
                                    setState(() {
                                      inputs[i] = val;
                                      print('inputs' +
                                          inputs[i].toString() +
                                          i.toString());
                                      if (inputs[i] == true) {
                                        /*
                                      Alist.add(snapshot.data.documents[i].documentID);
                                      myMap[snapshot.data.documents[i].documentID.toString()]=true;*/
                                        ated[snapshot
                                            .data.documents[i].documentID
                                            .toString()] = true;
                                        print(ated);
                                        _val1 = ated[snapshot
                                            .data.documents[i].documentID];
                                        print("Val" + _val1.toString());
                                      } else {
                                        _val1 = false;
                                        ated.remove(snapshot
                                            .data.documents[i].documentID);
                                        print(ated);
                                        //print(Alist);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          RaisedButton(
              child: Text("Mark"),
              onPressed: () {
                setState(() {
                  for (var i in ated.keys) {
                    DocumentReference ref = Firestore.instance
                        .collection('Students')
                        .document(dropdownValue1)
                        .collection(dropdownValue2)
                        .document(i);
                    //print(ref.path);
                    ref.updateData({dropdownValue3: FieldValue.increment(1)});
                    Firestore.instance.runTransaction((Transaction tx) async {
                      DocumentSnapshot postSnapshot = await tx.get(ref);
                      print("Hello" + postSnapshot.toString());
                      print("hrllo");
                      if (postSnapshot.exists) {
                        await tx.update(ref, <String, dynamic>{
                          dropdownValue3: postSnapshot.data[dropdownValue3] + 1
                        });
                      }
                    });
                  }
                  for (var i in IDs) {
                    DocumentReference ref = Firestore.instance
                        .collection('Students')
                        .document(dropdownValue1)
                        .collection(dropdownValue2)
                        .document(i);
                    //print(ref.path);
                    ref.updateData(
                        {dropdownValue3 + 'Total': FieldValue.increment(1)});
                    Firestore.instance.runTransaction((Transaction tx) async {
                      DocumentSnapshot postSnapshot = await tx.get(ref);
                      print("Hello" + postSnapshot.toString());
                      print("hrllo");
                      if (postSnapshot.exists) {
                        await tx.update(ref, <String, dynamic>{
                          dropdownValue3 + 'Total':
                              postSnapshot.data[dropdownValue3 + 'Total'] + 1
                        });
                      }
                    });
                  }
                  IDs.clear();
                  ated.clear();
                  for (int j = 0; j < 60; j++) {
                    inputs[j] = false;
                  }
                });
              })
        ],
      ),
    );
  }
}
