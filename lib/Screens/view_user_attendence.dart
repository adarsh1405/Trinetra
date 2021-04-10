import 'package:adminpanelflutter/API_Models/user_attendance.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_timeline/flutter_timeline.dart';

import 'individual_attendence.dart';

class AttendenceUI extends StatefulWidget {
  @override
  _attendencescreen createState() => new _attendencescreen();
}

class _attendencescreen extends State<AttendenceUI> {
  var cardtextstyle = TextStyle(
    fontFamily: "Montserrat Regular",
    fontSize: 20,
    color: Colors.black87,
  );
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: FutureBuilder<UsersAttendance>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> data = snapshot.data.users;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                String d = "${data[index].employeeId}";
                return Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                            icon: new Icon(Icons.check),
                            iconSize: 25,
                            onPressed: () {
                              String x = "${data[index].phone}";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => indivdualdata(
                                            ph: x,
                                          )));
                            }),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(d),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          // By default show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
