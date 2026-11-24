import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:kurumbar/main.dart';

void main() {
  testWidgets('KurumbarApp renders localized title and toggles to Tamil', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: buildRootProviders(),
        child: const KurumbarApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kurumbar'), findsWidgets);
    expect(find.text('தமிழ்'), findsOneWidget);

    await tester.tap(find.text('தமிழ்'));
    await tester.pumpAndSettle();

    expect(find.text('குரும்பர்'), findsWidgets);
    expect(find.text('EN'), findsOneWidget);
  });
}
