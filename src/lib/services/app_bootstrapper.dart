import 'package:boilerplate/services/service_locator.dart';
import 'package:boilerplate/ui/app_router.dart';

class AppBootStrapper {
  static Future<void> initialize() async {
    try {
      ServiceLocator.configure();
      AppRouter.configure();
    } catch (e) {
      print("Error : ${e.toString()}");
    }
  }
}
