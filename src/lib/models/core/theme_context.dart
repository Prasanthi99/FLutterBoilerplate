import 'package:flutter/material.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:boilerplate/models/core/base_model.dart';
part 'package:boilerplate/models/serializers/theme_context.jser.dart';

class ThemeContext extends BaseModel {
  ThemeContext.parameterizedConstructor(
      this._themeState, this.primaryAccentColor, this.secondaryAccentColor);

  ThemeContext();

  ThemeState _themeState;
  ThemeData _darkTheme;
  ThemeData _lightTheme;

  ThemeState get themeState => _themeState;

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  set themeState(ThemeState themeState) {
    _themeState = themeState;
    notifyListeners();
  }

  Color primaryAccentColor;
  Color secondaryAccentColor;

  void setThemeData() {
    this._darkTheme = ThemeData(
        primaryColor: getOppositeThemeColor(ThemeState.dark),
        accentColor: Color(0xFF2C557C),
        highlightColor: Colors.white,
        primaryColorDark: this.primaryAccentColor,
        popupMenuTheme: PopupMenuThemeData(color: Colors.white),
        buttonColor: this.secondaryAccentColor,
        appBarTheme: AppBarTheme(
            color: this.primaryAccentColor,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'POPPINS',
                  fontWeight: FontWeight.w800),
              subtitle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'POPPINS',
                  fontWeight: FontWeight.w600),
            )),
        bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF15162A)),
        primaryColorLight: Color(0xFF1C1D27).withOpacity(0.9),
        backgroundColor: Color(0xFF1C1D27),
        canvasColor: Color(0xFF1C1D27),
        textSelectionColor: Colors.grey.shade700,
        unselectedWidgetColor: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(
              color: getOppositeThemeColor(ThemeState.dark),
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              fontFamily: 'POPPINS'),
          caption: TextStyle(
              color: getOppositeThemeColor(ThemeState.dark), fontSize: 14.0),
          subtitle: TextStyle(
              fontFamily: "POPPINS",
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: getOppositeThemeColor(ThemeState.dark).withOpacity(0.7)),
        ),
        dialogBackgroundColor: Color(0xFF1C1D27),
        dividerColor: Colors.grey,
        disabledColor: Colors.grey.shade400);
    this._lightTheme = ThemeData(
        primaryColor: getOppositeThemeColor(ThemeState.light),
        scaffoldBackgroundColor: Color(0xFFE7E7E7),
        accentColor: Color(0xFF2C557C),
        highlightColor: Colors.black,
        primaryColorDark: this.primaryAccentColor,
        buttonColor: this.secondaryAccentColor,
        appBarTheme: AppBarTheme(
            color: this.primaryAccentColor,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'POPPINS',
                  fontWeight: FontWeight.w800),
              subtitle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'POPPINS',
                  fontWeight: FontWeight.w600),
            )),
        bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFFF9F9F9)),
        primaryColorLight: Color(0xffeeeeee).withOpacity(0.0),
        backgroundColor: Colors.white,
        canvasColor: Color(0xFFF9F9F9),
        textSelectionColor: Colors.grey.shade300,
        unselectedWidgetColor: Colors.black,
        textTheme: TextTheme(
          title: TextStyle(
              color: getOppositeThemeColor(ThemeState.light),
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              fontFamily: 'POPPINS'),
          caption: TextStyle(
              color: getOppositeThemeColor(ThemeState.light), fontSize: 14.0),
          subtitle: TextStyle(
            color: getOppositeSecondaryColor(ThemeState.light),
            fontFamily: "POPPINS",
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        dialogBackgroundColor: Color(0xFFF9F9F9),
        dividerColor: Colors.grey[300],
        disabledColor: Colors.grey.shade400);
  }

  Color getThemeColor(ThemeState state) {
    return state == ThemeState.dark ? Colors.black : Colors.white;
  }

  Color getOppositeThemeColor(ThemeState state) {
    return state == ThemeState.light ? Color(0xFF363636) : Colors.white;
  }

  Color getOppositeSecondaryColor(ThemeState state) {
    return state == ThemeState.light ? Color(0xFF848484) : Colors.white;
  }
}

enum ThemeState { light, dark, systemDefault }

@GenSerializer()
class ThemeContextSerializer extends Serializer<ThemeContext>
    with _$ThemeContextSerializer {}
