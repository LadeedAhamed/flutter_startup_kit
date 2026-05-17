# Flutter Startup Kit 🚀

A production-ready, enterprise-grade Flutter startup kit with Clean Architecture, Bloc state management, and comprehensive built-in modules.

## 🧩 Usage

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.11.5
- [Mason CLI](https://pub.dev/packages/mason_cli)

### Install Mason CLI

```bash
dart pub global activate mason_cli
```

### Generate a new project

```bash
# From this repository
mason add flutter_startup_kit --git-url https://github.com/YOUR_USERNAME/flutter_startup_kit.git
mason make flutter_startup_kit

# Or directly from the brick
mason make flutter_startup_kit --git-url https://github.com/YOUR_USERNAME/flutter_startup_kit.git
```

### Follow the prompts

```bash
? What is the project name? (my_app) your_app_name
? What is the project description? (A Flutter application) Your app description
? What is the organization name? (com.example) com.yourcompany
```

### Run your new app

```bash
cd your_app_name
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
