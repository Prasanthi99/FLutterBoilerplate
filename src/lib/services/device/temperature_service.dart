import 'package:boilerplate/models/app_configuration.dart';

class TemperatureService {
  static Stream<double> _temperatureStream;

  static Future<bool> initialize() async {
    return await AppConfiguration.METHOD_CHANNEL
        .invokeMethod("initializeSensor");
  }

  static Stream<double> get temperatureStream {
    _temperatureStream ??= AppConfiguration.EVENT_CHANNEL
        .receiveBroadcastStream()
        .map<double>((value) => value);
    return _temperatureStream;
  }
}
