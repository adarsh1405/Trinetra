import 'dart:developer';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trinetra/constants.dart';
import 'package:trinetra/helper/api_helper.dart';
import 'package:trinetra/models/profile_model.dart';

import 'components/AttendanceCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.userProfile}) : super(key: key);
  final ProfileModel userProfile;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<ProfileModel> futureProfile;

  @override
  void initState() {
    super.initState();
    _refreshProfile();
  }

  Future<ProfileModel> _refreshProfile() async {
    final ApiHelper _apiHelper = new ApiHelper();
    log('Refreshing!.....');
    ProfileModel _profile = await _apiHelper.getProfile();
    setState(() {
      futureProfile = Future.value(_profile);
      profile = _profile;
    });
    log('Refreshed!!!');
    return _profile;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () => _refreshProfile(),
      color: Color(0xffBF5FFE),
      child: FutureBuilder<ProfileModel>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xffBF5FFE)),
              ));
            return SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),

                      /// Header Name id and photo
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText.rich(
                                      TextSpan(
                                        text: 'Hello 👋,\n',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontStyle: FontStyle.italic,
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${widget.userProfile.name}\n',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                'Id: ${widget.userProfile.employeeId}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white60),
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.start,
                                      wrapWords: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.indigo[200],
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'https://techspace-trinetra.herokuapp.com${widget.userProfile.photo}',
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Location
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ListTile(
                            enabled: true,
                            // tileColor: Theme.of(context).cardColor,
                            trailing: Icon(Icons.location_on),
                            title: AutoSizeText('Your Current Location'),
                            subtitle: AutoSizeText(geoAddress.addressLine),
                          ),
                        ),
                      ),

                      /// Attendance card
                      widget.userProfile.overall.total == 0
                          ? Container(
                              height: size.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'No Data to Display Yet.\nCome Back Soon!',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          : AttendanceCard(
                              size: size, userProfile: widget.userProfile),

                      /// Current Attendance
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        width: size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Today\'s Attendance',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: size.width * 0.9,
                              child: widget.userProfile.current.logs.isEmpty
                                  ? Text(
                                      'No Attendance to Show!',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )
                                  : Wrap(
                                      alignment: WrapAlignment.spaceAround,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      runSpacing: 20,
                                      spacing: 10,
                                      runAlignment: WrapAlignment.center,
                                      children: [
                                        for (var att
                                            in widget.userProfile.current.logs)
                                          Column(
                                            children: [
                                              (att.available)
                                                  ? Icon(
                                                      Icons.beenhere_rounded,
                                                      color: Colors.green[900],
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .highlight_remove_rounded,
                                                      color: Colors.red[900],
                                                    ),
                                              AutoSizeText(
                                                DateFormat.jm()
                                                    .format(att.timestamp),
                                                style: TextStyle(
                                                    color:
                                                        Colors.blueGrey[800]),
                                              ),
                                            ],
                                          ),
                                        // Icon(
                                        //   Icons.beenhere_rounded,
                                        //   color: Colors.green[900],
                                        // ),
                                        // Icon(
                                        //   Icons.beenhere_outlined,
                                        //   color: Colors.blueGrey,
                                        // ),
                                        // Icon(
                                        //   Icons.beenhere_outlined,
                                        //   color: Colors.blueGrey,
                                        // ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
