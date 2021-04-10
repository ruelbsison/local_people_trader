import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../schedule/ui/widgets/schedule_next_job_widget.dart';
import '../widgets/dashboard_card.dart';
import 'package:intl/intl.dart';

class TraderHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(
          AppLocalizations.of(context).appTitle,
        ),
        appBar: AppBar(),
      ),
      body: buildBody(context),
    );
  }

  _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    //return RefreshIndicator(
    //  onRefresh: () => homeProvider.getFeeds(),
    return SafeArea(
      //child: SingleChildScrollView(
      child: ListView(
        // child: ResponsiveWrapper(
        //     // defaultScale: true,
        //     maxWidth: 812,
        //     minWidth: 375,
        //     defaultName: MOBILE,
        //     breakpoints: [
        //       ResponsiveBreakpoint.autoScale(375, name: MOBILE),
        //       ResponsiveBreakpoint.resize(600, name: MOBILE),
        //       ResponsiveBreakpoint.resize(850, name: TABLET),
        //       ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        //   ],
        //   mediaQueryData: MediaQueryData(size: Size(375, 812), devicePixelRatio: 3),
        //child: Column (
        children: <Widget>[
          SizedBox(height: 20.0),
          _buildSectionTitle(context, 'Your Next Job'),
          SizedBox(height: 10.0),
          ScheduleNextJobWidget(
            jobName: 'Job Name / Description ',
            jobAddress: 'Job Address line 1, Job Address line 2,\nPost code ',
            jobMessage: 'You need to leave in 10 minutes ',
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: _buildSectionTitle(context, 'My Bids'),
              ),
              Expanded(
                  child: _buildSectionTitle(context, 'Opportunities'),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DashboardCard(
                  title: 'My Bids',
                  message: 'You have XXX bids expiring today. '
              ),
              DashboardCard(
                  title: 'Opportunities',
                  message:
                      '21 suitable opportunities expire in the next 24 hours. '
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: _buildSectionTitle(context, 'Payments'),
              ),
              Expanded(
                child: _buildSectionTitle(context, 'Outstanding'),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DashboardCard(
                  title: 'Payments',
                  message: '£XX.XX Received! '
              ),
              DashboardCard(
                  title: 'Outstanding',
                  message: '3 Payments totalling £XX.XX due this week.  '
              ),
            ],
          ),
          SizedBox(height: 20.0),
          SizedBox(height: 20.0),
        ],
          ),
        //),
      //),
    );
  }

  /*Widget _buildBody(BuildContext context) {
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: ResponsiveWrapper(
          // defaultScale: true,
          maxWidth: 1200,
          minWidth: 375,
          defaultName: MOBILE,
          breakpoints: [
            /* ResponsiveBreakpoint.resize(375, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),*/
            ResponsiveBreakpoint.autoScale(375, name: MOBILE),
            ResponsiveBreakpoint.resize(600, name: MOBILE),
            ResponsiveBreakpoint.resize(850, name: TABLET),
            ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
          child: Column (children: <Widget>[
            SizedBox(height: 20.0),
            _buildSectionTitle(context, "Your Next Job"),
            SizedBox(height: 20.0),
            //_buildJobNotification(context),
          ]),
        ),
      ),
    ]);
  }*/
}
