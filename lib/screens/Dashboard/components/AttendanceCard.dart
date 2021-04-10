import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trinetra/models/profile_model.dart';

import 'gauge_chart.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    Key key,
    @required this.size,
    this.userProfile,
  }) : super(key: key);

  final ProfileModel userProfile;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff86EABA), Color(0xffDDA9ED)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Attendance',
              style: TextStyle(
                  color: Theme.of(context).backgroundColor, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  presentAbsentCard(
                      name: 'Present',
                      valueColor: Colors.green,
                      value: userProfile.overall.present,
                      total: userProfile.overall.total,
                      size: size,
                      context: context),
                  presentAbsentCard(
                      name: 'Absent',
                      valueColor: Colors.red,
                      value: userProfile.overall.total -
                          userProfile.overall.present,
                      total: userProfile.overall.total,
                      size: size,
                      context: context),
                  // Divider(
                  //   color: Colors.blueGrey[900],
                  //   thickness: 5,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total Classes: ${userProfile.overall.total}',
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  child: GaugeChart.withData(
                    absent:
                        userProfile.overall.total - userProfile.overall.present,
                    present: userProfile.overall.present,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container presentAbsentCard(
      {BuildContext context,
      String name,
      int value,
      int total,
      Size size,
      Color valueColor}) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(5),
      width: size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.2)),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.0,
            sigmaY: 1.0,
          ),
          child: RichText(
            text: TextSpan(
              text: '$name\n',
              style: TextStyle(
                  color: Theme.of(context).backgroundColor, fontSize: 20),
              children: [
                TextSpan(
                  text: '$value ',
                  style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: '(${(value / total * 100).toStringAsPrecision(3)}%)',
                  style: TextStyle(color: valueColor, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
