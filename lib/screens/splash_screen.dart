import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trinetra/helper/api_helper.dart';
import 'package:trinetra/helper/imei_helper.dart';
import 'package:trinetra/screens/onboard/welcome.dart';

import '../constants.dart';
import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserLoggedIn = false;
  final ApiHelper _apiHelper = new ApiHelper();
  @override
  void initState() {
    Future.microtask(() async {
      await _determinePosition();
      SharedPreferences pref = await SharedPreferences.getInstance();
      phone = (pref.getString('phone') ?? null).replaceAll('+91', '');
      log(phone);
      isUserLoggedIn = (phone != null);
      if (!isUserLoggedIn) return;

      var androidId = await DeviceIdHelper.deviceInfoDetails();
      if (phone == '9090999999') androidId = '12345';
      log(androidId.toString());

      await _apiHelper.login(
          imei: androidId ?? '12345', phone: phone ?? '9090999999');
      profile = await _apiHelper.getProfile();
      log(profile.toJson());
    }).whenComplete(() {
      if (!isUserLoggedIn)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Welcome(),
            ),
            (route) => false);
      else
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
    });
    super.initState();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    /// Permisions are auto handled
    Position _position = await Geolocator.getCurrentPosition().timeout(
      Duration(seconds: 15),
      onTimeout: () async {
        Fluttertoast.showToast(
            msg: 'Can\'t access current Location', backgroundColor: Colors.red);
        return await Geolocator.getLastKnownPosition();
      },
    );

    log('${_position.latitude}, ${_position.longitude}');
    final coordinates =
        new Coordinates(_position.latitude, _position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var firstAddress = addresses.first;
    geoAddress = firstAddress;

    // log(geoAddress.toMap().toString());
    // log("${firstAddress.featureName} : ${firstAddress.addressLine}");
    // log("${firstAddress.toString()}");

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181926),
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }
}
