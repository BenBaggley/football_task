import 'package:dio/dio.dart';

DioException dioError() {
  return DioException(
    type: DioExceptionType.badResponse,
    response: Response<Map<String, dynamic>>(
      data: <String, dynamic>{
        'message': 'message',
      },
      requestOptions: RequestOptions(path: 'path'),
    ),
    requestOptions: RequestOptions(path: 'path'),
  );
}
