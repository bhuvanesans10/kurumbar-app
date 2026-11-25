import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/backend/providers/auth_provider.dart';
import 'package:kurumbar/utils/design_system.dart';

class DigitalIdPage extends StatefulWidget {
  const DigitalIdPage({super.key});

  @override
  State<DigitalIdPage> createState() => _DigitalIdPageState();
}

class _DigitalIdPageState extends State<DigitalIdPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  @override
  Widget build(BuildContext context) {
    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';
    final member = context.watch<AuthProvider>().member;

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        title: Text(
          isTa ? 'டிஜிட்டல் அடையாள அட்டை' : 'Digital Member ID Card',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: KurumbarDesignSystem.primaryDark,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: KurumbarDesignSystem.primaryGreen,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isTa
                        ? 'அடையாள அட்டை இணைப்பு பகிரப்பட்டது'
                        : 'ID Card link shared successfully',
                  ),
                  backgroundColor: KurumbarDesignSystem.primaryGreen,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Instructions header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: KurumbarDesignSystem.primaryGreenLight,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: KurumbarDesignSystem.primaryGreen.withValues(
                    alpha: 0.2,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.touch_app,
                    size: 16,
                    color: KurumbarDesignSystem.primaryGreen,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isTa
                        ? 'அட்டையை தொட்டு முன்புறம் / பின்புறம் பார்க்கவும்'
                        : 'Tap card to flip Front / Back',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: KurumbarDesignSystem.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Animated 3D Flip ID Card
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, child) {
                  final angle = _flipAnimation.value * pi;
                  final isBackVisible = _flipAnimation.value >= 0.5;

                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // 3D Perspective
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: isBackVisible
                        ? Transform(
                            transform: Matrix4.identity()..rotateY(pi),
                            alignment: Alignment.center,
                            child: _buildCardBack(member, isTa),
                          )
                        : _buildCardFront(member, isTa),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.flip_camera_android, size: 18),
                    label: Text(
                      isTa
                          ? 'திருப்புக்க (${_isFront ? "பின்புறம்" : "முன்புறம்"})'
                          : 'Flip (${_isFront ? "Back" : "Front"})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _flipCard,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download, size: 18),
                    label: Text(
                      isTa ? 'அட்டை சேமிக்க' : 'Download ID',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KurumbarDesignSystem.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isTa
                                ? 'அடையாள அட்டை வெற்றிகரமாக பதிவிறக்கப்பட்டது'
                                : 'ID Card downloaded to gallery',
                          ),
                          backgroundColor: KurumbarDesignSystem.primaryGreen,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Verification Status Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: KurumbarDesignSystem.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isTa
                                  ? 'அதிகாரப்பூர்வ சரிபார்க்கப்பட்ட உறுப்பினர்'
                                  : 'Official Verified Community Member',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: KurumbarDesignSystem.textPrimary,
                              ),
                            ),
                            Text(
                              isTa
                                  ? 'தமிழ்நாடு குறும்பர் சமுதாய நல வாரியம்'
                                  : 'Tamil Nadu Kurumbar Welfare Board',
                              style: const TextStyle(
                                fontSize: 12,
                                color: KurumbarDesignSystem.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isTa ? 'அட்டை எண்:' : 'Card Number:',
                        style: const TextStyle(
                          fontSize: 13,
                          color: KurumbarDesignSystem.textSecondary,
                        ),
                      ),
                      Text(
                        member['id'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: KurumbarDesignSystem.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isTa ? 'செல்லுபடியாகும் காலம்:' : 'Validity:',
                        style: const TextStyle(
                          fontSize: 13,
                          color: KurumbarDesignSystem.textSecondary,
                        ),
                      ),
                      Text(
                        member['validUntil'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFront(Map<String, dynamic> m, bool isTa) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KurumbarDesignSystem.primaryGreen, width: 2),
        boxShadow: KurumbarDesignSystem.floatingShadow,
      ),
      child: Column(
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: KurumbarDesignSystem.primaryDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/logo.png', width: 34, height: 34),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'தமிழ்நாடு குறும்பர் சங்கம்',
                        style: TextStyle(
                          color: KurumbarDesignSystem.accentYellow,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'KURUMBAR COMMUNITY PLATFORM',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 8.5,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: KurumbarDesignSystem.accentYellow,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '2026',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      color: KurumbarDesignSystem.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo & QR
                Column(
                  children: [
                    Container(
                      width: 90,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: KurumbarDesignSystem.primaryGreen,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: m['avatarUrl'].toString().startsWith('assets/')
                              ? AssetImage(m['avatarUrl']) as ImageProvider
                              : NetworkImage(m['avatarUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.qr_code_2,
                        size: 48,
                        color: KurumbarDesignSystem.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m['nameTa'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: KurumbarDesignSystem.primaryDark,
                        ),
                      ),
                      Text(
                        m['nameEn'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: KurumbarDesignSystem.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _fieldRow(
                        'உறுப்பினர் எண்',
                        m['id'],
                        isBold: true,
                        color: KurumbarDesignSystem.primaryGreen,
                      ),
                      _fieldRow('குலம்', m['kulam']),
                      _fieldRow('மாவட்டம்', m['district']),
                      _fieldRow('தொகுதி', m['constituency']),
                      _fieldRow(
                        'இரத்த வகை',
                        m['bloodGroup'],
                        isBold: true,
                        color: Colors.red.shade700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Card Bottom Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: KurumbarDesignSystem.primaryGreen.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'www.kurumbar.org',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: KurumbarDesignSystem.primaryDark,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.verified, size: 12, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'அங்கீகரிக்கப்பட்டது',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(Map<String, dynamic> m, bool isTa) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KurumbarDesignSystem.primaryGreen, width: 2),
        boxShadow: KurumbarDesignSystem.floatingShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: KurumbarDesignSystem.primaryDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: const Center(
              child: Text(
                'உறுப்பினர் விதிமுறைகள் & முகவரி',
                style: TextStyle(
                  color: KurumbarDesignSystem.accentYellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'நிரந்தர முகவரி:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: KurumbarDesignSystem.primaryGreen,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  m['address'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: KurumbarDesignSystem.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'தொடர்பு எண்:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: KurumbarDesignSystem.primaryGreen,
                  ),
                ),
                Text(
                  m['phone'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: KurumbarDesignSystem.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'விதிமுறைகள்:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: KurumbarDesignSystem.primaryGreen,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '1. இந்த அடையாள அட்டை குறும்பர் சமூக உறுப்பினருக்கு மட்டுமே உரியது.',
                  style: TextStyle(
                    fontSize: 10,
                    color: KurumbarDesignSystem.textSecondary,
                  ),
                ),
                const Text(
                  '2. சங்க நிகழ்வுகள் மற்றும் நலத்திட்ட உதவிகளுக்கு இவ்வட்டை இன்றியமையாதது.',
                  style: TextStyle(
                    fontSize: 10,
                    color: KurumbarDesignSystem.textSecondary,
                  ),
                ),
                const Text(
                  '3. QR குறியீட்டை ஸ்கேன் செய்து இணையதளத்தில் சரிபார்க்கலாம்.',
                  style: TextStyle(
                    fontSize: 10,
                    color: KurumbarDesignSystem.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: KurumbarDesignSystem.primaryGreen.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            child: const Center(
              child: Text(
                'ஹெல்ப்லைன்: +91 94432 12345 | www.kurumbar.org',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: KurumbarDesignSystem.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 11,
                color: KurumbarDesignSystem.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                color: color ?? KurumbarDesignSystem.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
