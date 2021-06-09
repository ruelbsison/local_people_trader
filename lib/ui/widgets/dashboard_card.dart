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
        child: Card(
          //elevation: 2,
          color: Color.fromRGBO(255, 255, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        child: Container(
          height: 171,
          width: size.width,
          //margin: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          padding: EdgeInsets.all(12.0),
          // decoration: BoxDecoration(
          //   color: Color.fromRGBO(255, 255, 255, 1),
          //   borderRadius: BorderRadius.circular(5.0),
          // ),
          //color: Colors.white,
          //padding: EdgeInsets.all(kDefaultPadding),
          //padding: const EdgeInsets.symmetric(
          //    horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
          child: Flex (
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.message,
                  textAlign: TextAlign.left,
                  style: textTheme.subtitle1,
                  //color: Color.fromRGBO(1, 43, 58, 1),
                ),
              ),
              ElevatedButton(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: textTheme.button.copyWith(color: Color.fromRGBO(255, 255, 255, 1),),
                ),
                onPressed: () {
                  if (widget.onPressedDashboard != null)
                    widget.onPressedDashboard();
                },
              ),
            ],
          )
      ),
      ),
    );
  }
}
