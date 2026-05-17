# Flutter Startup Kit 🚀

A production-ready, enterprise-grade Flutter startup kit with Clean Architecture, Bloc state management, and comprehensive built-in modules.

## 🧩 Usage

### Install

```bash
dart pub global activate flutter_startup_kit
```

### Generate a new project

```bash
flutter_startup_kit create my_app
```

Or with custom options:

```bash
flutter_startup_kit create my_app \
  --org com.mycompany \
  --description "My production Flutter app"
```

### Run your new app

```bash
cd my_app
flutter pub get
flutter run --flavor dev -t lib/main_dev.dart
```

## ✨ Features

- **Clean Architecture** — Domain, Data, Presentation layers per feature
- **Bloc/Cubit** — Scalable state management
- **Dependency Injection** — GetIt
- **Routing** — go_router with deep linking
- **Theming** — Material 3, light/dark mode, design tokens
- **Localization** — Multi-language with RTL support
- **Networking** — Dio with interceptors, retry, token refresh
- **Storage** — Secure storage, shared preferences, Hive
- **WebSocket** — Auto-reconnect, heartbeat, stream handling
- **Notifications** — Firebase + local notifications
- **Analytics** — Firebase Analytics + Crashlytics
- **Error Handling** — Centralized failure/exception system
- **Permissions** — Runtime permission management
- **Testing** — Unit, widget, and integration test structure
- **CI/CD** — GitHub Actions ready

## 📦 What's included

```
lib/
├── app/           — App bootstrap, routing, theme, localization
├── core/          — Base classes, network, storage, services
├── shared/        — Reusable widgets, dialogs, forms, cards
├── features/      — Feature modules (Clean Architecture)
├── l10n/          — Localization ARB files
└── main_*.dart    — Flavor entry points (dev/staging/prod)
```

## 🔧 After Generation

1. Configure Firebase (add `google-services.json` and `GoogleService-Info.plist`)
2. Update `.env.*` files with your API URLs
3. Customize theme colors in `lib/app/theme/app_colors.dart`
4. Add your feature modules in `lib/features/`
5. Configure deep linking in `ios/Runner/Info.plist` and `android/app/src/main/AndroidManifest.xml`

## 📄 License

MIT
