import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trinetra/constants.dart';
import 'package:trinetra/helper/api_helper.dart';
import 'package:trinetra/screens/Auth/verify_otp.dart';
import 'package:trinetra/screens/HomePage.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  // User _firebaseUser;
  // ignore: unused_field
  String _status = '';
  bool isLoading = false;

  // ignore: unused_field
  AuthCredential _phoneAuthCredential;
  String _verificationId;
  // ignore: unused_field
  int _code;

  @override
  void initState() {
    super.initState();
    // _getFirebaseUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              padding(32.0, 32.0),
              Center(
                child: Container(
                  height: 250.0,
                  child: Image.asset('assets/images/phoneauth.png'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                  child: Text(
                    "Verification",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33.0,
                        letterSpacing: 0.56),
                  )),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 13.0),
                      children: [
                    TextSpan(
                        text: "We will send you a ",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14.5,
                        )),
                    TextSpan(
                        text: "One Time Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 14.5,
                        )),
                  ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.white60, fontSize: 13.0),
                      children: [
                    TextSpan(
                        text: "on your phone number",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14.5,
                        )),
                  ])),
              padding(20.0, 20.0),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextFormField(
                  controller: phoneController,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // fillColor: Colors.grey[200],

                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black87, fontSize: 13.0),
                            children: [
                              TextSpan(
                                  text: "+91 ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              TextSpan(
                                  text: " | ",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 17.0,
                                  )),
                            ]),
                      ),
                    ),
                  ),
                  validator: (value) =>
                      value.length != 10 ? 'Incorrect number entered' : null,
                ),
              ),
              padding(15.0, 15.0),
              isLoading
                  ? CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xffBF5FFE)),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      height: 43.0,
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextButton(
                          onPressed: _submitPhoneNumber,
                          child: Text("Login with OTP",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                letterSpacing: 2.0,
                              )))),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  padding(top, bottom) {
    return Padding(padding: EdgeInsets.only(top: top, bottom: bottom));
  }

  void _handleError(e) {
    print(e.message);
    Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    setState(() {
      _status += e.message + '\n';
    });
  }

  Future<void> _submitPhoneNumber() async {
    setState(() {
      isLoading = true;
    });

    /// NOTE: Either append your phone number country code or add in the code itself
    /// use "+91 " as prefix `phoneNumber`
    String phoneNumber = "+91 " + phoneController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      try {
        print('verificationCompleted');
        setState(() {
          _status += 'verificationCompleted\n';
          isLoading = false;
        });
        this._phoneAuthCredential = phoneAuthCredential;
        Fluttertoast.showToast(msg: 'Verification Completed!');
        print(phoneAuthCredential);
      } on Exception catch (e) {
        _handleError(e);
      }
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      Fluttertoast.showToast(
          msg: 'Verification Failed!', backgroundColor: Colors.red);
      _handleError(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
      Fluttertoast.showToast(msg: 'Code Sent Sucessful!');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOTP(
              veryfyOtp: (String otp) => _submitOTP(otp),
              phoneNo: phoneNumber,
            ),
          ));
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  Future<void> _submitOTP(String otp) async {
    /// get the `smsCode` from the user
    String smsCode = otp.trim(); //otpController.text.toString().trim();

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    try {
      setState(() {
        this._phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: this._verificationId, smsCode: smsCode);
      });
      // await FirebaseAuth.instance.currentUser
      //     .updatePhoneNumber(this._phoneAuthCredential);
      // Fluttertoast.showToast(msg: 'Phone No. Added Sucessful!');
      SharedPreferences pref = await SharedPreferences.getInstance();
      // await pref.setBool('loggedIn', true);
      await pref.setString('phone', '+91' + phoneController.text);
      phone = '+91' + phoneController.text;
      ApiHelper _apiHelper = new ApiHelper();
      await _apiHelper.login(imei: '12345', phone: phoneController.text);
      profile = await _apiHelper.getProfile();
      log(profile.toJson());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error adding Phone No.: ' + e.toString(),
          backgroundColor: Colors.red);
      log(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
