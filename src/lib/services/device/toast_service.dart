import 'dart:io';

import 'package:flutter/material.dart';
import 'package:boilerplate/models/app_configuration.dart';

class ToastService {
  static Future<bool> showToast(
      {@required String msg,
      Toast toastLength,
      int timeInSecForIosWeb = 1,
      double fontSize,
      ToastGravity gravity,
      Color backgroundColor,
      Color textColor}) async {
    String toast = "short";
    if (toastLength == Toast.LENGTH_LONG) {
      toast = "long";
    }

    String gravityToast = "bottom";
    if (gravity == ToastGravity.TOP) {
      gravityToast = "top";
    } else if (gravity == ToastGravity.CENTER) {
      gravityToast = "center";
    } else {
      gravityToast = "bottom";
    }

    if (backgroundColor == null && Platform.isIOS) {
      backgroundColor = Colors.black;
    }
    if (textColor == null && Platform.isIOS) {
      textColor = Colors.white;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      'msg': msg,
      'length': toast,
      'time': timeInSecForIosWeb,
      'gravity': gravityToast,
      'bgcolor': backgroundColor != null ? backgroundColor.value : null,
      'textcolor': textColor != null ? textColor.value : null,
      'fontSize': fontSize,
    };

    bool res =
        await AppConfiguration.METHOD_CHANNEL.invokeMethod('showToast', params);
    return res;
  }
}

enum ToastGravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR
}

enum Toast { LENGTH_SHORT, LENGTH_LONG }
