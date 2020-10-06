import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/models/core/user_context.dart';
import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/services/storage/flogs_provider.dart';
import 'package:boilerplate/services/storage/secure_storage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;

class LoginModel extends BaseModel {
  LoggerService _loggerService;
  LoginModel(this._loggerService);
  Future<void> signInWithFacebook(AppContext appContext) async {
    final FacebookLoginResult result =
        await AppConfiguration.facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(300)&access_token=${accessToken.token}');
        var profile = json.jsonDecode(graphResponse.body);
        UserContext user = new UserContext();
        user.displayName = profile['name'];
        user.id = profile["email"];
        user.profileImage = profile['picture']['data']['url'];
        user.accountType = AccountType.facebook;
        AppSecureStorage storage =
            ServiceLocator.getInstance<AppSecureStorage>();
        appContext.setUserContext(user);
        appContext.status = AppStatusType.Authenticated;
        storage.writeAsync(
            key: AppConstants.APP_CONTEXT_KEY, value: appContext);
        this._loggerService.Info("Login", "facebook", profile.toString());
        print(profile.toString());
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<void> signInWithGoogle(AppContext appContext) async {
    try {
      AppConfiguration.googleSignIn.signIn().then((result) {
        result.authentication.then((googleKey) {
          print(googleKey.accessToken);
          print(googleKey.idToken);
          if (AppConfiguration.googleSignIn.currentUser != null) {
            var currentUser = AppConfiguration.googleSignIn.currentUser;
            UserContext user = new UserContext();
            user.displayName = currentUser.displayName;
            user.id = currentUser.email;
            user.profileImage = currentUser.photoUrl;
            user.accountType = AccountType.google;
            AppSecureStorage storage =
                ServiceLocator.getInstance<AppSecureStorage>();
            appContext.setUserContext(user);
            appContext.status = AppStatusType.Authenticated;
            storage.writeAsync(
                key: AppConstants.APP_CONTEXT_KEY, value: appContext);
            this
                ._loggerService
                .Info("Login", "facebook", currentUser.toString());
          }
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
    } catch (exception) {}
  }

  Future<void> signInWithTwitter(AppContext appContext) async {
    final TwitterLoginResult result =
        await AppConfiguration.twitterLogin.authorize();
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        if (result.session != null) {
          UserContext user = new UserContext();
          user.displayName = result.session.username;
          user.id = result.session.userId;
          // user.profileImage = currentUser.photoUrl;
          user.accountType = AccountType.twitter;
          AppSecureStorage storage =
              ServiceLocator.getInstance<AppSecureStorage>();
          appContext.setUserContext(user);
          appContext.status = AppStatusType.Authenticated;
          storage.writeAsync(
              key: AppConstants.APP_CONTEXT_KEY, value: appContext);
        }
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('Login cancelled by user.');
        break;
      case TwitterLoginStatus.error:
        print('Login error: ${result.errorMessage}');
        break;
    }
  }
}
