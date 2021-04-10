import 'dart:convert';
import 'package:adminpanelflutter/API_Models/register_user.dart';
import 'package:adminpanelflutter/API_Models/user_attendance.dart';
import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/Userdata.dart';
import 'package:http/http.dart' as http;

Future<UsersAttendance> getData() async {
  Map body = {"username": "admin", "password": "admin123"};
  var url = Uri.parse('https://techspace-trinetra.herokuapp.com/login');
  Map<String, String> headtoken = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  var restoken =
      await http.post(url, body: jsonEncode(body), headers: headtoken);
  print('Response status: ${restoken.statusCode}');
  var admindata = jsonDecode(restoken.body);
  String token = admindata['token'];
  print(token);

  Map<String, String> headuser = {
    'Content-type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var urluser = Uri.parse('https://techspace-trinetra.herokuapp.com/user');
  var resuser = await http.get(urluser, headers: headuser);
  print(resuser.body);
  final u = UsersAttendance.fromJson(resuser.body);
  // List d = u.users;
  return u;
}

Future<List<Attendance>> getattendence(String x) async {
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
  var urluser = Uri.parse('https://techspace-trinetra.herokuapp.com/user/$x');
  var resuser = await http.get(urluser, headers: headuser);
  final u = userattendenceFromJson(resuser.body);
  List d = u.attendance;
  return d;
}

Future<int> adduser(Map b) async {
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
  var urluser = Uri.parse('https://techspace-trinetra.herokuapp.com/register');
  var resuser =
      await http.post(urluser, body: jsonEncode(b), headers: headtoken);
  final adduser = adduserFromJson(resuser.body);
  return resuser.statusCode;
  // var resuser = await http.get(urluser, headers: headuser);
  // final u = userattendenceFromJson(resuser.body);
  // List d=u.attendance;
  // return d;
}
