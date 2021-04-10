import 'dart:convert';

import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/Screens/view_user_attendence.dart';
import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/base.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

// ignore: camel_case_types
class Userdetails {
  Userdetails({this.n, this.pno});
  String n;
  int pno;
}

class _TableScreenState extends State<TableScreen> {
  final _formKey = GlobalKey<FormState>();
  Userdetails userdetails = new Userdetails();
  var _url = 'https://techspace-trinetra.herokuapp.com/admin/map';
  void _launchURL() async => await launch(_url);

  Image image;
  //for adding data
  PlatformFile objFile = null;

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
    }
  }

  void uploadSelectedFile(String e, String n, String p) async {
    Map body = {"username": "admin", "password": "admin123"};
    var url = Uri.parse('https://techspace-trinetra.herokuapp.com/login');
    Map<String, String> headtoken = {
      'Content-type': 'application/json; charset=UTF-8',
    };
    var restoken =
        await http.post(url, body: jsonEncode(body), headers: headtoken);
    var admindata = jsonDecode(restoken.body);
    String token = admindata['token'];

    Map<String, String> headuser = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://techspace-trinetra.herokuapp.com/register"),
    );

    request.headers['Content-type'] = "application/json; charset=UTF-8";
    request.headers["Authorization"] = 'Bearer $token';
    request.headers["Accept"] = 'application/json';

    //-----add other fields if needed
    request.fields["employee_id"] = e;
    request.fields["name"] = n;
    request.fields["phone"] = p;
    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "photo", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
  }

  adddata() async {
    TextEditingController _eid = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Data '),
          content: TextField(
            controller: _eid,
            decoration:
                InputDecoration(hintText: "Enter User ID to Add details"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String docid = _eid.text;
                String name = "";
                String phoneno = "";
                TextEditingController nm = TextEditingController();
                TextEditingController pno = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nm,
                                decoration: InputDecoration(
                                    labelText: ' Enter Full Name'),
                              ),
                              TextFormField(
                                controller: pno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    labelText: 'Enter Phone No'),
                              ),
                              IconButton(
                                icon: new Icon(Icons.image),
                                iconSize: 25,
                                onPressed: () => chooseFileUsingFilePicker(),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: TextButton(
                                  onPressed: () => uploadSelectedFile(
                                      docid, nm.text, pno.text),
                                  child: Text('Submit'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }

  // //for deleting data
  //   deletedata()
  //   async{
  //     TextEditingController _name = TextEditingController();
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Delete User Details'),
  //           content: TextField(
  //             controller: _name,
  //             decoration: InputDecoration(hintText: "Enter User ID to delete details"),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('CANCEL'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () async {
  //                 String dc=_name.text;
  //                 DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(dc).get();
  //                 bool isDocExists = docSnapshot.exists; //true if exists and false otherwise
  //                 if (isDocExists== false) {
  //                   Navigator.pop(context);
  //                   Fluttertoast.showToast(
  //                       msg: "User not found",
  //                       toastLength: Toast.LENGTH_LONG,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 5,
  //                       backgroundColor: Colors.red,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0
  //                   );
  //                 }
  //                 else
  //                 {
  //                   DocumentReference removedata = FirebaseFirestore.instance.collection('users').doc(dc);
  //                   removedata.delete();
  //                   Navigator.pop(context);
  //                   Fluttertoast.showToast(
  //                       msg: "User Deleted Successfully",
  //                       toastLength: Toast.LENGTH_LONG,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 5,
  //                       backgroundColor: Colors.red,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0
  //                   );
  //                 }
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }

  @override
  Widget build(BuildContext context) {
    var cardtextstyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 20, color: Colors.white);
    return BaseScreen(
      title: "Manage",
      body: Container(
        color: Colors.white,
        child: Card(
          child: GridView.count(
            crossAxisSpacing: 50,
            mainAxisSpacing: 40,
            crossAxisCount: 3,
            children: <Widget>[
              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.add),
                      iconSize: 45,
                      onPressed: adddata,
                    ),
                    Text(
                      'Add Details',
                      style: cardtextstyle,
                    ),
                  ],
                ),
              ),

              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.update),
                      iconSize: 25,
                      onPressed: adddata, // As update and add is same
                    ),
                    Text(
                      'Update Details',
                      style: cardtextstyle,
                    ),
                  ],
                ),
              ),

              // Card(
              //   color: Colors.lightBlueAccent,
              //   shape:RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   elevation: 5,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       IconButton(
              //         icon: new Icon(Icons.delete),
              //         iconSize: 25,
              //         onPressed: deletedata,
              //       ),
              //       Text('Delete Details ',
              //         style: cardtextstyle,
              //       ),
              //     ],
              //   ),
              // ),

              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.map),
                      iconSize: 25,
                      onPressed: _launchURL,
                    ),
                    Text(
                      'View Map ',
                      style: cardtextstyle,
                    ),
                  ],
                ),
              ),

              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.remove_red_eye),
                        iconSize: 25,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreenUI()));
                        }),
                    Text(
                      'View Data',
                      style: cardtextstyle,
                    ),
                  ],
                ),
              ),

              Card(
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.check),
                        iconSize: 25,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttendenceUI()));
                        }),
                    Text(
                      'View Attendece',
                      style: cardtextstyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
