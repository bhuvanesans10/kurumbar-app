import 'package:flutter/material.dart';
import 'package:kurumbar/utils/design_system.dart';

/// Shared pill badge using Kurumbar's high-contrast dark green on yellow accent.
class BrandBadge extends StatelessWidget {
  const BrandBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KurumbarDesignSystem.paddingH12V8,
      decoration: BoxDecoration(
        color: KurumbarDesignSystem.accentYellow,
        borderRadius: KurumbarDesignSystem.radiusPill,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: KurumbarDesignSystem.primaryDark,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
