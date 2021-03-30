import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:navigation/config/app_routes.dart';
import 'package:navigation/config/application.dart';
import 'observers/app_bloc_observer.dart';



Future<void> main() async {
  Bloc.observer = AppBlocObserver();

  runApp(LabaiikApp());

}

class LabaiikApp extends StatefulWidget {
  LabaiikApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _LabaiikAppState createState() => _LabaiikAppState();
}

class _LabaiikAppState extends State<LabaiikApp> with WidgetsBindingObserver {
  Stream<ConnectivityResult> _connectivityStream;
  Connectivity connectivity = Connectivity();
  bool isInternetConnected = false;
  ValueNotifier networkNotifier = ValueNotifier(false);
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String value = null;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initConnectivity();
    initializeNetworkState();
  }

  @override
  didPopRoute() {
    bool override;
    if (isInternetConnected)
      override = false;
    else
      override = true;
    return new Future<bool>.value(override);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// initializeNetworkState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green, primaryColor: Colors.green),
      onGenerateRoute: Application.router.generator,
      builder: (context, currentActiveWidget) {
        return Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                currentActiveWidget,
                ValueListenableBuilder(
                  valueListenable: networkNotifier,
                  builder: (context, value, state) {
                    if (!value) {
                      if (!isInternetConnected) {
                        isInternetConnected = true;
                      }
                    } else {
                      FocusScope.of(context)
                          .requestFocus(new FocusNode());
                      isInternetConnected = false;
                    }
                    return value ? Container() : Container();
                  },
                ),

              ],
            ));
      },
    );
  }

  initializeNetworkState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        networkNotifier.value = true;
      } else {
        networkNotifier.value = false;
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      networkNotifier.value = true;
    } else {
      networkNotifier.value = false;
    }
  }

  @override
  void dispose() {

    _connectivitySubscription.cancel();
    if (networkNotifier != null) networkNotifier.dispose();
    super.dispose();
  }
}
