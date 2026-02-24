import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessToken, value: accessToken);
    await _storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() =>
      _storage.read(key: _accessToken);

  Future<String?> getRefreshToken() =>
      _storage.read(key: _refreshToken);

  Future<void> clear() async => _storage.deleteAll();
}