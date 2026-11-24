import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kurumbar/backend/api/api_config.dart';
import 'package:kurumbar/backend/api/api_response.dart';

/// Central authenticated HTTP request wrapper.
/// Token refresh and 401 retry interceptors will be wired here in Phase 1.
class ProtectedRoutesApiService {
  ProtectedRoutesApiService({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  Future<ApiResponse> makeRequest({
    required String path,
    String method = 'GET',
    Map<String, String>? headers,
    Object? body,
  }) async {
    final baseUrl = await ApiConfig.getEndpoint();
    final uri = Uri.parse('$baseUrl$path');
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };

    late final http.Response response;
    switch (method.toUpperCase()) {
      case 'POST':
        response = await _client.post(
          uri,
          headers: requestHeaders,
          body: body == null ? null : jsonEncode(body),
        );
      case 'PATCH':
        response = await _client.patch(
          uri,
          headers: requestHeaders,
          body: body == null ? null : jsonEncode(body),
        );
      case 'DELETE':
        response = await _client.delete(uri, headers: requestHeaders);
      default:
        response = await _client.get(uri, headers: requestHeaders);
    }

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;
    dynamic parsed;
    if (response.body.isNotEmpty) {
      try {
        parsed = jsonDecode(response.body);
      } catch (_) {
        parsed = response.body;
      }
    }

    return ApiResponse(
      statusCode: response.statusCode,
      isSuccess: isSuccess,
      data: parsed,
      message: parsed is Map<String, dynamic>
          ? parsed['message']?.toString()
          : null,
    );
  }
}
