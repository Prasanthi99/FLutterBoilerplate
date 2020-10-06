import 'dart:async';
import 'package:flutter/material.dart';
import 'package:boilerplate/app.dart';
import 'package:boilerplate/services/app_bootstrapper.dart';

void main() async {
  await AppBootStrapper.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  _runAppInZone();
}

_runAppInZone() {
  runZoned(() {
    runApp(App());
  }, onError: (error, stackTrace) {
    print(stackTrace);
  });
}
