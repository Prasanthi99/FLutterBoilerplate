import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/user_context.dart';
import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/services/storage/secure_storage.dart';
import 'package:boilerplate/ui/base_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/ui/utils/auth.dart';
import 'package:boilerplate/ui/view_models/login_model.dart';

class LoginScreen extends StatelessWidget {
  var textboxBorder = new UnderlineInputBorder(
    borderSide: new BorderSide(width: 1, color: Colors.white.withOpacity(0.6)),
  );
  var errorBorder = new UnderlineInputBorder(
    borderSide: new BorderSide(width: 1.0, color: Colors.red.withOpacity(0.6)),
  );
  var textStyle =
      TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0);
  var hintStyle =
      TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18.0);
  bool loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginModel>(
        builder: (context, model, child) => SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black54, BlendMode.darken),
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/login_background.jpg",
                            ))),
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF3D5A98),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0))),
                                // padding: EdgeInsets.fromLTRB(, 0, 20, 0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        "http://www.vectorico.com/download/social_media/Facebook-Icon.png",
                                        height: 40.0,
                                      ),
                                      Text(
                                        "Continue with Facebook",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 20.0),
                                      )
                                    ])),
                            onTap: () async {
                              await model.signInWithFacebook(
                                  Provider.of<AppContext>(context,
                                      listen: false));
                            },
                          ),
                          InkWell(
                            child: Container(
                                margin: EdgeInsets.only(top: 20.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFFf53e28),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0))),
                                // padding: EdgeInsets.fromLTRB(14, 0, 20, 0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        "https://seeklogo.com/images/G/google-icon-logo-F8DBA0521D-seeklogo.com.png",
                                        height: 40.0,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 20.0),
                                      ),
                                    ])),
                            onTap: () async {
                              await model.signInWithGoogle(
                                  Provider.of<AppContext>(context,
                                      listen: false));
                            },
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () async {
                              try {
                                var appContext = Provider.of<AppContext>(
                                    context,
                                    listen: false);
                                var userContext = new UserContext();
                                userContext.accountType = AccountType.guest;
                                appContext.status = AppStatusType.Authenticated;
                                appContext.setUserContext(userContext);
                                var storage = ServiceLocator.getInstance<
                                    AppSecureStorage>();
                                await storage.writeAsync(
                                    key: AppConstants.APP_CONTEXT_KEY,
                                    value: appContext);
                              } catch (ex) {
                                print(ex);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF7A6760).withOpacity(0.8),
                                      Color(0xFFAE977E).withOpacity(0.8)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0)),
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Text("Login as Guest",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ))),
                                  (loggingIn ?? false)
                                      ? SizedBox(
                                          height: 30.0,
                                          width: 30.0,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 3.0,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.white)),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          // InkWell(
                          //   child: Container(
                          //       margin: EdgeInsets.only(top: 20.0),
                          //       decoration: BoxDecoration(
                          //           color: Color(0xFFf53e28),
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(6.0))),
                          //       padding: EdgeInsets.fromLTRB(14, 0, 20, 0),
                          //       child: Row(
                          //           mainAxisSize: MainAxisSize.max,
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: <Widget>[
                          //             Image.asset(
                          //               "assets/images/twitter.png",
                          //               height: 40.0,
                          //             ),
                          //             SizedBox(width: 10),
                          //             Text(
                          //               "Sign in with Twitter",
                          //               style: TextStyle(
                          //                   color:
                          //                       Colors.white.withOpacity(0.8),
                          //                   fontSize: 20.0),
                          //             ),
                          //           ])),
                          //   onTap: () async {
                          //     await model.signInWithTwitter(
                          //         Provider.of<AppContext>(context,
                          //             listen: false));
                          //   },
                          // ),
                          // SizedBox(height: 20.0),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "By Continuing, You are agreeing to our ",
                                    style: TextStyle(color: Color(0xFF737373))),
                                TextSpan(
                                    text: "Terms of Use",
                                    style: TextStyle(
                                        color: Color(0xFF737373),
                                        decoration: TextDecoration.underline)),
                                TextSpan(
                                    text:
                                        " and acknowledging that you've read our ",
                                    style: TextStyle(color: Color(0xFF737373))),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: Color(0xFF737373),
                                        decoration: TextDecoration.underline))
                              ])),
                          SizedBox(height: 10.0),
                        ])))));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white.withOpacity(0.6);
    paint.style = PaintingStyle.fill;
    var path = Path();

    path.moveTo(0, size.height * 0.71667);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.650,
        size.width * 0.5, size.height * 0.7167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.7834,
        size.width * 1.0, size.height * 0.7167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
