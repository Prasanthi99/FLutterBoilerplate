import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:boilerplate/models/app_serializer.dart';
import 'package:boilerplate/services/http/contracts/base_contract.dart';

class BaseProvider extends BaseContract {
  Dio _dioClient;
  JsonRepo _jsonRepo;
  BaseProvider(String baseUrl) {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl, connectTimeout: 50000, receiveTimeout: 50000);
    this._dioClient = new Dio(options);
    this._jsonRepo = AppSerializer.configure();
  }

  get<T>(String url,
      {bool isResponseList = false,
      Map<String, dynamic> queryParameters}) async {
    try {
      Response rawResponse =
          await this._dioClient.get(url, queryParameters: queryParameters);
      var data = isResponseList
          ? this._jsonRepo.listFrom<T>(rawResponse.data)
          : this._jsonRepo.from<T>(rawResponse.data);
      return isResponseList
          ? new BaseResponse<List<T>>(rawResponse, data)
          : new BaseResponse<T>(rawResponse, data);
    } catch (exception) {
      print(exception);
      return new BaseResponse<T>();
    }
  }

  Future<BaseResponse<T>> post<T>(String url,
      {data, Map<String, dynamic> queryParameters}) async {
    try {
      var json = this._jsonRepo.encode(data);
      Response<T> rawResponse = await this
          ._dioClient
          .post(url, data: json, queryParameters: queryParameters);
      var result = this._jsonRepo.from<T>(rawResponse.data);
      return new BaseResponse<T>(rawResponse, result);
    } catch (exception) {
      print(exception);
      return new BaseResponse<T>();
    }
  }

  Future<BaseResponse<T>> put<T>(String url,
      {data, Map<String, dynamic> queryParameters}) async {
    try {
      var json = this._jsonRepo.encode(data);
      var rawResponse = await this
          ._dioClient
          .put(url, data: json, queryParameters: queryParameters);
      var result = this._jsonRepo.from<T>(rawResponse.data);
      return new BaseResponse<T>(rawResponse, result);
    } catch (exception) {
      print(exception);
      return new BaseResponse();
    }
  }
}

class BaseResponse<T> {
  BaseResponse([Response raw, T data]) {
    this.data = data;
    this.statusCode = raw?.statusCode;
    this.statusMessage = raw?.statusMessage;
  }

  /// Response body. may have been transformed, please refer to [ResponseType].
  T data;

  /// Http status code.
  int statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String statusMessage;

  @override
  String toString() {
    if (this is Map) {
      return json.encode(this);
    }
    return this.toString();
  }
}
