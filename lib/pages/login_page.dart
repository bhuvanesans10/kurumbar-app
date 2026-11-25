import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/backend/providers/auth_provider.dart';
import 'package:kurumbar/utils/design_system.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onRegisterTapped;

  const LoginPage({super.key, this.onRegisterTapped});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController(
    text: "9443212345",
  );
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _handleSendOtp(bool isTa) {
    if (_phoneController.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isTa
                ? 'சரியான 10 இலக்க தொலைபேசி எண்ணை உள்ளிடவும்'
                : 'Please enter a valid 10-digit phone number',
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _otpSent = true;
          _otpController.text = "8942"; // Auto-fill demo OTP
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isTa
                  ? 'சரிபார்ப்புக் குறியீடு (OTP: 8942) அனுப்பப்பட்டது'
                  : 'Verification code (OTP: 8942) sent',
            ),
            backgroundColor: KurumbarDesignSystem.primaryGreen,
          ),
        );
      }
    });
  }

  void _handleVerifyOtp() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<AuthProvider>().login(
          phone: '+91 ${_phoneController.text.trim()}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTa = context.watch<AppLocaleProvider>().locale.languageCode == 'ta';

    return Scaffold(
      backgroundColor: KurumbarDesignSystem.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ActionChip(
              avatar: const Icon(
                Icons.language,
                size: 16,
                color: KurumbarDesignSystem.primaryGreen,
              ),
              label: Text(
                isTa ? 'English' : 'தமிழ்',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: KurumbarDesignSystem.primaryDark,
                ),
              ),
              backgroundColor: Colors.white,
              side: const BorderSide(color: KurumbarDesignSystem.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => context.read<AppLocaleProvider>().toggleLocale(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Official Emblem
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: KurumbarDesignSystem.floatingShadow,
                  border: Border.all(
                    color: KurumbarDesignSystem.accentYellow,
                    width: 3,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.shield,
                    size: 50,
                    color: KurumbarDesignSystem.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                isTa
                    ? 'குறும்பர் சமுதாய அதிகாரப்பூர்வ செயலி'
                    : 'Kurumbar Community Official Mobile App',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: KurumbarDesignSystem.primaryDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: KurumbarDesignSystem.accentYellow.withValues(
                    alpha: 0.25,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  isTa
                      ? 'டிஜிட்டல் அட்டை • வரன் தேடல் • சமுதாய சந்தை'
                      : 'Digital ID • Matrimony • Community Marketplace',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: KurumbarDesignSystem.primaryDark,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Login Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: KurumbarDesignSystem.border),
                  boxShadow: KurumbarDesignSystem.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTa ? 'உறுப்பினர் உள்நுழைவு' : 'Member Sign In',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KurumbarDesignSystem.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isTa
                          ? 'உங்கள் தொலைபேசி எண்ணை உள்ளிட்டு OTP பெறவும்'
                          : 'Enter mobile number to receive verification code',
                      style: const TextStyle(
                        fontSize: 13,
                        color: KurumbarDesignSystem.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Phone input
                    Text(
                      isTa ? 'தொலைபேசி எண்' : 'Mobile Number',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: KurumbarDesignSystem.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          child: Text(
                            '+91',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: KurumbarDesignSystem.primaryDark,
                            ),
                          ),
                        ),
                        hintText: '94432 12345',
                        filled: true,
                        fillColor: KurumbarDesignSystem.background,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: KurumbarDesignSystem.border,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: KurumbarDesignSystem.primaryGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    if (_otpSent) ...[
                      const SizedBox(height: 16),
                      Text(
                        isTa
                            ? 'சரிபார்ப்புக் குறியீடு (OTP)'
                            : 'Verification Code (OTP)',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: KurumbarDesignSystem.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 8,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: '• • • •',
                          filled: true,
                          fillColor: KurumbarDesignSystem.background,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: KurumbarDesignSystem.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: KurumbarDesignSystem.primaryGreen,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Primary Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KurumbarDesignSystem.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        onPressed: _isLoading
                            ? null
                            : (_otpSent
                                  ? _handleVerifyOtp
                                  : () => _handleSendOtp(isTa)),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _otpSent
                                    ? (isTa ? 'உள்நுழைக' : 'Verify & Sign In')
                                    : (isTa ? 'OTP பெறுக' : 'Send OTP'),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Quick Demo / Instant Access Button
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.flash_on,
                          size: 18,
                          color: KurumbarDesignSystem.primaryGreen,
                        ),
                        label: Text(
                          isTa
                              ? 'உடனடி உறுப்பினர் பார்வை'
                              : 'Quick Member Demo Login',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: KurumbarDesignSystem.primaryGreen,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: KurumbarDesignSystem.primaryGreen.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor:
                              KurumbarDesignSystem.primaryGreenLight,
                        ),
                        onPressed: () {
                          context.read<AuthProvider>().login(
                            phone: '+91 94432 12345',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Register Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isTa ? 'புதிய உறுப்பினரா? ' : 'Not a registered member? ',
                    style: const TextStyle(
                      fontSize: 14,
                      color: KurumbarDesignSystem.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        widget.onRegisterTapped ??
                        () {
                          context.read<AuthProvider>().login(
                            phone: '+91 94432 12345',
                          );
                        },
                    child: Text(
                      isTa ? 'உறுப்பினராக பதிவு செய்க' : 'Register Here',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: KurumbarDesignSystem.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
