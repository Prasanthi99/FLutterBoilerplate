import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/models/core/user_context.dart';
part 'package:boilerplate/models/serializers/app_context.jser.dart';

class AppContext<T> extends BaseModel {
  AppStatusType _status = AppStatusType.Uninitialized;

  AppStatusType get status => this._status;
  set status(AppStatusType val) {
    this._status = val;
    notifyListeners();
  }

  UserContext userContext = null;
  AppContext();

  void setUserContext(UserContext userContext) {
    this.userContext = userContext;
  }
}

enum AppStatusType { Uninitialized, Initialized, Authenticated }

@GenSerializer()
class AppContextSerializer extends Serializer<AppContext>
    with _$AppContextSerializer {}
