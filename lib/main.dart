import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, primaryColor: Colors.green),
      onGenerateRoute: Application.router.generator,
      builder: (context, currentActiveWidget) {
        return Directionality(
            textDirection: TextDirection.ltr, child: currentActiveWidget);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
