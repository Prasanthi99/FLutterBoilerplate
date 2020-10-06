import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/theme_context.dart';
import 'package:boilerplate/models/core/user_context.dart';

class AppSerializer {
  static JsonRepo configure() {
    final jsonRepository = new JsonRepo()
      ..add(UserContextSerializer())
      ..add(ThemeContextSerializer())
      ..add(AppContextSerializer());
    return jsonRepository;
  }
}
