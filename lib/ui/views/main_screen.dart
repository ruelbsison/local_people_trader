import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';
import 'package:intl/intl.dart';

import 'home_trader.dart';
import 'schedule_screen.dart';
import 'opportunities_screen.dart';
import 'search_screen.dart';
import 'message_screen.dart';
import 'more_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            TraderHomeScreen(),
            OpportunitiesScreen(),
            SearchScreen(),
            MessageScreen(),
            MoreScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey[500],
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.schedule,
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleSchedule,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.work,
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleOpportunities,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.search,
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleSearch,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.message,
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleMessages,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.menu,
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleMore,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}