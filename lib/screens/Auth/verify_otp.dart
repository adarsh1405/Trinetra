import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyOTP extends StatefulWidget {
  final Function veryfyOtp;
  final phoneNo;

  const VerifyOTP({Key key, this.veryfyOtp, this.phoneNo}) : super(key: key);
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController digit1 = new TextEditingController();
  TextEditingController digit2 = new TextEditingController();
  TextEditingController digit3 = new TextEditingController();
  TextEditingController digit4 = new TextEditingController();
  TextEditingController digit5 = new TextEditingController();
  TextEditingController digit6 = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();

  bool isLoading = false;

  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              padding(25.0, 25.0),
              Center(
                child: Container(
                  height: height * .35,
                  child: Image.asset('assets/images/otpverify.png'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33.0,
                        letterSpacing: 0.56),
                  )),
              padding(25.0, 25.0),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 13.0),
                      children: [
                    TextSpan(
                        text: "Please enter the ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.5,
                        )),
                    TextSpan(
                        text: "OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14.5,
                        )),
                    TextSpan(
                        text: " sent to ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.5,
                        )),
                  ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 13.0),
                      children: [
                    TextSpan(
                        text: "mobile number +91 xxxxxxxxxx",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.5,
                        )),
                  ])),
              padding(20.0, 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      // onEditingComplete: () =>
                      //     FocusScope.of(context).nextFocus(),
                      onChanged: (value) => FocusScope.of(context).nextFocus(),
                      // textInputAction: TextInputAction.newline,
                      textAlign: TextAlign.center,
                      controller: digit1,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      controller: digit2,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      controller: digit3,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      controller: digit4,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => FocusScope.of(context).nextFocus(),
                      controller: digit5,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => FocusScope.of(context).unfocus(),
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      controller: digit6,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        hoverColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ),
                ],
              ),
              padding(15.0),
              Text(
                "Expiring In 00:$_start ",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12.0,

                  // letterSpacing: 0.85,
                ),
              ),

              TextButton(
                  onPressed: () => Navigator.pop(context),
                  // splashColor: Colors.pink[200],
                  child: Text(
                    "RESEND CODE",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.85,
                    ),
                  )),
              // padding(height / 22),
              Spacer(),
              Align(
                alignment: AlignmentDirectional.center,
                child: Column(
                  children: [
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xffBF5FFE)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * .8,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  widget.veryfyOtp(digit1.text +
                                      digit2.text +
                                      digit3.text +
                                      digit4.text +
                                      digit5.text +
                                      digit6.text);
                                },
                                child: Text("Verify",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                    )))),
                    padding(5.0),
                    GestureDetector(
                      onTap: () {
                        // showDialog(context);
                        Navigator.pop(context);
                      },
                      child: Text("Change Mobile Number",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 13.5,
                          )),
                    ),
                  ],
                ),
              ),
              padding(height * .02, height * .02),
            ],
          ),
        ),
      ),
    );
  }

  padding(top, [bottom = 0.0]) {
    return Padding(padding: EdgeInsets.only(top: top, bottom: bottom));
  }

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Confirm Phone number change"),
                        Padding(padding: EdgeInsets.all(22.0)),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              // key: __passwordkey,
                              controller: phoneNumber,
                              keyboardType: TextInputType.number,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.email,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter new Phone number"),

                              validator: (value) => value.length < 10
                                  ? 'Enter a valid number'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 40,
                            width: 150,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Reset",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: 1.2,
                                    )))),
                      ],
                    ))),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
