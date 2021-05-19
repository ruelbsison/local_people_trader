import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

typedef PressedNextJob<T> = void Function(T item);

class ScheduleNextJobWidget extends StatefulWidget {
  final String jobName;
  final String jobAddress;
  final String jobMessage;
  PressedNextJob<String> onPressedNextJob;

  ScheduleNextJobWidget(
      {Key key, this.jobName, this.jobAddress, this.jobMessage, this.onPressedNextJob})
      : super(key: key);
  @override
  _ScheduleNextJobWidgetState createState() => _ScheduleNextJobWidgetState();
}

class _ScheduleNextJobWidgetState extends State<ScheduleNextJobWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      //color: Colors.white,
      //padding: EdgeInsets.all(kDefaultPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.jobName,
                  textAlign: TextAlign.left,
                  style: textTheme.bodyText1,
                ),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    "CONFIRMED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: "RedHatDisplay",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(
                    0xff8ed159,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                //width: 82,
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            widget.jobAddress,
            textAlign: TextAlign.left,
            style: textTheme.overline,
          ),
          SizedBox(height: 30.0),
          Text(
            widget.jobMessage.toUpperCase(),
            textAlign: TextAlign.left,
            style: textTheme.caption,
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(255, 99, 95, 1),
              onPrimary: Color.fromRGBO(170, 186, 205, 1),
            ),
            child: Text(
              "View Schedule",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              if (widget.onPressedNextJob != null)
                widget.onPressedNextJob(widget.jobName);
            },
          ),
        ],
      ),
    );
  }
}
