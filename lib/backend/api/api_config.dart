import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure endpoint and token storage configuration matching Genie patterns.
abstract final class ApiConfig {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _endpointKey = 'api_endpoint';

  static Future<String> getEndpoint() async {
    final stored = await _storage.read(key: _endpointKey);
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }
    return dotenv.env['API_BASE_URL'] ?? 'http://localhost:3005/api';
  }
}
