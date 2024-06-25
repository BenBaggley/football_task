This is a simple project intended to show the the Premiere League football team with the most wins in the past 30 days.
For sake of consistency the date is fixed to December 1st, 2023

## Prerequisites ✅

This project requires Flutter 3.22.0 or higher, and Dart 3.4.0 or higher.

---

## FVM

The project uses [FVM](https://fvm.app/) for version management. To install the correct Flutter version for the project, just run this command in the project root:

```bash
$ fvm install
```

---

## Getting Started 🚀

To run the app either use the launch configuration in VSCode/Android Studio or use the following command:

```sh
$ fvm flutter run --target lib/main.dart
```
---

## Code Generation 🏗️

This project relies on generated code. Generators are provided by various packages and executed using `build_runner`. You can run the generators using this command:

```sh
$ fvm dart pub run build_runner build --delete-conflicting-outputs
```

There is also a `watch` command which will run continuously and update generated code whenever a source code file is changed.

---