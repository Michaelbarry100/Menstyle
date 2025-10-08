import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DataRepo {
  final Dio dioInstance;
  DataRepo(this.dioInstance);

  landing() async {
    try {
      Response response = await dioInstance.get(
        "/landing",
      );
      return response.data;
    } on DioException catch (err, stacktrace) {
      networkExceptionHandler(err, stacktrace);
    }
  }

  collections() async {
    try {
      Response response = await dioInstance.get(
        "/collections",
      );
      return response.data;
    } on DioException catch (err, stacktrace) {
      networkExceptionHandler(err, stacktrace);
    }
  }

  categories({int? collection}) async {
    try {
      Response response = await dioInstance.get(
        "/categories",
      );
      return response.data;
    } on DioException catch (err, stacktrace) {
      networkExceptionHandler(err, stacktrace);
    }
  }

  styles({required int page, int? category, bool? premium}) async {
    try {
      String endpoint =
          "/items/${category ?? ''}?page=$page&premium=${premium == true ? '1' : '0'}";
      Response response = await dioInstance.get(endpoint);
      return response.data;
    } on DioException catch (err, stacktrace) {
      networkExceptionHandler(err, stacktrace);
    }
  }
}

networkExceptionHandler(DioException err, stacktrace) {
  var message;
  if (err.type == DioExceptionType.unknown) {
    message = 'Service unavailable';
  } else {
    var res = err.response!.data;
    message = res['message'];
  }
  if (kDebugMode) {
    print("Data ${message}");
    print("Exception occured: $err stackTrace: $stacktrace");
  }
  throw Exception(message);
}
