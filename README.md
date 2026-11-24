# Kurumbar Mobile App (Flutter)

Bilingual (Tamil & English) Android + iOS client for the Kurumbar Community Platform, following the Genie `the-genie-customer-app` architecture (`Provider` + `GoRouter` + `KurumbarDesignSystem`).

## Structure (`lib/`)

- `backend/api/` — HTTP API wrappers (`ProtectedRoutesApiService`, `ApiConfig`, `ApiResponse`)
- `backend/providers/` — `ChangeNotifier` state providers (`AppLocaleProvider`, ...)
- `backend/GoRouter/` — Single-source-of-truth route table (`navigator.dart`)
- `pages/` — Screen widgets (UI only, zero direct HTTP calls)
- `components/` — Reusable UI components
- `l10n/` — English (`app_en.arb`) and Tamil (`app_ta.arb`) localization bundles
- `utils/design_system.dart` — `KurumbarDesignSystem` tokens derived from `design-system/MASTER.md`

## Run & Verify

```bash
cp .env.template .env
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
```
