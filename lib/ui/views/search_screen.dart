import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: Text(
            AppLocalizations.of(context).appTitle,
          ),
          appBar: AppBar(),
        )
    );
  }
}