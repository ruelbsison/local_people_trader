import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String message;

  DashboardCard({Key key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            padding: EdgeInsets.all(12.0),
            //width: (size.width - 48) / 2,
            //width: double.infinity,
            height: 171,
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
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.left,
                    style: textTheme.bodyText1,
                    //color: Color.fromRGBO(1, 43, 58, 1),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    title,
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
              ],
            )
        ),
    );
  }
}
