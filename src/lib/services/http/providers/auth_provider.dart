import 'package:boilerplate/services/http/contracts/auth_contract.dart';
import 'package:boilerplate/services/http/contracts/base_contract.dart';

class AuthProvider implements AuthContract {
  BaseContract _httpClient;
  AuthProvider(this._httpClient);
}
