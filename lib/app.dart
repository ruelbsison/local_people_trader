import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
//import 'package:provider/provider.dart';

import 'package:local_people_core/core.dart';
import 'package:local_people_core/login.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/messages.dart';
import 'package:local_people_core/quote.dart';
import './ui/views/main_screen.dart';
import 'ui/router.dart';
import'dart:io' show Platform;
//import 'package:sizer/sizer.dart';

class TraderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      // return LayoutBuilder(                           //return LayoutBuilder
      //     builder: (context, constraints)
      // {
      //   return OrientationBuilder( //return OrientationBuilder
      //       builder: (context, orientation) {
      //         // SizerUtil.deviceType = DeviceType.mobile;
      //         // SizerUtil.orientation = orientation;
      //         // SizerUtil.boxConstraints = constraints;
      //         // return Sizer(
      //         //     builder: (context, orientation, deviceType)
      //         //     {
              return DialogManager(
                child: MaterialApp(
                  title: AppLocalizations().traderAppTitle,
                  theme: AppThemeConfig().kLocalPeopleTraderTheme,
                  //themeData(Theme.of(context), AppThemeConfig.clientTheme),
                  darkTheme: AppThemeConfig().kLocalPeopleClientTheme,
                  //themeData(Theme.of(context), AppThemeConfig.lightTheme),
                  themeMode: ThemeMode.light,
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
                          context.read<AuthenticationBloc>().add(
                              AuthenticateUser());
                          return LoginScreen();
                        } else if (state is ReAuthenticate) {
                          context.read<AuthenticationBloc>().add(
                              ReAuthenticateUser());
                          return LoginScreen();
                        } else if (state is Authenticated) {
                          return MainScreen();
                        } else if (state is AuthenticationError) {
                          return ErrorWidget(state.toString());
                        } else if (state is AuthenticationError) {
                          context.read<AuthenticationBloc>().add(
                              AuthenticateUser());
                          return LoginScreen();
                        }
                        return Container(
                          child: Center(child: Text('Unhandle State $state')),
                        );
                      },
                    ),
                    defaultScale: false,
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
                ),
              );
            //});
      //});
    //});
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

    DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
    NetworkInfoImpl networkInfo = NetworkInfoImpl(dataConnectionChecker: dataConnectionChecker);
    //return TraderApp();
    //final UserRepository userRepository = UserRepositoryImpl();
    // AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(
    //   authorizationConfig: AuthorizationConfig.prodTraderAuthorizationConfig(),
    // );
    AuthorizationConfig authorizationConfig;
    if (Platform.isIOS == true) {
      authorizationConfig = AuthorizationConfig.prodIOSTraderAuthorizationConfig();
    }
    if (Platform.isAndroid == true) {
      authorizationConfig = AuthorizationConfig.prodTraderAuthorizationConfig();
    }
    locatorInit(authorizationConfig);
    AuthLocalDataSource authLocalDataSource = sl<AuthLocalDataSource>();
    RestClientInterceptor restClientInterceptor = RestClientInterceptor(
      authLocalDataSource: authLocalDataSource,
      baseURL: RestAPIConfig().baseURL,
    );
    AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceImpl(
      authorizationConfig: authorizationConfig,
    );
    // AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceByPass(
    //   authorizationConfig: AuthorizationConfig.prodClientAuthorizationConfig(),
    // );
    ClientRestApiClient clientRestApiClient = ClientRestApiClient(
      //RestAPIConfig.getDioOptions(),
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    TraderRestApiClient traderRestApiClient = TraderRestApiClient(
      //RestAPIConfig.getDioOptions(),
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    ClientRemoteDataSource clientRemoteDataSource = ClientRemoteDataSourceImpl(
      clientRestApiClient: clientRestApiClient,
    );
    TraderRemoteDataSource traderRemoteDataSource = TraderRemoteDataSourceImpl(
      traderRestApiClient: traderRestApiClient,
    );

    JobRestApiClient jobRestApiClient = JobRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    JobRemoteDataSource jobRemoteDataSource = JobRemoteDataSourceImpl(
      jobRestApiClient: jobRestApiClient,
    );

    TagRestApiClient tagRestApiClient = TagRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    TagRemoteDataSource tagRemoteDataSource = TagRemoteDataSourceImpl(
        tagRestApiClient: tagRestApiClient
    );

    LocationRestApiClient locationRestApiClient = LocationRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    LocationRemoteDataSource locationRemoteDataSource = LocationRemoteDataSourceImpl(
      locationRestApiClient: locationRestApiClient,
    );

    MessageRestApiClient messageRestApiClient = MessageRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    MessageRemoteDataSource messageRemoteDataSource = MessageRemoteDataSourceImpl(
      messageRestApiClient: messageRestApiClient,
    );

    QualificationRestApiClient qualificationRestApiClient = QualificationRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    QualificationRemoteDataSource qualificationRemoteDataSource = QualificationRemoteDataSourceImpl(
      qualificationRestApiClient: qualificationRestApiClient,
    );

    PackageRestApiClient packageRestApiClient = PackageRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    PackageRemoteDataSource packageRemoteDataSource = PackageRemoteDataSourceImpl(
      packageRestApiClient: packageRestApiClient,
    );

    BookingRestApiClient bookingRestApiClient = BookingRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    BookingRemoteDataSource bookingRemoteDataSource = BookingRemoteDataSourceImpl(
      bookingRestApiClient: bookingRestApiClient,
    );

    QuoteRestApiClient quoteRestApiClient = QuoteRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    QuoteRemoteDataSource quoteRemoteDataSource = QuoteRemoteDataSourceImpl(
      quoteRestApiClient: quoteRestApiClient,
    );

    QuoteRequestRestApiClient quoteRequestRestApiClient = QuoteRequestRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    QuoteRequestRemoteDataSource quoteRequestRemoteDataSource = QuoteRequestRemoteDataSourceImpl(
      quoteRequestRestApiClient: quoteRequestRestApiClient,
    );

    ChangeRequestRestApiClient changeRequestRestApiClient = ChangeRequestRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    ChangeRequestRemoteDataSource changeRequestRemoteDataSource = ChangeRequestRemoteDataSourceImpl(
        changeRequestRestApiClient: changeRequestRestApiClient
    );

    final AuthenticationRepository authenticationRepository =
    AuthenticationRepositoryImpl(
      networkInfo: networkInfo,
      authenticationDataSource: authenticationDataSource,
    );

    final ProfileRepository profileRepository = ProfileRepositoryImpl(
        networkInfo: networkInfo,
        clientRemoteDataSource: clientRemoteDataSource,
        traderRemoteDataSource: traderRemoteDataSource
    );

    final JobRepository jobRepository = JobRepositoryImpl(
        networkInfo: networkInfo,
        jobRemoteDataSource: jobRemoteDataSource
    );

    final TagRepository tagRepository = TagRepositoryImpl(
      networkInfo: networkInfo,
      tagRemoteDataSource: tagRemoteDataSource,
    );

    final LocationRepository locationRepository = LocationRepositoryImpl(
      networkInfo: networkInfo,
      locationRemoteDataSource: locationRemoteDataSource,
    );

    final MessageRepository messageRepository = MessageRepositoryImpl(
      networkInfo: networkInfo,
      messageRemoteDataSource: messageRemoteDataSource,
    );

    final QualificationRepository qualificationRepository = QualificationRepositoryImpl(
      networkInfo: networkInfo,
      qualificationRemoteDataSource: qualificationRemoteDataSource,
    );

    final PackageRepository packageRepository = PackageRepositoryImpl(
      networkInfo: networkInfo,
      packageRemoteDataSource: packageRemoteDataSource,
    );

    final BookingRepository bookingRepository = BookingRepositoryImpl(
      networkInfo: networkInfo,
      bookingRemoteDataSource: bookingRemoteDataSource,
    );

    final QuoteRepository quoteRepository = QuoteRepositoryImpl(
      networkInfo: networkInfo,
      quoteRemoteDataSource: quoteRemoteDataSource,
    );

    final QuoteRequestRepository quoteRequestRepository = QuoteRequestRepositoryImpl(
      networkInfo: networkInfo,
      quoteRemoteDataSource: quoteRequestRemoteDataSource,
    );

    final ChangeRequestRepository changeRequestRepository = ChangeRequestRepositoryImpl(
        networkInfo: networkInfo,
        changeRequestRemoteDataSource: changeRequestRemoteDataSource
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
        RepositoryProvider<TagRepository>(
          create: (context) => tagRepository,
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => locationRepository,
        ),
        RepositoryProvider<MessageRepository>(
          create: (context) => messageRepository,
        ),
        RepositoryProvider<QualificationRepository>(
          create: (context) => qualificationRepository,
        ),
        RepositoryProvider<PackageRepository>(
          create: (context) => packageRepository,
        ),
        RepositoryProvider<BookingRepository>(
          create: (context) => bookingRepository,
        ),
        RepositoryProvider<QuoteRepository>(
          create: (context) => quoteRepository,
        ),
        RepositoryProvider<QuoteRequestRepository>(
          create: (context) => quoteRequestRepository,
        ),
        RepositoryProvider<ChangeRequestRepository>(
          create: (context) => changeRequestRepository,
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
              qualificationRepository: qualificationRepository,
              packageRepository: packageRepository,
            ),
          ),
          BlocProvider(
            create: (context) => TagBloc(
              tagRepository: tagRepository,
            ),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              locationRepository: locationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => JobBloc(
              jobRepository: jobRepository,
              tagRepository: tagRepository,
              locationRepository: locationRepository,
              quoteRepository: quoteRepository,
              quoteRequestRepository: quoteRequestRepository,
              //packageRepository: packageRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
              bookingRepository: bookingRepository,
              changeRequestRepository: changeRequestRepository,
            ),
          ),
          BlocProvider(
            create: (context) => JobFormBloc(
                jobRepository: jobRepository,
                tagRepository: tagRepository,
                locationRepository: locationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => MessageBoxBloc(
              messageRepository: messageRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageRepository: messageRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => QualificationBloc(
              qualificationRepository: qualificationRepository,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => PackageBloc(
              packageRepository: packageRepository,
            ),
          ),
          BlocProvider(
            create: (context) => BookingBloc(
              bookingRepository: bookingRepository,
            ),
          ),
          BlocProvider(
            create: (context) => QuoteBloc(
              quoteRepository: quoteRepository,
              //profileRepository: profileRepository,
              //jobRepository: jobRepository,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => QuoteRequestBloc(
              quoteRequestRepository: quoteRequestRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ChangeRequestBloc(
              changeRequestRepository: changeRequestRepository,
            ),
          ),
        ],
        child: TraderApp(),
        // child: MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_) => TraderProfile()),
        //   ],
        //   child: TraderApp(),
        // ),
      ),
    );
  }
}


