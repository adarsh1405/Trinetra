import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreen2 createState() =>_LoginScreen2();
}
class _LoginScreen2  extends State<LoginScreen2> {
final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Color bgColor = Color(0xff011224);


  poppup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: " Admin Details ",
      desc: " Email is admin \nPassword is admin123",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bgColor),
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Container(
                width: size.width > 700 ? size.width * 0.4 : size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://raw.githubusercontent.com/ASVKVINAYAK/Trinetra/admin-panel/images/trinatra%20logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Trinetra',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Attendance that you can trust!',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width > 700 ? size.width * 0.4 : size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Admin Login',
                      style: TextStyle(fontSize: 16, color: bgColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    emailTextFeild(),
                    SizedBox(
                      height: 5,
                    ),
                    passwordTextFeild(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: size.width > 700
                            ? size.width * 0.4
                            : size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgColor),
                        child: loginButton(context)),
                    SizedBox(
                      height: 3,
                    ),
                    signupButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField emailTextFeild() {
    return TextField(
      textAlign: TextAlign.center,
      controller: _emailController,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Email/UID',
        icon: Icon(Icons.alternate_email_rounded),
        hintText: 'Enter email/UID',
        hintStyle: TextStyle(color: bgColor.withOpacity(0.25)),
      ),
    );
  }

  Widget passwordTextFeild() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Password',
        icon: Icon(Icons.lock),
        hintText: 'Enter password',
        hintStyle: TextStyle(color: bgColor.withOpacity(0.25)),
      ),
    );
  }

  TextButton signupButton() {
    return new TextButton(
      onPressed: () => {},
      child: TextButton(
        child: Text("Don't have an account? Create One",
        style: TextStyle(color: bgColor),),
        onPressed: poppup,
      ),
    );
  }

  TextButton loginButton(BuildContext context) {
    return new TextButton(
      onPressed: () {
        String p = _emailController.text;
        String i = _passwordController.text;
        print(p);
        print(i);
        if (p == "admin" && i == "admin123") {
          Fluttertoast.showToast(
              msg: "Welcome Back",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              webBgColor: Colors.black,
              fontSize: 16.0);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenUI()),
              (route) => false);
        } else {
          Alert(
            context: context,
            type: AlertType.error,
            title: " Incorrect Login Details ",
            buttons: [
              DialogButton(
                child: Text(
                  "Try Again",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      },
      child: Text(
        "Log In",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}

// Container(
//         decoration: new BoxDecoration(
//           gradient: new LinearGradient(
//             begin: Alignment.centerLeft,
//             end: new Alignment(
//                 1.0, 0.0), // 10% of the width, so there are ten blinds.
//             colors: [
//               this.backgroundColor1,
//               this.backgroundColor2
//             ], // whitish to gray
//             tileMode: TileMode.repeated, // repeats the gradient over the canvas
//           ),
//         ),
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//           child: Wrap(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
//                 child: Center(
//                   child: new Column(
//                     children: <Widget>[
//                       Container(
//                         height: 100.0,
//                         width: 128.0,
//                         child: new CircleAvatar(
//                           backgroundColor: Colors.transparent,
//                           foregroundColor: this.foregroundColor,
//                           radius: 100.0,
//                           child: Image.network(
//                             "https://raw.githubusercontent.com/ASVKVINAYAK/Trinetra/admin-panel/images/trinatra%20logo.jpeg",
//                             height: 300,
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: this.foregroundColor,
//                             width: 1.0,
//                           ),
//                           shape: BoxShape.rectangle,
//                         ),
//                       ),
//                       new Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: new Text(
//                           "Trinatra Admin Panel",
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 margin: const EdgeInsets.only(left: 40.0, right: 40.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                         color: this.foregroundColor,
//                         width: 0.5,
//                         style: BorderStyle.solid),
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(left: 0.0, right: 10.0),
//                 child: new Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     new Padding(
//                       padding:
//                           EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//                       child: Icon(
//                         Icons.alternate_email,
//                         color: this.foregroundColor,
//                       ),
//                     ),
//                     new Expanded(
//                       child: emailTextFeild(),
//                     ),
//                   ],
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 margin:
//                     const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                         color: this.foregroundColor,
//                         width: 0.5,
//                         style: BorderStyle.solid),
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(left: 0.0, right: 10.0),
//                 child: new Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     new Padding(
//                       padding:
//                           EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//                       child: Icon(
//                         Icons.lock_open,
//                         color: this.foregroundColor,
//                       ),
//                     ),
//                     new Expanded(
//                       child: passwordTextFeild(),
//                     ),
//                   ],
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin:
//                     const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
//                 alignment: Alignment.center,
//                 color: Colors.pinkAccent,
//                 child: new Row(
//                   children: <Widget>[
//                     new SizedBox(
//                       width: MediaQuery.of(context).size.width - 80,
//                       height: 40,
//                       child: logiinButton(context),
//                     ),
//                   ],
//                 ),
//               ),
//               new Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: const EdgeInsets.only(
//                     left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
//                 alignment: Alignment.center,
//                 child: new Row(
//                   children: <Widget>[
//                     new SizedBox(
//                       width: MediaQuery.of(context).size.width - 100,
//                       height: 100,
//                       child: signupButton(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
