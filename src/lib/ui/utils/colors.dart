import 'package:flutter/material.dart';

class UIColors {
  // static const Color textColor = Color(0xFF23425E);
  static const Color primaryTextColor = Color(0xFF53563e);
  static const Color primaryLightBgColor = Color(0xFFAE977E);
  static const Gradient primaryGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[Color(0xFF143012), Color(0xFFC89E91)]);
  static const Gradient blueGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF465DE1), Color(0xFF754BA3)]);

  static List<Gradient> gradients = <Gradient>[
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFECFB3), Color(0xFFFBEEE2)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFEAB4FD), Color(0xFFEEE1D8)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFBEFEB3), Color(0xFFF5E8E7)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF3586A3), Color(0xFFF5E8E7)]),
    // LinearGradient(colors: <Color>[Color(0xFFFECFB3), Color(0xFFFBEEE2)]),
  ];
  static List<Gradient> eventBgGradients = <Gradient>[
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF6D5CE6), Color(0xFFF0326E)]),
    // LinearGradient(
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //     colors: <Color>[Color(0xFFEAB4FD), Color(0xFFEEE1D8)]),
    // LinearGradient(
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //     colors: <Color>[Color(0xFFBEFEB3), Color(0xFFF5E8E7)]),
    // LinearGradient(
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //     colors: <Color>[Color(0xFF3586A3), Color(0xFFF5E8E7)]),
    // LinearGradient(colors: <Color>[Color(0xFFFECFB3), Color(0xFFFBEEE2)]),
  ];

  static List<Color> offerTileRandomColors = <Color>[
    Color(0xFF7490E6),
    Color(0xFF49DBDA),
    Color(0xFFF9A3A3),
    Color(0xFFA58BFE)
  ];
}
