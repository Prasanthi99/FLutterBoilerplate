// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:boilerplate/models/core/user_context.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UserContextSerializer implements Serializer<UserContext> {
  @override
  Map<String, dynamic> toMap(UserContext model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'displayName', model.displayName);
    setMapValue(ret, 'profileImage', model.profileImage);
    setMapValue(ret, 'accountType', model.accountType.index);
    return ret;
  }

  @override
  UserContext fromMap(Map map) {
    if (map == null) return null;
    final obj = UserContext();
    obj.id = map['id'] as String;
    obj.displayName = map['displayName'] as String;
    obj.profileImage = map['profileImage'] as String;
    obj.accountType = AccountType.values[map['accountType'] as int];
    return obj;
  }
}
