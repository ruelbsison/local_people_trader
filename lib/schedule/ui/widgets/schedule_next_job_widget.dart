import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ScheduleNextJobWidget extends StatelessWidget {
  final String jobName;
  final String jobAddress;
  final String jobMessage;

  ScheduleNextJobWidget(
      {Key key, this.jobName, this.jobAddress, this.jobMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0),
      padding: EdgeInsets.all(12.0),
      width: size.width,
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),*/
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        /*boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 5,
          ),
        ],*/
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Text(
                  jobName,
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
            jobAddress,
            textAlign: TextAlign.left,
            style: textTheme.overline,
          ),
          SizedBox(height: 30.0),
          Text(
            jobMessage.toUpperCase(),
            textAlign: TextAlign.left,
            style: textTheme.caption,
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(
                0xffff6361,
              ),
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
            onPressed: () {},
          ),
          /*Container(
            child: Center(
              child: Text(
                "View Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: "RedHatDisplay",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            width: 325,
            height: 36,
            padding: EdgeInsets.symmetric(
              horizontal: 38,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Color(
                0xffff6361,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
