# Bouldering Progress Tracker

A Flutter app for tracking problem completion status at climbing gyms.
Works with local storage only, supporting iOS, Android, and web browsers.

## Features

- Add and delete gyms
- Customize grades and problem counts per gym
- View completion status in a grid layout
- Add, edit, and delete completion records (with timestamps)
- Hold rotation history management (generation tracking)

## Packages

| Package | Purpose |
|---|---|
| [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | State management |
| [go_router](https://pub.dev/packages/go_router) | Navigation (URL-based, web-compatible) |
| [hive](https://pub.dev/packages/hive) / [hive_flutter](https://pub.dev/packages/hive_flutter) | Local storage (stored as JSON strings) |
| [freezed_annotation](https://pub.dev/packages/freezed_annotation) / [freezed](https://pub.dev/packages/freezed) | Immutable data model generation |
| [json_annotation](https://pub.dev/packages/json_annotation) / [json_serializable](https://pub.dev/packages/json_serializable) | JSON serialization generation |
| [uuid](https://pub.dev/packages/uuid) | ID generation |
| [build_runner](https://pub.dev/packages/build_runner) | Code generation runner |

## Getting Started

### Prerequisites

- Flutter SDK 3.x or later installed

### Setup

```bash
# Install dependencies
flutter pub get

# Code generation (first time or after model changes)
dart run build_runner build --delete-conflicting-outputs
```

### Running

```bash
# iOS Simulator
flutter run -d ios

# Android Emulator
flutter run -d android

# Web (server only)
flutter run -d web-server --web-port 8080
```

For web, `flutter run -d chrome` launches Chrome as a separate instance with a dedicated temporary profile.
It is recommended to use `web-server` to start the server only, then open `http://localhost:8080` in your existing Chrome.
