import 'package:boilerplate/services/http/providers/base_provider.dart';

abstract class BaseContract {
  get<T>(String url,
      {bool isResponseList = false, Map<String, dynamic> queryParameters});
  Future<BaseResponse<T>> post<T>(String url,
      {data, Map<String, dynamic> queryParameters});
  Future<BaseResponse<T>> put<T>(String url,
      {data, Map<String, dynamic> queryParameters});
}
