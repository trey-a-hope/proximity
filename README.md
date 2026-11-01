# Proximity

An early-stage Flutter prototype for location-based groups: share your position, see who is within a chosen radius, and organize people into groups with a leader and invites. It uses Firebase for accounts and data and `geoflutterfire` for radius queries in Firestore.

## Status

This is a work in progress from early 2020. Sign-up, login and the map home screen work, while the Groups and Settings pages are placeholders. Some home-screen logic is still hard-coded for testing (it updates a fixed user document and queries around a fixed point near Dayton, Ohio).

## Features

- **Email sign-up and login** with Firebase Auth (`lib/pages/sign_up_page.dart`, `lib/pages/login_page.dart`, `lib/services/auth_service.dart`).
- **Map home screen**: a Google Map that centers on your location, an "Update My Location" button that saves your position to Firestore as a geo point, and a radius slider in kilometers (`lib/pages/home_page.dart`).
- **Radius query**: streams the users whose saved position falls within the chosen radius using `geoflutterfire`.
- **Data models** for users, groups (name, leader, radius) and group invites (`lib/models/`).

## How it works

`lib/main.dart` registers the services with `get_it` and picks the login or home screen based on the Firebase Auth state. User records live in the Firestore `Users` collection (`lib/services/db_service.dart`), each with a `position` field written by `geoflutterfire`, which is what makes the radius queries possible.

```
lib/
├── main.dart
├── models/      # User, Group, Invite
├── pages/       # login, sign up, home (map), groups, settings
├── services/    # auth, Firestore, modal and validator helpers
└── widgets/     # drawer, spinner, button
```

## Tech stack

- Flutter, Dart SDK `>=2.1.0 <3.0.0` (pre-null-safety)
- Firebase: Auth, Cloud Firestore, Storage, Messaging
- `google_maps_flutter`, `location`, `geoflutterfire`
- `get_it`, `dash_chat` (added, not wired up yet)

## Getting started

1. Use a Flutter SDK that supports Dart 2.x. This project predates null safety and the plugin versions are from 2019-2020, so a current Flutter release won't build it without upgrades.
2. `android/app/google-services.json` is committed for the existing Firebase project. Add the iOS `GoogleService-Info.plist` (and swap the Android file for your own project if needed).
3. The Android Google Maps key is set in `android/app/src/main/AndroidManifest.xml`. iOS needs its own key (`GMSServices.provideAPIKey` in the AppDelegate), which is not set up yet.
4. Install packages and run:

```sh
flutter pub get
flutter run
```
