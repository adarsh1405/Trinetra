import 'package:flutter/material.dart';
import 'package:trinetra/screens/Auth/signin_page.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 32.0,
            ),
            Center(
              child: Container(
                height: 250.0,
                child: Image.asset('assets/images/welcome.png'),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Text(
                "Welcome 🙏",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 33.0,
                    letterSpacing: 0.56),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 43.0,
              width: MediaQuery.of(context).size.width * .8,
              child: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    )),
                child: Text(
                  "Login with Phone",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
