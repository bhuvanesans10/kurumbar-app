import 'package:flutter_test/flutter_test.dart';
import 'package:kurumbar/backend/providers/auth_provider.dart';

void main() {
  group('AuthProvider unit tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('initial state is authenticated with default member profile', () {
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.member['id'], equals('KB-2026-8942'));
      expect(authProvider.member['phone'], equals('+91 94432 12345'));
      expect(authProvider.member['isVerified'], isTrue);
    });

    test('logout clears authentication state', () {
      authProvider.logout();
      expect(authProvider.isAuthenticated, isFalse);
    });

    test('login updates authentication state and phone number', () {
      authProvider.logout();
      expect(authProvider.isAuthenticated, isFalse);

      authProvider.login(phone: '+91 98765 43210', name: 'Muthusamy');
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.member['phone'], equals('+91 98765 43210'));
      expect(authProvider.member['nameEn'], equals('Muthusamy'));
    });

    test('registerMember populates profile and marks as verified', () {
      final newMemberData = {
        'id': 'KB-2026-9999',
        'nameEn': 'R. Velusamy',
        'nameTa': 'ரா. வேலுசாமி',
        'phone': '+91 91234 56789',
        'kulam': 'வெள்ளி குலம் (Velli Kulam)',
        'district': 'திருப்பூர் (Tiruppur)',
      };

      authProvider.registerMember(newMemberData);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.member['id'], equals('KB-2026-9999'));
      expect(authProvider.member['nameEn'], equals('R. Velusamy'));
      expect(authProvider.member['isVerified'], isTrue);
    });
  });
}
