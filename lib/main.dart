import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:kurumbar/backend/GoRouter/navigator.dart';
import 'package:kurumbar/backend/providers/app_locale_provider.dart';
import 'package:kurumbar/l10n/app_localizations.dart';
import 'package:kurumbar/utils/design_system.dart';

List<SingleChildWidget> buildRootProviders() => <SingleChildWidget>[
  ChangeNotifierProvider<AppLocaleProvider>(create: (_) => AppLocaleProvider()),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // `.env` is optional during initial scaffold and tests; defaults apply.
  }

  runApp(
    MultiProvider(providers: buildRootProviders(), child: const KurumbarApp()),
  );
}

class KurumbarApp extends StatelessWidget {
  const KurumbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<AppLocaleProvider>().locale;

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          theme: KurumbarDesignSystem.materialTheme,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: appRouter,
        );
      },
    );
  }
}
