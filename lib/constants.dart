import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:trinetra/models/profile_model.dart';

Address geoAddress;
String phone = '';
String token = '';
String fcmToken = '';
ProfileModel profile;
// ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
//     primarySwatch: MaterialColor(
//       0xFFF5E0C3,
//       <int, Color>{
//         50: Color(0x1aF5E0C3),
//         100: Color(0xa1F5E0C3),
//         200: Color(0xaaF5E0C3),
//         300: Color(0xafF5E0C3),
//         400: Color(0xffF5E0C3),
//         500: Color(0xffEDD5B3),
//         600: Color(0xffDEC29B),
//         700: Color(0xffC9A87C),
//         800: Color(0xffB28E5E),
//         900: Color(0xff936F3E)
//       },
//     ),
//     primaryColor: Color(0xffEDD5B3),
//     primaryColorBrightness: Brightness.light,
//     primaryColorLight: Color(0x1aF5E0C3),
//     primaryColorDark: Color(0xff936F3E),
//     canvasColor: Color(0xffE09E45),
//     accentColor: Color(0xff457BE0),
//     accentColorBrightness: Brightness.light,
//     scaffoldBackgroundColor: Color(0xffB5BFD3),
//     bottomAppBarColor: Color(0xff6D42CE),
//     cardColor: Color(0xaaF5E0C3),
//     dividerColor: Color(0x1f6D42CE),
//     focusColor: Color(0x1aF5E0C3));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    primarySwatch: MaterialColor(
      0xff181926,
      <int, Color>{
        50: Color(0xff181926).withOpacity(0.05),
        100: Color(0xff181926).withOpacity(0.1),
        200: Color(0xff181926).withOpacity(0.2),
        300: Color(0xff181926).withOpacity(0.3),
        400: Color(0xff181926).withOpacity(0.4),
        500: Color(0xff181926).withOpacity(0.5),
        600: Color(0xff181926).withOpacity(0.6),
        700: Color(0xff181926).withOpacity(0.7),
        800: Color(0xff181926).withOpacity(0.8),
        900: Color(0xff181926).withOpacity(0.9)
      },
    ),
    primaryColor: Color(0xffBF5FFE),
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Color(0xff246BFD),
    primaryColorDark: Color(0xff181926),
    canvasColor: Color(0xff181926),
    accentColor: Color(0xff457BE0),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff181926),
    // bottomAppBarColor: Color(0xff6D42CE),
    cardColor: Color(0xff232333),
    dividerColor: Color(0xffBF5FFE),
    focusColor: Color(0x1a311F06),
    buttonColor: Color(0xffBF5FFE),
    applyElevationOverlayColor: true,
    backgroundColor: Color(0xff181926),
    shadowColor: Color(0xffBF5FFE),
    indicatorColor: Color(0xffBF5FFE));
