import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_schedule/schedule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/quote.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/schedule.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/auth.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
//class ScheduleScreen extends StatelessWidget {
  TraderProfile profile;
  ScheduleBloc scheduleBloc;
  List<FlutterWeekViewEvent> eventSchedules = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        //appBarPreferredSize: Size.fromHeight(80.0),
        title: Text(
          //AppLocalizations.of(context).appTitle,
          LocalPeopleLocalizations.of(context).menuTitleSchedule,
          style: theme.textTheme.headline6,
        ),
        //subTitle: LocalPeopleLocalizations.of(context).menuTitleSchedule,
        //appBar: AppBar(),
      ),
      body: _buildBody(context),
    );
  }

  Widget getCalendarWidget(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return DayView(
      initialTime: const HourMinute(hour: 7),
      date: eventSchedules != null && eventSchedules.length > 0
          ? eventSchedules[0].start
          : date,
      style: DayViewStyle.fromDate(
        date: date,
        currentTimeCircleColor: Colors.pink,
      ),
      dayBarStyle: DayBarStyle(
        color: Colors.white,
      ),
      events: eventSchedules,
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    scheduleBloc = ScheduleBloc(
      appType: appType,
      jobRepository: RepositoryProvider.of<JobRepository>(context),
      quoteRepository: RepositoryProvider.of<QuoteRepository>(context),
      bookingRepository: RepositoryProvider.of<BookingRepository>(context),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    );
    scheduleBloc.add(ScheduleLoadEvent());
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: scheduleBloc,
      builder: (context, state) {
        if (state is ScheduleLoadFailed) {
          return getCalendarWidget(context);
        } else if (state is ScheduleLoaded) {
          eventSchedules.clear();
          List<Schedule> traderSchedule = state.schedules;
          if (traderSchedule != null && traderSchedule.length > 0) {
            traderSchedule.forEach((element) {
              final calEvent = FlutterWeekViewEvent(
                title: element.title,
                description: element.description,
                start: element.startDateTime,
                end: element.endDateTime,
              );
              eventSchedules.add(calEvent);
            });
          }
          return getCalendarWidget(context);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    try {
      TraderProfile traderProfile = sl<TraderProfile>();
      if (traderProfile == null)
        context.read<ProfileBloc>().add(ProfileGetEvent());
      else {
        return _buildBodyContent(context);
      }
    } catch (e) {
      context.read<ProfileBloc>().add(ProfileGetEvent());
    }
    return BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) {
      // return true/false to determine whether or not
      // to invoke listener with state
      print('listenWhen: previous is $previous, current is $current');

      if (previous is ProfileLoading && current is ProfileDoesNotExists) {
        return true;
      } else if (previous is ProfileCreating && current is ProfileCreated) {
        return true;
      } else if (previous is ProfileLoading && current is TraderProfileLoaded) {
        return true;
      } else if (previous is TraderProfileGetLoading &&
          current is TraderProfileGetLoaded) {
        return true;
      }
      return false;
    }, listener: (context, state) {
      // do stuff here based on BlocA's state
      print('listener: current is $state');

      if (state is ProfileCreated) {
        sl.unregister<TraderProfile>();
        locatorAddTraderProfile(state.profile);
        profile = state.profile;
        AppRouter.pushPage(
            context,
            DialogManager(
              child: ProfileScreen(
              profile: profile,
            ),
            ),
        );
        context.read<ProfileBloc>().add(TraderProfileGetEvent(id: profile.id));
      } else if (state is ProfileDoesNotExists) {
        context.read<ProfileBloc>().add(ProfileCreateEvent());
      } else if (state is TraderProfileLoaded) {
        sl.unregister<TraderProfile>();
        locatorAddTraderProfile(state.profile);
        profile = state.profile;
      } else if (state is TraderProfileGetLoaded) {
        sl.unregister<TraderProfile>();
        locatorAddTraderProfile(state.profile);
        profile = state.profile;
      }
    }, buildWhen: (previous, current) {
      // return true/false to determine whether or not
      // to rebuild the widget with state
      print('buildWhen: previous is $previous, current is $current');
      if (previous is ProfileInitialState && current is ProfileLoading) {
        return true;
      } else if (previous is ProfileLoading && current is ProfileNotLoaded) {
        return true;
      } else if (previous is ProfileCreating &&
          current is ProfileCreateFailed) {
        return true;
      } else if (previous is TraderProfileGetLoading &&
          current is TraderProfileGetFailed) {
        return true;
      } else if (previous is TraderProfileGetLoading &&
          current is TraderProfileGetLoaded) {
        return true;
      } else if (previous is ProfileTraderTopRatedLoading &&
          current is ProfileTraderTopRatedCompleted) {
        return false;
      } else if (previous is ProfileLoading &&
          current is ProfileDoesNotExists) {
        return false;
      } else if (previous is ProfileCreating && current is ProfileCreated) {
        return false;
      } else if (previous is ProfileLoading && current is TraderProfileLoaded) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      // return widget here based on BlocA's state
      print('builder: current is $state');
      if (state is ProfileTraderTopRatedFailed ||
          state is ClientProfileGetFailed ||
          state is ProfileCreateFailed ||
          state is ProfileNotLoaded ||
          state is ClientProfileUpdateFailed ||
          state is TraderProfileUpdateFailed ||
          state is TraderProfileGetFailed) {
        return ErrorWidget('Error: $state');
      } else if (state is TraderProfileGetLoaded) {
        return _buildBodyContent(context);
      } else if (state is TraderProfileLoaded) {
        return _buildBodyContent(context);
      }
      return LoadingWidget();
    });
  }
}
