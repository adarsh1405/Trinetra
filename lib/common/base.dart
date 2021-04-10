import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/sidebar.dart';

class BaseScreen extends StatelessWidget {
  final Container body;
  final String title;
  final bool appBarPinned;
  final bool appBarFloating;

  BaseScreen({
    this.body,
    this.appBarPinned,
    this.appBarFloating,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          drawer: Drawer(
            child: Sidebar(),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                constraints.maxWidth > 600
                    ? Material(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        elevation: 2,
                        child: Sidebar(),
                      )
                    : SizedBox(),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Text(
                          "Trinetra Admin Panel",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        pinned: this.appBarPinned != null
                            ? this.appBarPinned
                            : false,
                        floating: this.appBarFloating != null
                            ? this.appBarFloating
                            : false,
                        leading: constraints.maxWidth < 600 ? null : SizedBox(),
                        backgroundColor: Colors.white,
                        iconTheme:
                            IconThemeData(color: Theme.of(context).accentColor),
                      ),
                      SliverFillRemaining(
                        child: this.body,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
