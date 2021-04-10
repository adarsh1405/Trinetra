import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:trinetra/constants.dart';
import 'package:trinetra/helper/imei_helper.dart';
import 'package:trinetra/models/day_attendance.dart';
import 'package:trinetra/models/login_response.dart';
import 'package:trinetra/models/profile_model.dart';

class ApiHelper {
  final String baseUrl = 'https://techspace-trinetra.herokuapp.com/';

  /// Get Request using authorization token
  Future<http.Response> _getApiData(
    String apiUrl,
  ) async {
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // log(Uri.parse(baseUrl + apiUrl).toString());
    Uri _url = Uri.parse(baseUrl + apiUrl);
    return await http.get(_url, headers: _headers);
  }

  /// Post Request using authorization token
  Future<http.Response> _postApiData(
      String apiUrl, Map<String, dynamic> parameters) async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // log(Uri.parse(baseUrl + apiUrl).toString());
    // log(parameters.toString());
    Uri _url = Uri.parse(baseUrl + apiUrl);
    return await http.post(_url,
        body: jsonEncode(parameters), headers: _headers);
  }

  /// Login API
  Future<LoginResponse> login(
      {@required String phone, @required String imei}) async {
    final String apiUrl = 'login';
    Map<String, String> data = {
      "phone": phone?.toString() ?? "9090999999",
      "imei": imei ?? "12345"
    };

    try {
      http.Response response = await _postApiData(apiUrl, data);
      // log(response.toString());
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        log(response.body);
        LoginResponse lr = LoginResponse.fromJson(response.body);
        token = lr.token;
        if (token != null)
          log('Login Success');
        else {
          log('Login Failure');
          var body = jsonDecode(response.body);
          Fluttertoast.showToast(
            msg: body['message'] ?? 'Login Failure',
            backgroundColor: Colors.red,
          );
          return null;
        }
        if (lr.firstRun) {
          var hashIMEI = await DeviceIdHelper.deviceInfoDetails();
          log(hashIMEI.toString());
          setIMEI(phone: phone.toString(), fcmToken: fcmToken, imei: hashIMEI);
        }
        return lr;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Get Profile API
  Future<ProfileModel> getProfile() async {
    log('getting Profile...');
    final String apiUrl = 'profile';
    try {
      http.Response response = await _getApiData(apiUrl);
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        log('____got Profile_____');
        // log(response.body);
        ProfileModel pm = ProfileModel.fromJson(response.body);
        return pm;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Get Attendance API
  Future<DayAttendance> getAttendance(String phone) async {
    log('getting logs.....');
    final String apiUrl = 'user/$phone';
    try {
      http.Response response = await _getApiData(apiUrl);
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        // log(response.body);
        var body = jsonDecode(response.body);
        log('____got logs____');
        if (body['success'] == true) {
          DayAttendance attendance = DayAttendance.fromJson(response.body);
          return attendance;
        } else {
          if (body['message'] != null)
            Fluttertoast.showToast(
              msg: body['message'],
              backgroundColor: Colors.red,
            );
          return null;
        }
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Set IMEI no.
  Future<bool> setIMEI({String imei, String fcmToken, String phone}) async {
    final String apiUrl = 'setIMEI';
    Map<String, String> data = {"phone": phone, "imei": imei, "fcm": fcmToken};

    try {
      http.Response response = await _postApiData(apiUrl, data);
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        var body = jsonDecode(response.body);
        if (body['success'] == true)
          return true;
        else {
          if (body['message'] != null)
            Fluttertoast.showToast(
              msg: body['message'],
              backgroundColor: Colors.red,
            );
          return false;
        }
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// Save Location
  Future saveLocation(Coordinates coordinates) async {
    final String apiUrl = 'profile';
    Map<String, double> data = {
      "lat": coordinates.latitude,
      "lon": coordinates.longitude,
    };
    try {
      http.Response response = await _postApiData(apiUrl, data);
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        var body = jsonDecode(response.body);
        if (body['success'] == true) {
          return true;
        } else {
          if (body['message'] != null)
            Fluttertoast.showToast(
              msg: body['message'],
              backgroundColor: Colors.red,
            );
          return false;
        }
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
