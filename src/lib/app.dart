import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/models/core/theme_context.dart';
import 'package:boilerplate/services/device/connectivity_service.dart';
import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/ui/app_router.dart';
import 'package:boilerplate/ui/home_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<ConnectivityStatus>.value(
              value: ConnectivityService().connectionStatusController.stream),
          ChangeNotifierProvider(
              create: (_) => ServiceLocator.getInstance<AppContext>()),
          ChangeNotifierProvider(
              create: (_) => ServiceLocator.getInstance<ThemeContext>()),
        ],
        child: Consumer2<AppContext, ThemeContext>(
            builder: (context, appContext, themeContext, _) {
          themeContext.setThemeData();
          return MaterialApp(
            title: "Flutter Boilerplate",
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            theme: (themeContext.themeState == ThemeState.dark)
                ? themeContext.darkTheme
                : themeContext.lightTheme,
            darkTheme: (themeContext.themeState == ThemeState.light)
                ? themeContext.lightTheme
                : themeContext.darkTheme,
            onGenerateRoute: AppRouter.Factory,
          );
        }));
  }
}
