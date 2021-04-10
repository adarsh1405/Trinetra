import 'package:flutter/material.dart';
import 'package:trinetra/constants.dart';
import 'package:trinetra/helper/localAuth_helper.dart';
import 'package:trinetra/screens/Dashboard/dashboard.dart';
import 'package:trinetra/screens/History/history.dart';
import 'package:trinetra/widgets/BubbleBottomBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return profile == null
        ? Scaffold(
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 100,
                    ),
                    Text(
                      'Server Error!!\nRestart Your App Again',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: currentIndex == 0
                  ? Dashboard(
                      userProfile: profile,
                    )
                  : History(),
              floatingActionButton: FloatingActionButton(
                onPressed: () async =>
                    await LocalAuthHelper.authenticateandSaveLocation(),
                child: Icon(
                  Icons.how_to_reg,
                  color: Colors.white,
                ),
                // backgroundColor: Colors.indigo[400],
                elevation: 0,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BubbleBottomBar(
                hasNotch: true,
                backgroundColor: Color(0xff232531),
                // Colors.black38,
                // Colors.transparent,
                fabLocation: BubbleBottomBarFabLocation.end,
                opacity: .2,
                currentIndex: currentIndex, tilesPadding: EdgeInsets.all(5),
                onTap: changePage,
                // borderRadius:
                // BorderRadius.vertical(
                //   top: Radius.circular(5),
                // ), //border radius doesn't work when the notch is enabled.
                elevation: 8,
                hasInk: true,
                inkColor: Color(0xff181926).withOpacity(0.2),
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.dashboard,
                        color: Colors.white60,
                      ),
                      activeIcon: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                      ),
                      title: Text("Dashboard")),
                  BubbleBottomBarItem(
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.history_toggle_off_rounded,
                        color: Colors.white60,
                      ),
                      activeIcon: Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title: Text("History")),
                ],
              ),
            ),
          );
  }
}
