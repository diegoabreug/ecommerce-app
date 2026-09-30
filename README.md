# Food Delivery App

A food-delivery style mobile app built with Flutter and Firebase: users sign up, browse restaurants and menus, and manage their profile.

## Features

- Email/password sign-up and login with **Firebase Authentication** and form validation
- User profiles stored in **Cloud Firestore** with real-time updates
- Profile photo upload with **image_picker** and **Firebase Storage**
- Tabbed navigation: Explore, Favorites, My Orders, Profile (Favorites and Orders are in progress)
- Restaurant menu screen with image carousels (cached network images, SVG icons)
- Custom theming: buttons, inputs, checkboxes and typography

## Tech stack

- Flutter / Dart
- Firebase Auth, Cloud Firestore, Firebase Storage
- cached_network_image, flutter_svg, image_picker, form_field_validator

## Getting started

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install).

```bash
git clone https://github.com/diegoabreug/ecommerce-app.git
cd ecommerce-app
flutter pub get
flutter run
```

> **Firebase setup:** this project doesn't include Firebase config files. Create a Firebase project and run `flutterfire configure` to generate your own before running.

## Project structure

```
lib/
├── main.dart
├── constants.dart
└── src/
    ├── controllers/   # Auth and user logic (Firebase)
    ├── models/        # User, menu item, slide card
    ├── themes/        # App-wide theme data
    └── views/
        ├── components/    # Login/register forms, reusable widgets
        └── screens/       # Auth screens and tab screens
```

## Author

**Diego Abreu** · [GitHub](https://github.com/diegoabreug)
