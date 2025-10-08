import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:styleapp/api/AdMob.dart';
import 'package:styleapp/api/firebase.dart';
import 'package:styleapp/bloc/app/app_bloc.dart';
import 'package:styleapp/config/router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'config/config.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirbaseApi().initNotifications();
  
  MobileAds.instance.initialize();
  runApp(const AfriStyleMen());
}

class AfriStyleMen extends StatefulWidget {
  const AfriStyleMen({Key? key}) : super(key: key);

  @override
  _AfriStyleMenState createState() => _AfriStyleMenState();
}

class _AfriStyleMenState extends State<AfriStyleMen> {
  late Dio dioInstance;
  static final apiBaseUrl = AppConfig.apiBaseUrl;
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    initializeDio();
     AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }
  

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      create: (context) => ApplicationBloc(dioInstance: dioInstance),
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Afristyle',
            // theme: AppTheme.light(),
            // darkTheme: AppTheme.dark(),
            routerConfig: AppRouter(BlocProvider.of<ApplicationBloc>(context)).router,
          );
        },
      ),
    );
  }

  initializeDio() {
    BaseOptions dioOptions = BaseOptions(
        baseUrl: apiBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60 * 1000), // 60 seconds
        receiveTimeout: const Duration(seconds: 60 * 1000) // 60 seconds
        );
    setState(() => dioInstance = Dio(dioOptions));
  }
}
