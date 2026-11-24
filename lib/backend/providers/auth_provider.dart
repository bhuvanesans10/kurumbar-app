import 'package:flutter/material.dart';

/// Manages member authentication and profile state.
class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated =
      true; // Default to true so user sees the rich dashboard immediately

  Map<String, dynamic> _member = {
    'id': 'KB-2026-8942',
    'nameEn': 'S. Bhuvanesan',
    'nameTa': 'சு. புவனேசன்',
    'phone': '+91 94432 12345',
    'kulam': 'செல்ல குலம் (Chella Kulam)',
    'district': 'ஈரோடு (Erode)',
    'constituency': 'அந்தியூர் (Anthiyur)',
    'bloodGroup': 'O+',
    'dob': '12/10/1996',
    'avatarUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
    'isVerified': true,
    'issuedDate': '24/11/2026',
    'validUntil': 'வாழ்நாள் உறுப்பினர் (Lifetime)',
    'address': '24, பாரதி தெரு, அந்தியூர் வட்டம், ஈரோடு மாவட்டம் - 638501',
  };

  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic> get member => _member;

  void login({required String phone, String? name}) {
    _isAuthenticated = true;
    _member['phone'] = phone;
    if (name != null && name.isNotEmpty) {
      _member['nameEn'] = name;
    }
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void registerMember(Map<String, dynamic> data) {
    _member = {..._member, ...data, 'isVerified': true};
    _isAuthenticated = true;
    notifyListeners();
  }
}
