import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: queryParameters,
    );

    try {
      final response = await _client.get(uri).timeout(
            const Duration(seconds: 20),
          );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        throw const ServerException('Unexpected response format');
      }

      throw ServerException(
        'Request failed with status ${response.statusCode}',
      );
    } on SocketException {
      throw const NetworkException();
    } on http.ClientException {
      throw const NetworkException();
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (_) {
      throw const ServerException();
    }
  }

  void dispose() => _client.close();
}
