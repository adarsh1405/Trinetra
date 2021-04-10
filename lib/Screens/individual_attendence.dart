import 'dart:developer';

import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/intl.dart';

class indivdualdata extends StatefulWidget {
  String ph;
  indivdualdata({this.ph});

  @override
  _individualdata createState() => new _individualdata();
}

class _individualdata extends State<indivdualdata> {
  // String address = "abc";

  Future<String> _determinePosition(double lat, double lon) async {
    if (lat == 0 || lon == 0) return 'NO DATA!';
    final coordinates = new Coordinates(lat, lon);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var firstAddress = addresses.first;
    log(firstAddress.adminArea);
    return firstAddress.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    // print(address);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("View Users Attendence Details "),
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          //onPressed:() => Navigator.pop(context, false),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Attendance>>(
        future: getattendence(widget.ph),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Attendance> data = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                // String e = "${data[index].available}";
                // String _address = _determinePosition(data[index].lat,data[index].lon);
                return ListTile(
                  leading: Icon(Icons.location_history),
                  title: Text('${data[index].lat},${data[index].lon}'),
                  // FutureBuilder<Address>(
                  //   future: Geocoder.google(
                  //     'AIzaSyAegroMVvj7vZAToKPO6skyv-LlCoqdf-c',
                  //   )
                  //       .findAddressesFromCoordinates(
                  //           Coordinates(data[index].lat, data[index].lon))
                  //       .then((value) => value.first),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<Address> snapshot) {
                  //     if (!snapshot.hasData) return Text('Loading Location...');
                  //     return Text(snapshot.data.addressLine);
                  //   },
                  // ),
                  trailing: Text(DateFormat.MEd()
                      .format(DateTime.parse(data[index].timestamp))),
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
