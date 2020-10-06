import 'package:fluro/fluro.dart' as router;
import 'package:flutter/material.dart';
import 'package:boilerplate/ui/login.dart';
import 'package:boilerplate/ui/screens/logs.dart';

class AppRouter {
  static router.Router _router;
  static RouteFactory get Factory => (routeSettings) {
        return _router.generator(routeSettings);
      };
  AppRouter();

  static configure() {
    _router = new router.Router();
    _router.define('login', handler: new router.Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginScreen();
    }));
    _router.define('logs', handler: new router.Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LogsScreen();
    }));
  }
}
