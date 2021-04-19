import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarPreferredSize: Size.fromHeight(80.0),
        title: Text(
          AppLocalizations.of(context).appTitle,
        ),
        subTitle: LocalPeopleLocalizations.of(context).menuTitleSchedule,
        appBar: AppBar(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  left: 58,
                  top: 16,
                  child: SizedBox(
                    child: Text(
                      "Job request / description",
                      style: TextStyle(
                        color: Color(
                          0xff012b3a,
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "RedHatDisplay",
                      ),
                    ),
                    width: 247,
                    height: 20,
                  ),
                ),
                Positioned(
                  left: 255,
                  top: 17,
                  child: SizedBox(
                    child: Text(
                      "£XXX",
                      style: TextStyle(
                        color: Color(
                          0xff012b3a,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: "RedHatDisplay",
                      ),
                      textAlign: TextAlign.right,
                    ),
                    width: 90,
                    height: 22,
                  ),
                ),
                Positioned(
                  left: 26.6,
                  top: 24.97,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 6.56,
                      height: 6.38,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 11,
                  top: 52,
                  child: SizedBox(
                    child: Text(
                      "2 Hours Left",
                      style: TextStyle(
                        color: Color(
                          0xffff993c,
                        ),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: "RedHatDisplay",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    width: 37,
                    height: 22,
                  ),
                ),
                Positioned(
                  left: 58,
                  top: 73,
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          child: SizedBox(
                            child: Text(
                              "Job Posted",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: "RedHatDisplay",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            width: 85,
                            height: 19,
                          ),
                          width: 85,
                          height: 19,
                          decoration: BoxDecoration(
                            color: Color(
                              0xffaabacd,
                            ),
                            borderRadius: BorderRadius.circular(
                              2,
                            ),
                          ),
                        ),

                        /// stack requires empty non positioned widget to work properly. refer: https://github.com/flutter/flutter/issues/49631#issuecomment-582090992
                        Container(),
                      ],
                    ),
                    width: 85,
                    height: 19,
                  ),
                ),
                Positioned(
                  left: 59,
                  top: 48,
                  child: SizedBox(
                    child: Text(
                      "22 June 2023  |  1 Hour",
                      style: TextStyle(
                        color: Color(
                          0xff012b3a,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "RedHatDisplay",
                      ),
                    ),
                    width: 284,
                    height: 13,
                  ),
                ),

                /// stack requires empty non positioned widget to work properly. refer: https://github.com/flutter/flutter/issues/49631#issuecomment-582090992
                Container(),
              ],
            ),
            width: 361,
            height: 101,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
          ),

          /// stack requires empty non positioned widget to work properly. refer: https://github.com/flutter/flutter/issues/49631#issuecomment-582090992
          Container(),
        ],
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}