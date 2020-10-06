import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:boilerplate/models/core/base_model.dart';
part 'package:boilerplate/models/serializers/user_context.jser.dart';

class UserContext extends BaseModel {
  String id;
  String displayName;
  String profileImage;
  AccountType accountType;
}

enum AccountType { facebook, google, twitter, guest }

@GenSerializer()
class UserContextSerializer extends Serializer<UserContext>
    with _$UserContextSerializer {}
