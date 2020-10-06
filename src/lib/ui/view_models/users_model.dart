import 'package:boilerplate/models/api/user.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/services/storage/db_constants.dart';
import 'package:boilerplate/services/storage/hive.dart';
import 'package:boilerplate/services/storage/sqlflite.dart';

class UsersModel extends BaseModel {
  List<User> users;
  HiveDb _hiveDb;
  SQLiteDB _databaseService;
  UsersModel(this._hiveDb, this._databaseService);

  Future<void> getHiveUsers() async {
    setState(ViewState.Busy);
    this.users = await _hiveDb.getAll<User>(AppConstants.userBox);
    setState(ViewState.Idle);
  }

  Future<void> addHiveUser(User user) async {
    await _hiveDb.clearAll(AppConstants.userBox);
    await _hiveDb.addAll<User>(AppConstants.userBox, this.users);
  }

  Future<void> addSQLUsers(User user) async {
    await _databaseService.clearAll();
    await _databaseService.insert<User>(UserDB.tableName, user);
  }

  Future<void> getSQLUsers() async {
    setState(ViewState.Busy);
    this.users = await _databaseService.getAll<User>(
      UserDB.tableName,
      UserDB.columns,
    );
    setState(ViewState.Idle);
  }
}
