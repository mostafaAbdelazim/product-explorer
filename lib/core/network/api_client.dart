import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';

@lazySingleton
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }

      throw const ServerException('Unexpected response format');
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on ServerException {
      rethrow;
    } catch (_) {
      throw const ServerException();
    }
  }

  Exception _mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        return ServerException(
          statusCode == null
              ? 'Request failed'
              : 'Request failed with status $statusCode',
        );
      case DioExceptionType.cancel:
        return const ServerException('Request cancelled');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        if (exception.error is FormatException) {
          return const ServerException('Unexpected response format');
        }
        return const NetworkException();
    }
  }
}
