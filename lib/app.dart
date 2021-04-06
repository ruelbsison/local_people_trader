import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:local_people_core/core.dart';
//import 'package:local_people_core/splash.dart';
//import 'package:local_people_core/injection_container.dart' as di;

//import './ui/views/splash_screen.dart';
import './ui/views/main_screen.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/login.dart';
import 'ui/router.dart';

class TraderApp extends StatelessWidget {
  //final _navigatorKey = GlobalKey<NavigatorState>();
  //NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      /*builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget),
        defaultScale: true,
        maxWidth: 1200,
        minWidth: 375,
        defaultName: MOBILE,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(375, name: MOBILE),
          ResponsiveBreakpoint.resize(600, name: MOBILE),
          ResponsiveBreakpoint.resize(850, name: TABLET),
          ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        // background: Container(color: background)
      ),*/
      title: AppLocalizations().clientAppTitle,
      theme: themeData(AppThemeConfig.lightTheme),
      darkTheme: themeData(AppThemeConfig.darkTheme),
      localizationsDelegates: [
        LocalPeopleLocalizationsDelegate(),
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''), // English
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: TraderAppRouter.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return LoginScreen();
          } else if (state is Unauthenticated) {
            return MainScreen();
          } else if (state is Authenticated) {
            return MainScreen();
          }
          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),
      /*BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return LoginScreen();
          } else if (state is Unauthenticated) {
            return MainScreen();
          } else if (state is Authenticated) {
            return MainScreen();
          }
          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),*/
      /*builder: (context, widget) => BlocProvider (
        create: (context) => SplashBloc(),
        child: BlocListener<SplashBloc, SplashState>(
                listener: (context, state) {
                  if (state is SplashStateCompleted) {
                    _navigator.pushAndRemoveUntil<void>(
                      LoginScreen.route(), (route) => false,
                    );
                  }
                },
            ),
      ),*/
      /*builder: (context, widget) => BlocConsumer<SplashBloc, SplashState>(
        listenWhen: (previous, current) {
          if (previous is SplashStateStarted && current is SplashStateCompleted) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is SplashStateCompleted) {
            Navigator.pop(context);
            AppRouter.pushPageReplacement(context, LoginScreen());
          }
        },
        buildWhen: (previous, current) {
          if (previous is SplashStateStarted && current is SplashStateCompleted) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          _navigator.pushAndRemoveUntil<void>(
            LoginScreen.route(),
                (route) => false,
          );
        },
      ),*/
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(
        theme.textTheme,
      ),
    );
  }

  static void initSystemDefault() async {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle
          .loadString('packages/local_people_core/assets/fonts/Inter/OFL.txt');
      yield LicenseEntryWithLineBreaks(
          ['packages/local_people_core/assets/fonts'], license);
    });
  }

  static void setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  static Widget runWidget() {

    //return TraderApp();
    //final UserRepository userRepository = UserRepositoryImpl();
    final AuthenticationRepository authenticationRepository =
    AuthenticationRepositoryImpl(
      authLocalDataSource: AuthLocalDataSourceImpl(
          authorizationConfig: AuthorizationConfig.devClientAuthorizationConfig()),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          /*BlocProvider(
            create: (context) => LoginBloc(userRepository: userRepository),
          ),*/
          BlocProvider(
            create: (context) =>
            AuthenticationBloc(authenticationRepository: authenticationRepository)
              ..add(AppStarted()),
          ),
        ],
        child: TraderApp(),
      ),
    );
  }
}