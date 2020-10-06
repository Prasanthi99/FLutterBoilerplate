import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:boilerplate/models/api/user.dart';

class HiveDb {
  static void configure() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      Hive.registerAdapter(UserAdapter());
    } catch (exception) {}
  }

  Future<List<T>> getAll<T>(String boxName) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      return (box != null && box.values != null)
          ? box.values.toList()
          : new List<T>();
    } catch (ex) {
      return null;
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> addAll<T>(String boxName, dynamic values) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      await box.addAll(values);
    } catch (ex) {} finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> clearAll<T>(String boxName) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      await box.clear();
    } catch (exception) {} finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> clearAllBoxes(List<String> boxNames) async {
    try {
      boxNames.forEach((boxName) async {
        await this.clearAll(boxName);
      });
      await Hive.close();
    } catch (exception) {}
  }
}
