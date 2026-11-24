/// Standard API response envelope matching `.ai-skills/flutter-api-layer.md`.
class ApiResponse {
  const ApiResponse({
    required this.statusCode,
    required this.isSuccess,
    this.data,
    this.message,
  });

  final int statusCode;
  final bool isSuccess;
  final dynamic data;
  final String? message;
}
