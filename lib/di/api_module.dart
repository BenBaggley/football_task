// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @singleton
  @Named('base_url')
  String get baseUrl => 'https://api.football-data.org/';

  @singleton
  @Named('api_key')
  String get apiKey => '47d36b758f8841659a717f96d5a56598';

  BaseOptions getBaseOptions(
    @Named('base_url') String baseUrl,
  ) {
    return BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
  }

  @singleton
  Dio getDio(
    BaseOptions baseOptions,
    @Named('api_key') String apiKey,
  ) {
    return Dio(baseOptions)
      ..interceptors.addAll([
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['X-Auth-Token'] = apiKey;
            return handler.next(options);
          },
        ),
        if (kDebugMode)
          LogInterceptor(
            requestHeader: true,
            responseHeader: true,
            requestBody: true,
            responseBody: true,
            logPrint: (o) => debugPrint(o.toString()),
          ),
      ]);
  }
}
