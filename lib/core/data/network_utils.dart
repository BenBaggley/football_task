import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/core/extensions/dio_error_failure.dart';

Future<Either<Failure, T>> ioSafe<T>(ApiCall<T> call) async {
  try {
    return right(await call());
  } on DioError catch (e) {
    return left(e.asFailure);
  }
}

typedef ApiCall<T> = FutureOr<T> Function();
