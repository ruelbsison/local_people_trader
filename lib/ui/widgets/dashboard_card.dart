import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

typedef PressedDashboard<T> = void Function();

class DashboardCard extends StatefulWidget {
  final String title;
  final String message;
  PressedDashboard onPressedDashboard;

  DashboardCard({Key key, this.title, this.message, this.onPressedDashboard}) : super(key: key);
  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: (){
          if (widget.onPressedDashboard != null)
            widget.onPressedDashboard();
        },
      child: BoxContainerWidget (
          height: 171,
          width: size.width,
          //width: ((size.width - 40) / 2),
          child: Flex (
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.message,
                  textAlign: TextAlign.left,
                  style: textTheme.bodyText1,
                  //color: Color.fromRGBO(1, 43, 58, 1),
                ),
              ),
              ElevatedButton(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  if (widget.onPressedDashboard != null)
                    widget.onPressedDashboard();
                },
              ),
            ],
          )
      ),
    );
  }
}
