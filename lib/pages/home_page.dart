import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/components/brand_badge.dart';
import 'package:kurumbar/l10n/app_localizations.dart';
import 'package:kurumbar/utils/design_system.dart';

/// Initial placeholder Home screen matching `KurumbarDesignSystem`.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCode = context.watch<AppLocaleProvider>().locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
            color: KurumbarDesignSystem.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              child: OutlinedButton(
                onPressed: () =>
                    context.read<AppLocaleProvider>().toggleLocale(),
                child: Text(localeCode == 'en' ? 'தமிழ்' : 'EN'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: KurumbarDesignSystem.paddingAll16,
          child: Container(
            width: double.infinity,
            padding: KurumbarDesignSystem.paddingAll16,
            decoration: KurumbarDesignSystem.cardDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandBadge(label: l10n.appTitle),
                KurumbarDesignSystem.spacerV16,
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: KurumbarDesignSystem.textPrimary,
                  ),
                ),
                KurumbarDesignSystem.spacerV8,
                const Text(
                  'www.kurumbar.org',
                  style: TextStyle(
                    fontSize: 16,
                    color: KurumbarDesignSystem.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
