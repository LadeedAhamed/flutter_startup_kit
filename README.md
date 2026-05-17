# Flutter Startup Kit

A production-ready, enterprise-grade Flutter startup kit with Clean Architecture, Bloc state management, and comprehensive built-in modules.

## Features

- **Clean Architecture** — Domain, Data, Presentation layers per feature
- **Bloc/Cubit** — Scalable state management
- **Dependency Injection** — GetIt with injectable
- **Routing** — go_router with deep linking & auth guards
- **Theming** — Material 3, light/dark mode, design tokens
- **Localization** — Multi-language with RTL support
- **Networking** — Dio with interceptors, retry, token refresh
- **Storage** — Secure storage, shared preferences, Hive
- **Connectivity** — Real-time internet monitoring
- **WebSocket** — Auto-reconnect, heartbeat, stream handling
- **Notifications** — Firebase + local notifications
- **Analytics** — Firebase Analytics + Crashlytics
- **Logging** — Structured logging with API request tracing
- **Error Handling** — Centralized failure/exception system
- **Permissions** — Runtime permission management
- **Security** — Secure token storage, SSL pinning ready
- **Testing** — Unit, widget, and integration test structure
- **CI/CD** — GitHub Actions + Fastlane ready

## Architecture

```
lib/
├── app/           — App bootstrap, routing, theme, localization
├── core/          — Base classes, network, storage, services
├── shared/        — Reusable widgets, dialogs, forms, cards
├── features/      — Feature modules (Clean Architecture)
├── l10n/          — Localization ARB files
├── generated/     — Generated code
└── main_*.dart    — Flavor entry points
```

## Getting Started

### Prerequisites

- Flutter SDK ^3.11.5
- Dart SDK ^3.11.5

### Setup

```bash
# Clone the repository
git clone <repo-url>
cd flutter_startup_kit

# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run development flavor
flutter run --flavor dev -t lib/main_dev.dart
```

### Available Flavors

| Flavor | Command |
|--------|---------|
| Development | `flutter run --flavor dev -t lib/main_dev.dart` |
| Staging | `flutter run --flavor staging -t lib/main_staging.dart` |
| Production | `flutter run --flavor prod -t lib/main_prod.dart` |

### Environment Variables

Create or update `.env.dev`, `.env.staging`, `.env.prod` files:

```env
APP_NAME=MyApp
BASE_URL=https://api.example.com
SOCKET_URL=wss://socket.example.com
ENV=dev
```

## Project Conventions

- **File naming**: `snake_case.dart`
- **Class naming**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Bloc naming**: `feature_bloc.dart`, `feature_event.dart`, `feature_state.dart`
- **Folder structure per feature**:
  ```
  feature_name/
  ├── data/          — Data sources, models, repositories
  ├── domain/        — Entities, repository interfaces, use cases
  ├── presentation/  — Bloc, pages, widgets
  └── di/            — Dependency injection
  ```

## Dependencies

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| get_it | Dependency injection |
| go_router | Routing |
| dio | HTTP client |
| intl | Localization |
| flutter_secure_storage | Secure storage |
| shared_preferences | Key-value storage |
| hive | Local database |
| flutter_screenutil | Responsive UI |
| flutter_svg | SVG rendering |
| connectivity_plus | Network monitoring |
| web_socket_channel | WebSocket |
| firebase_* | Firebase services |
| logger | Structured logging |
| equatable | Value equality |
| json_serializable | JSON serialization |
| very_good_analysis | Linting rules |

## After Cloning

1. Update `pubspec.yaml` — app name, description
2. Update `android/app/build.gradle` — applicationId, version
3. Update `ios/Runner/Info.plist` — bundle identifier
4. Update `.env.*` files — API URLs, app name
5. Update `assets/` — app icon, splash screen
6. Update theme colors in `lib/app/theme/app_colors.dart`
7. Add/remove feature modules as needed
8. Update Firebase configuration files

## Commit Convention

```
feat: add authentication module
fix: resolve login token refresh issue
refactor: optimize repository layer
```

Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`, `perf`

## License

MIT
