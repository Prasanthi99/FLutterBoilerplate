import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/ui/base_screen.dart';

class SplashScreen extends BaseScreen {
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;
  final int seconds;
  final String navigateAfterSeconds;
  final Future navigateAfterFuture;
  final Text caption;

  SplashScreen(
      {this.loaderColor,
      this.seconds,
      this.photoSize,
      this.onClick,
      this.navigateAfterSeconds,
      this.navigateAfterFuture = null,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText = const Text(""),
      this.imageBackground,
      this.gradientBackground,
      this.caption});

  @override
  Widget build(BuildContext context) {
    final appContext = Provider.of<AppContext>(context);
    Future.delayed(Duration(seconds: 0), () {
      if (appContext.status == AppStatusType.Uninitialized) {
        appContext.status = AppStatusType.Initialized;
      }
    });
    return Scaffold(
      body: new InkWell(
        onTap: this.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: this.imageBackground == null
                    ? null
                    : new DecorationImage(
                        fit: BoxFit.cover,
                        image: this.imageBackground,
                      ),
                gradient: this.gradientBackground,
                color: this.backgroundColor,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: new Container(child: this.image),
                        radius: this.photoSize,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      this.title,
                    ],
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      this.loadingText
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
