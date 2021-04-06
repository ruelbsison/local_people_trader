import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_people_core/core.dart';

class TraderHomeScreen extends StatelessWidget {
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