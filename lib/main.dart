import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  //TraderApp.initSystemDefault();
  TraderApp.setupLogging();
  runApp(
    AppConfig(
      appName: AppLocalizations().traderAppTitle,
      appType: AppType.TRADER,
      debugTag: true,
      flavorName: "dev",
      // initialRoute: AppRouter.SPLASH,
      child: TraderApp.runWidget(AppType.TRADER),
    ),
  );
}
