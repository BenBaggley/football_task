import 'package:dio/dio.dart';

DioError dioError() {
  return DioError(
    type: DioErrorType.response,
    response: Response<Map<String, dynamic>>(
      data: <String, dynamic>{
        'message': 'message',
      },
      requestOptions: RequestOptions(path: 'path'),
    ),
    requestOptions: RequestOptions(path: 'path'),
  );
}
