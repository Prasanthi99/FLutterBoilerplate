import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class AppConfiguration {
  static const baseUrl = "";
  // google client id "1079774339167-pdcmv8q353ek29rffepe0dj3aup5nekb.apps.googleusercontent.com"
  static GoogleSignIn googleSignIn = new GoogleSignIn(scopes: ['email']);
  static FacebookLogin facebookSignIn = new FacebookLogin();
  static TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '<your consumer key>',
    consumerSecret: '<your consumer secret>',
  );
  static const EventChannel EVENT_CHANNEL =
      EventChannel('com.technovert.boilerplate/eventChannel');
  static const MethodChannel METHOD_CHANNEL =
      MethodChannel("com.technovert.boilerplate/methodChannel");
}
