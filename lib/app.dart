import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:local_people_core/core.dart';
import 'package:local_people_core/login.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/jobs.dart';
import './ui/views/main_screen.dart';
import 'ui/router.dart';

class TraderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations().clientAppTitle,
      theme: AppThemeConfig().kLocalPeopleClientTheme, //themeData(Theme.of(context), AppThemeConfig.clientTheme),
      darkTheme: AppThemeConfig().kLocalPeopleTraderTheme, //themeData(Theme.of(context), AppThemeConfig.lightTheme),
      themeMode: ThemeMode.dark,
      //fontFamily: 'RedHatDisplay',
      localizationsDelegates: [
        LocalPeopleLocalizationsDelegate(),
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''), // English
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: TraderAppRouter.generateRoute,
      /*home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
      home: ResponsiveWrapper.builder(
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return LoginScreen();
            } else if (state is Unauthenticated) {
              context.bloc<AuthenticationBloc>().add(AuthenticateUser());
              return LoginScreen();
            } else if (state is ReAuthenticate) {
              context.bloc<AuthenticationBloc>().add(ReAuthenticateUser());
              return LoginScreen();
            } else if (state is Authenticated) {
              return MainScreen();
            }
            return Container(
              child: Center(child: Text('Unhandle State $state')),
            );
          },
        ),
        defaultScale: true,
        //maxWidth: 896,
        //minWidth: 414,
        maxWidth: 812,
        minWidth: 375,
        //maxWidth: 2436,
        //minWidth: 1125,
        defaultName: MOBILE,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(375, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: MOBILE),
          ResponsiveBreakpoint.resize(850, name: TABLET),
          ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        //mediaQueryData: MediaQueryData(size: Size(375, 812), devicePixelRatio: 3),
      ),
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData baseTheme, ThemeData theme) {
    return baseTheme.copyWith(
      backgroundColor: theme.backgroundColor,
      primaryColor: theme.primaryColor,
      accentColor: theme.accentColor,
      cursorColor: theme.cursorColor,
      scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
      appBarTheme: theme.appBarTheme,
      textTheme: theme.textTheme,
      elevatedButtonTheme: theme.elevatedButtonTheme,
      textButtonTheme: theme.textButtonTheme,
      outlinedButtonTheme: theme.outlinedButtonTheme,
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

  static Widget runWidget(AppType appType) {

    //return TraderApp();
    //final UserRepository userRepository = UserRepositoryImpl();
    AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(
      authorizationConfig: AuthorizationConfig.prodTraderAuthorizationConfig(),
    );
    RestClientInterceptor restClientInterceptor = RestClientInterceptor(
      authLocalDataSource: authLocalDataSource,
    );
    AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceImpl(
     authorizationConfig: AuthorizationConfig.prodTraderAuthorizationConfig(),
    );
    // AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceByPass(
    //   authorizationConfig: AuthorizationConfig.devClientAuthorizationConfig(),
    // );
    ClientRemoteDataSource clientRemoteDataSource = ClientRemoteDataSourceImpl(
        dio: restClientInterceptor.dio,
        baseUrl: RestAPIConfig().baseURL);
    TraderRemoteDataSource traderRemoteDataSource = TraderRemoteDataSourceImpl(







         baseUrl: RestAPIConfig().baseURL);
    JobRemoteDataSource jobRemoteDataSource = JobRemoteDataSourceImpl(RestAPIConfig().baseURL);
    TagRemoteDataSource tagRemoteDataSource = TagRemoteDataSourceImpl(RestAPIConfig().baseURL);
    LocationRemoteDataSource locationRemoteDataSource = LocationRemoteDataSourceImpl(RestAPIConfig().baseURL);

    final AuthenticationRepository authenticationRepository =
    AuthenticationRepositoryImpl(
      authenticationDataSource: authenticationDataSource,
    );

    final ProfileRepository profileRepository = ProfileRepositoryImpl(
        clientRemoteDataSource: clientRemoteDataSource,
        traderRemoteDataSource: traderRemoteDataSource
    );

    JobRepository jobRepository = JobRepositoryImpl(
        authLocalDataSource: authLocalDataSource,
        jobRemoteDataSource: jobRemoteDataSource
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => profileRepository,
        ),
        RepositoryProvider<JobRepository>(
          create: (context) => jobRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          /*BlocProvider(
            create: (context) => LoginBloc(userRepository: userRepository),
          ),*/
          BlocProvider(
            create: (context) =>
            AuthenticationBloc(
                authLocalDataSource: authLocalDataSource,
                authenticationRepository: authenticationRepository)
              ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              profileRepository: profileRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => JobBloc(
                jobRepository: jobRepository,
                appType: appType
            ),
          ),
          BlocProvider(
            create: (context) => JobFormBloc(
                jobRepository: jobRepository
            ),
          ),
        ],
        child: TraderApp(),
      ),
    );
  }
}
