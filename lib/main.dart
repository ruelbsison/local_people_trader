import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TraderApp.initSystemDefault();
  TraderApp.setupLogging();
  runApp(
    AppConfig(
      appName: AppLocalizations().traderAppTitle,
      debugTag: true,
      flavorName: "dev",
      // initialRoute: AppRouter.SPLASH,
      child: TraderApp.runWidget(),
    ),
  );
}
