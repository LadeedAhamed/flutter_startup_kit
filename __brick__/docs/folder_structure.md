# Folder Structure

```
lib/
├── app/
│   ├── app.dart                    # Root MaterialApp widget
│   ├── bootstrap.dart              # App initialization + DI setup
│   ├── environment/                # Environment config
│   ├── routes/                     # GoRouter config
│   ├── theme/                      # Material 3 theme system
│   ├── localization/               # App localization setup
│   └── observers/                  # Bloc/Cubit observers
│
├── core/
│   ├── base/                       # Base classes (UseCase, Either)
│   ├── constants/                  # App and API constants
│   ├── enums/                      # Shared enums
│   ├── errors/                     # Failures, exceptions, mappers
│   ├── extensions/                 # Dart extensions
│   ├── helpers/                    # Utility helpers
│   ├── logger/                     # Structured logging
│   ├── network/                    # Dio client, interceptors
│   ├── services/                   # App services
│   ├── storage/                    # Secure + shared preferences
│   ├── database/                   # Local DB (Hive/Isar)
│   ├── websocket/                  # WebSocket manager
│   ├── connectivity/               # Network monitoring
│   ├── analytics/                  # Firebase analytics
│   ├── notifications/              # Push + local notifications
│   ├── permissions/                # Runtime permissions
│   ├── device/                     # Device info
│   ├── config/                     # App configuration
│   └── di/                         # Dependency injection
│
├── shared/
│   ├── widgets/                    # Reusable UI components
│   ├── dialogs/                    # Dialog helpers
│   ├── bottom_sheets/              # Bottom sheet helpers
│   ├── loaders/                    # Loading indicators
│   ├── forms/                      # Form builders
│   ├── cards/                      # Card widgets
│   └── utils/                      # Shared utilities
│
├── features/
│   ├── splash/                     # Splash screen
│   ├── onboarding/                 # Onboarding flow
│   ├── auth/                       # Authentication
│   ├── home/                       # Home dashboard
│   ├── profile/                    # User profile
│   ├── settings/                   # App settings
│   ├── notifications/              # In-app notifications
│   ├── search/                     # Search functionality
│   ├── chat/                       # Chat module
│   └── common_feature_template/    # Feature creation template
│
├── l10n/                           # ARB localization files
├── generated/                      # Generated code
├── main_dev.dart                   # Dev entry point
├── main_staging.dart               # Staging entry point
└── main_prod.dart                  # Production entry point
```
