import 'package:flutter/material.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/user_context.dart';
import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/services/storage/secure_storage.dart';

class AppDrawerBuilder {
  AppDrawerBuilder();
  static int noOfTaps = 0;
  static Drawer build(AppContext appContext, BuildContext context) {
    return Drawer(child: Builder(
      builder: (BuildContext buildContext) {
        return ListView(children: [
          new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFF143012), Color(0xFFC89E91)])),
              accountName: new Text(
                "Hi! ${appContext.userContext.displayName ?? ''}",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
              accountEmail: new Text(""),
              currentAccountPicture: InkWell(
                onTap: () async {
                  noOfTaps += 1;
                  if (noOfTaps >= 5) {
                    Navigator.of(context).pop();
                    var result = await Navigator.of(context).pushNamed('logs');
                    noOfTaps = 0;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(
                      appContext.userContext.profileImage != null &&
                              appContext.userContext.profileImage.isNotEmpty
                          ? 2.0
                          : 0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(40.0)),
                  child: ClipOval(
                      child: appContext.userContext.profileImage != null &&
                              appContext.userContext.profileImage.isNotEmpty
                          ? Image.network(
                              appContext.userContext.profileImage,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.account_circle,
                              size: 70.0,
                              color: Colors.white,
                            )),
                ),
              )),
          InkWell(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0),
                    )
                  ],
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                if (appContext.userContext != null) {
                  switch (appContext.userContext.accountType) {
                    case AccountType.google:
                      AppConfiguration.googleSignIn
                          .signOut(); // diconnects the user from app and revokes all permissions, signout just marks the user as being in signed out stage.
                      break;
                    case AccountType.facebook:
                      AppConfiguration.facebookSignIn.logOut();
                      break;
                    case AccountType.guest:
                      break;
                  }
                }
                AppSecureStorage storage =
                    ServiceLocator.getInstance<AppSecureStorage>();
                storage.deleteAsync(key: AppConstants.APP_CONTEXT_KEY);
                appContext.setUserContext(null);
                appContext.status = AppStatusType.Initialized;
                storage.writeAsync(
                    key: AppConstants.APP_CONTEXT_KEY, value: appContext);
              })
        ]);
      },
    ));
  }
}
