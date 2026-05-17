#!/bin/bash
echo "Setting up Flutter Startup Kit..."
flutter pub get
echo "Generating code..."
dart run build_runner build --delete-conflicting-outputs
echo "Setup complete!"
