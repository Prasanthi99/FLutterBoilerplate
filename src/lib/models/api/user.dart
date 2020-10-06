import 'package:hive/hive.dart';
import 'package:boilerplate/models/app_constants.dart';
part '../adapters/user.g.dart';

@HiveType(typeId: AppConstants.UserHiveAdapterId)
class User {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
}
