# Setup Guide

## Prerequisites

- Flutter SDK >= 3.11.5
- Dart SDK >= 3.11.5
- Xcode (for iOS builds)
- Android Studio (for Android builds)
- CocoaPods (for iOS dependencies)

## Initial Setup

```bash
# Clone the repository
git clone <repository-url>
cd flutter_startup_kit

# Install dependencies
flutter pub get

# Generate code (json_serializable, freezed, injectable)
dart run build_runner build --delete-conflicting-outputs
```

## Firebase Setup

1. Create Firebase project at [firebase.google.com](https://firebase.google.com)
2. Add Android app (package name from `android/app/build.gradle`)
3. Add iOS app (bundle ID from `ios/Runner/Info.plist`)
4. Download `google-services.json` → `android/app/`
5. Download `GoogleService-Info.plist` → `ios/Runner/`
6. Enable Authentication, Firestore, Cloud Messaging

## Running the App

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

## Android Configuration

Update `android/app/build.gradle`:
```gradle
android {
    defaultConfig {
        applicationId "com.yourcompany.yourapp"
        versionCode 1
        versionName "1.0.0"
    }
}
```

## iOS Configuration

Update `ios/Runner/Info.plist`:
```xml
<key>CFBundleIdentifier</key>
<string>com.yourcompany.yourapp</string>
<key>CFBundleName</key>
<string>Your App Name</string>
```
