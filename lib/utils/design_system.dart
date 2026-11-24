import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared visual tokens for Kurumbar mobile app, aligned with
/// `design-system/MASTER.md` brand overrides and Genie design tokens.
abstract final class KurumbarDesignSystem {
  static const Color primaryGreen = Color(0xFF15803D);
  static const Color primaryDark = Color(0xFF14532D);
  static const Color accentYellow = Color(0xFFFACC15);
  static const Color primaryGreenLight = Color(0xFFF0FDF4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAFAF5);
  static const Color cardBg = Color(0xFFF8FAFC);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF475569);
  static const Color error = Color(0xFFDC2626);

  static BorderRadius get radius24 => BorderRadius.circular(24.r);
  static BorderRadius get radius16 => BorderRadius.circular(16.r);
  static BorderRadius get radius12 => BorderRadius.circular(12.r);
  static BorderRadius get radius10 => BorderRadius.circular(10.r);
  static BorderRadius get radiusPill => BorderRadius.circular(100.r);

  static EdgeInsets get paddingAll16 => EdgeInsets.all(16.w);
  static EdgeInsets get paddingH16V12 =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
  static EdgeInsets get paddingH12V8 =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);

  static Widget get spacerH8 => SizedBox(width: 8.w);
  static Widget get spacerH12 => SizedBox(width: 12.w);
  static Widget get spacerH16 => SizedBox(width: 16.w);
  static Widget get spacerV8 => SizedBox(height: 8.h);
  static Widget get spacerV12 => SizedBox(height: 12.h);
  static Widget get spacerV16 => SizedBox(height: 16.h);
  static Widget get spacerV24 => SizedBox(height: 24.h);

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 16.r,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get floatingShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 20.r,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: primaryGreen.withValues(alpha: 0.04),
      blurRadius: 8.r,
      offset: const Offset(0, 2),
    ),
  ];

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: surface,
    borderRadius: radius24,
    border: Border.all(color: border),
    boxShadow: cardShadow,
  );

  static ThemeData get materialTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
      onPrimary: Colors.white,
      secondary: accentYellow,
      onSecondary: primaryDark,
      surface: surface,
      onSurface: textPrimary,
      error: error,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      foregroundColor: textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    cardTheme: CardThemeData(
      color: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(44, 48),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(44, 48),
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
