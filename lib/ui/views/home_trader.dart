import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/schedule_next_job_widget.dart';
import '../widgets/dashboard_card.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';

class TraderHomeScreen extends StatefulWidget {
  @override
  _TraderHomeScreenState createState() => _TraderHomeScreenState();
}

class _TraderHomeScreenState extends State<TraderHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6Style = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBarWidget buildAppBar() {
    return AppBarWidget(
      //appBarPreferredSize: Size.fromHeight(188.0),
      title: Text(
        AppLocalizations.of(context).appTitle,
      ),
      subTitle: DateFormatUtil.getFormattedDate(),
      appBar: AppBar(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
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

  Widget buildBody() { //BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDoesNotExists) {
          context.read<ProfileBloc>().add(ProfileCreateEvent());
          return LoadingWidget();
        } if (state is ProfileCreating) {
          return LoadingWidget();
        } else if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileCreated) {
          AppRouter.pushPage(context, ProfileScreen(profile: state.profile,));
          return _buildBodyContent(context);
        } else if (state is ProfileCreateFailed) {
          return ErrorWidget(state.toString());
        } else if (state is ProfileNotLoaded) {
          return ErrorWidget(state.toString());
        } else if (state is TraderProfileLoaded) {
          return _buildBodyContent(context);
        }
        return ErrorWidget('Unhandle State $state');
      },
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    //return RefreshIndicator(
    //  onRefresh: () => homeProvider.getFeeds(),
    BlocProvider.of<ProfileBloc>(context).add(ProfileGetEvent());
    return SafeArea (
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        //child: Column (
        children: <Widget>[
          SizedBox(height: 20.0),
          _buildSectionTitle(context, 'Your Next Job'),
          SizedBox(height: 10.0),
          ScheduleNextJobWidget(
            //jobName: 'Job Name / Description ',
            //jobAddress: 'Job Address line 1, Job Address line 2,\nPost code ',
            jobMessage: 'You need to leave in 10 minutes ',
            onPressedNextJob: (String item) {
              AppRouter.pushPage(context, JobScreen());
            },
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
          Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: DashboardCard(
                    title: 'My Bids',
                    message: 'You have XXX bids expiring today. '
                ),
              ),
              Expanded(
                flex: 1,
                child: DashboardCard(
                    title: 'Opportunities',
                    message:
                    '21 suitable opportunities expire in the next 24 hours. ',
                  onPressedDashboard: () {
                    AppRouter.pushPage(context, JobScreen());
                  },
                ),
              )
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
          Flex (
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: DashboardCard(
                    title: 'Payments',
                    message: '£XX.XX Received! '
                ),
              ),
              Expanded(
                flex: 1,
                child: DashboardCard(
                    title: 'Outstanding',
                    message: '3 Payments totalling £XX.XX due this week.  '
                ),
              )
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
}
