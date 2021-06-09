import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';

typedef PressedNextJob<T> = void Function(T item);

class ScheduleNextJobWidget extends StatefulWidget {
  //final Job job;
  final String jobName;
  final String jobAddress;
  final String jobMessage;
  PressedNextJob<String> onPressedNextJob;

  ScheduleNextJobWidget(
      {Key key,
        //this.job,
        this.jobName,
        this.jobAddress,
      this.jobMessage,
      this.onPressedNextJob})
      : super(key: key);
  @override
  _ScheduleNextJobWidgetState createState() => _ScheduleNextJobWidgetState();
}

class _ScheduleNextJobWidgetState extends State<ScheduleNextJobWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        //AppRouter.pushPage(context, JobDetailScreen(job: widget.job),);
        AppRouter.pushPage(context, JobScreen(),);
      },
      child: Card(
        //elevation: 2,
        color: Color.fromRGBO(255, 255, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          //margin: EdgeInsets.all(8.0),
          // decoration: BoxDecoration(
          //   color: Color.fromRGBO(255, 255, 255, 1),
          //   borderRadius: BorderRadius.circular(5.0),
          // ),
          //color: Colors.white,
          //padding: EdgeInsets.all(kDefaultPadding),
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          padding: EdgeInsets.all(12.0),
          //padding: const EdgeInsets.symmetric(
          //    horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
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
                      style: textTheme.subtitle1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "CONFIRMED",
                        style: textTheme.overline.copyWith(color: Colors.white,),
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
                style: textTheme.bodyText2,
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
                  style: textTheme.button.copyWith(color: Color.fromRGBO(255, 255, 255, 1),),
                ),
                onPressed: () {
                  //AppRouter.pushPage(context, JobBidScreen(job: widget.job,));
                  AppRouter.pushPage(context, JobScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
