import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;

class DeeplinkService {
  static Future<void> launchApp(
      String appName, BuildContext context, String launchUrl,
      {String androidId, String iosId}) async {
    String packageId = Platform.isAndroid ? androidId : iosId;
    //need to test in IOS
    var canlaunch = await URLLauncher.canLaunch(launchUrl);
    if (canlaunch) {
      await URLLauncher.launch(
        launchUrl,
      ).catchError((_) {
        displayError(context, appName);
      });
    } else {
      await URLLauncher.launch(
              Platform.isAndroid
                  ? "https://play.google.com/store/apps/details?id=$packageId"
                  : "itms-apps://itunes.apple.com/us/app/apple-store/id$packageId",
              forceWebView: false,
              forceSafariVC: false)
          .catchError((_) {
        displayError(context, appName);
      });
    }
  }

  static void displayError(BuildContext context, String appName) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "Cannot launch ${appName}",
        style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontFamily: Theme.of(context).textTheme.subtitle.fontFamily),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ));
  } // Returns: true

  static Future<void> sendMail(BuildContext context, String mail,
      {String subject = "", String body = ""}) async {
    var url = "ms-outlook://emails/new?to=$mail&subject=$subject&body=$body";
    try {
      var canlaunch = await URLLauncher.canLaunch(url);
      if (canlaunch) {
        await URLLauncher.launch(url);
      } else {
        await URLLauncher.launch(
                Platform.isAndroid
                    ? "https://play.google.com/store/apps/details?id=com.microsoft.office.outlook"
                    : "itms-apps://itunes.apple.com/us/app/apple-store/id951937596",
                forceWebView: false,
                forceSafariVC: false)
            .catchError((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "Cannot launch mail",
              style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontFamily: Theme.of(context).textTheme.subtitle.fontFamily),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ));
        });
      }
    } catch (exception) {}
  }

  static Future<void> share(
      {@required String title,
      String text,
      List<String> files,
      String subj,
      List<String> mimeTypes}) async {
    try {
      final Map<String, dynamic> params = <String, dynamic>{
        'title': title,
        "files": files ?? new List<String>(),
        'text': text,
        'subject': subj
      };
      await AppConfiguration.METHOD_CHANNEL.invokeMethod<void>('share', params);
    } catch (ex) {}
  }
}
