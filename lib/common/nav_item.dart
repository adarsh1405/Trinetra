import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final Widget leading;
  final Widget trailing;
  final Widget title;
  final Widget subtitle;
  final String path;
  final Object arguments;
  final double height;
  final Color hoveColor;
  final Widget pushtoScreen;
  final Function onTap;

  NavItem({
    this.hoveColor,
    this.height,
    this.leading,
    this.path,
    this.arguments,
    @required this.title,
    this.subtitle,
    this.trailing,
    Key key,
    this.pushtoScreen,
    this.onTap,
  }) : super(key: key);

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: MouseRegion(
          child: Container(
            height: this.widget.height != null ? this.widget.height : 40,
            width: MediaQuery.of(context).size.width,
            decoration: ModalRoute.of(context).settings.name == this.widget.path
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  )
                : _hover
                    ? BoxDecoration(
                        color: widget.hoveColor != null
                            ? widget.hoveColor
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      )
                    : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                this.widget.leading != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: IconTheme(
                            data: IconThemeData(
                                color: ModalRoute.of(context).settings.name ==
                                        this.widget.path
                                    ? Theme.of(context).accentColor
                                    : _hover
                                        ? Theme.of(context).accentColor
                                        : Colors.white),
                            child: this.widget.leading))
                    : SizedBox(),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      child: this.widget.subtitle != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                this.widget.title,
                                this.widget.subtitle != null
                                    ? Expanded(child: this.widget.subtitle)
                                    : SizedBox()
                              ],
                            )
                          : this.widget.title != null
                              ? this.widget.title
                              : SizedBox(),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ModalRoute.of(context).settings.name ==
                              this.widget.path
                          ? Theme.of(context).accentColor
                          : _hover
                              ? Theme.of(context).accentColor
                              : Colors.white,
                    ),
                  ),
                ),
                this.widget.trailing != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: IconTheme(
                          data: IconThemeData(
                            color: _hover
                                ? Theme.of(context).accentColor
                                : Colors.white,
                          ),
                          child: this.widget.trailing,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          onHover: (PointerEvent event) {
            setState(() {
              _hover = true;
            });
          },
          onExit: (PointerEvent event) {
            setState(() {
              _hover = false;
            });
          },
        ),
      ),
      onTap: this.widget.onTap ??
          () {
            if (this.widget.path != null) {
              Navigator.of(context).pushNamed(this.widget.path,
                  arguments: this.widget.arguments);
            }
            if (this.widget.pushtoScreen != null)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => this.widget.pushtoScreen,
                  ));
          },
    );
  }
}
