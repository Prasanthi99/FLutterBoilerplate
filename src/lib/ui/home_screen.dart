import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/ui/base_screen.dart';
import 'package:boilerplate/ui/login.dart';
import 'package:boilerplate/ui/screens/dashboard.dart';
import 'package:boilerplate/ui/splash_screen.dart';

class HomeScreen extends BaseScreen {
  HomeScreen();

  @override
  Widget build(BuildContext context) {
    final appContext = Provider.of<AppContext>(context);
    var splashScreen = new SplashScreen(
        seconds: 0,
        navigateAfterSeconds: "login",
        title: new Text(
          'Flutter Boilerplate',
          style: new TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red);
    switch (appContext.status) {
      case AppStatusType.Uninitialized:
        return splashScreen;
      case AppStatusType.Initialized:
        return LoginScreen();
      case AppStatusType.Authenticated:
        return Dashboard();
    }
    return LoginScreen();
  }
}
