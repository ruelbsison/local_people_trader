import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';

import 'home_trader.dart';
import 'search_screen.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            JobScreen(),
            SearchScreen(),
            MessageBoxScreen(),
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
              // icon: Icon(
              //   MaterialIcons.schedule,
              // ),
              icon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/schedule-icon.svg'
              ),
              activeIcon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/schedule-active-icon.svg'
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleSchedule,
            ),
            BottomNavigationBarItem(
              // icon: Icon(
              //   MaterialIcons.work,
              // ),
              icon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/opportunities-icon.svg'
              ),
              activeIcon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/opportunities-active-icon.svg'
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleOpportunities,
            ),
            BottomNavigationBarItem(
              // icon: Icon(
              //   MaterialIcons.search,
              // ),
              icon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/search-icon.svg'
              ),
              activeIcon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/search-active-icon.svg'
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleSearch,
            ),
            BottomNavigationBarItem(
              // icon: Icon(
              //   MaterialIcons.message,
              // ),
              icon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/messages-icon.svg'
              ),
              activeIcon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/messages-active-icon.svg'
              ),
              label: LocalPeopleLocalizations.of(context).menuTitleMessages,
            ),
            BottomNavigationBarItem(
              // icon: Icon(
              //   MaterialIcons.menu,
              // ),
              icon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/more-icon.svg'
              ),
              activeIcon: SvgPicture.asset(
                  'packages/local_people_core/assets/images/more-active-icon.svg'
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