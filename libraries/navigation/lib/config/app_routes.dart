import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'route_handlers.dart';

class Routes {
  static String root = "/";
  static String detailView = "/detailView";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(root, handler: bluetoohHandler);
    router.define(detailView, handler: deviceViewHandler);
  }
}
