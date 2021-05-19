import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        //appBarPreferredSize: Size.fromHeight(80.0),
        title: Text(
          AppLocalizations.of(context).appTitle,
        ),
        subTitle: LocalPeopleLocalizations.of(context).menuTitleSearch,
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
    return SafeArea(
      child: Container(),
    );
  }
}