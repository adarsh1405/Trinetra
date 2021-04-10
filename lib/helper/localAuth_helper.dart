import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../constants.dart';
import 'api_helper.dart';

class LocalAuthHelper {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Authenticate to Give your Attendance',
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: 'Face ID Required',
        ),
        biometricOnly: true,
        useErrorDialogs: false,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<void> authenticateandSaveLocation() async {
    final isAuthenticated = await LocalAuthHelper.authenticate();
    final ApiHelper _apiHelper = new ApiHelper();

    if (isAuthenticated) {
      await _apiHelper.saveLocation(geoAddress.coordinates).then((value) =>
          value
              ? Fluttertoast.showToast(
                  msg: 'Authentication Sucessful!',
                  backgroundColor: Colors.greenAccent)
              : null);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } else {
      Fluttertoast.showToast(
          msg: 'Error Authenticating!', backgroundColor: Colors.red);
    }
  }
}
