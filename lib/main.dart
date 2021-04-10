import 'package:adminpanelflutter/Screens/loginscreen.dart';
import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:adminpanelflutter/services/loginUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/pages/table.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          // maxWidth: 1200,
          // minWidth: 450,
          // defaultScale: true,
          // breakpoints: [
          //   ResponsiveBreakpoint.resize(350, name: MOBILE),
          //   ResponsiveBreakpoint.autoScale(800, name: TABLET),
          //   ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          //   ResponsiveBreakpoint.resize(100, name: DESKTOP),
          //   ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          // ],
          background: Container(color: Colors.tealAccent)),
      title: 'Trinetra Admin Panel',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/home": (context) => HomeScreenUI(),
        "/table": (context) => TableScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomeScreenUI(),
      home: LoginScreen2(),
    );
  }
}
