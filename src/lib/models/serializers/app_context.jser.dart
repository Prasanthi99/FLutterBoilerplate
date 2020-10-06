// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:boilerplate/models/core/app_context.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AppContextSerializer implements Serializer<AppContext> {
  Serializer<UserContext> __userSerializer;
  Serializer<UserContext> get _userSerializer =>
      __userSerializer ??= UserContextSerializer();
  @override
  Map<String, dynamic> toMap(AppContext model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'status', model.status.index);
    setMapValue(ret, 'userContext', _userSerializer.toMap(model.userContext));
    return ret;
  }

  @override
  AppContext fromMap(Map map) {
    if (map == null) return null;
    final obj = AppContext();
    obj.status = AppStatusType.values[map['status'] as int];
    obj.userContext = _userSerializer.fromMap(map['userContext'] as Map);
    return obj;
  }
}
