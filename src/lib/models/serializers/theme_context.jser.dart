// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:boilerplate/models/core/theme_context.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ThemeContextSerializer implements Serializer<ThemeContext> {
  @override
  Map<String, dynamic> toMap(ThemeContext model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'themeState', model.themeState.index);
    setMapValue(ret, 'primaryAccentColor', model.primaryAccentColor.value);
    setMapValue(ret, 'secondaryAccentColor', model.secondaryAccentColor.value);
    setMapValue(ret, 'state', model.state.index);
    setMapValue(ret, 'hasListeners', model.hasListeners);
    return ret;
  }

  @override
  ThemeContext fromMap(Map map) {
    if (map == null) return null;
    final obj = ThemeContext();
    obj.themeState = ThemeState.values[map['themeState'] as int];
    obj.primaryAccentColor = Color(map['primaryAccentColor']);
    obj.secondaryAccentColor = Color(map['secondaryAccentColor']);
    return obj;
  }
}
