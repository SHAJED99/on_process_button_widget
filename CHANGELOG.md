## 0.0.1

- Elevated Button with animation and many functionalities

## 1.0.0

- Documentation updated

## 1.0.1

- Material 3 is integrated

## 1.0.2

- Bug fixed

## 1.0.3

- Fixed box height problem

## 2.0.0

- Fixed box alignment problem

## 2.0.1

- Animation alignment added

## 2.0.2

- Sized error refactored

## 2.0.3

- Color and shadow error refactored

## 2.0.4

- Deprecated properties fixed

## 2.0.5

- Border fixed

## 2.0.6

- Some flutter version error fixed

## 2.0.7

- Button Icon height fixed

## 2.0.8

- Introducing Parent theme and Global Theme. Now you can use your theme globally from the app. So you do not need to add the theme everywhere inside the Project.

## 2.0.9

- Updated analysis options and improved linter rules.

## 2.0.10

- Improved class-level documentation for OnProcessButtonWidget.
- Enhanced documentation clarity for callback functions and their parameters.
- Added detailed descriptions for appearance and layout properties.
- Included default value documentation for themed properties.

## 2.0.11

- **Critical Fix**: Resolved `LateInitializationError` in widget state by refactoring initialization logic.
- **Critical Fix**: Fixed state loss issue where the button would reset its status during parent rebuilds.
- **Bug Fix**: Corrected mathematical error in content height calculation that was causing layout issues with padding.
- **Feature**: Added comprehensive API documentation for all public variables and classes.
- **Feature**: Introducing `OnProcessButtonTheme` and `OnProcessButtonDefaultValues` for global theme management.
- **Improvement**: Optimized widget lifecycle by moving property initialization to `initState`, `didChangeDependencies`, and `didUpdateWidget`.
- **Improvement**: Updated SDK constraints to Flutter 3.16+ to support modern APIs like `TextScaler`.
- **Testing**: Added a comprehensive suite of widget tests to ensure stability across all button states.

## 2.0.12

- **Documentation**: Fixed missing images and demo visuals in README.md.

## 2.0.13

- **Bug Fix**: `boxDecoration()` and height calculation now use resolved `border`/`boxShadow` properties instead of raw widget values — theme/defaults-provided borders and shadows now render correctly.
- **Feature**: `showRunningStatusWidget` now exposed as per-instance constructor parameter (previously only available via theme/defaults).
- **Type Safety**: Replaced untyped `Function` declarations with explicit `void Function` return types for `onStatusChange`, `onDone`, and `onHover` callbacks.
- **Infra**: `analysis_options.yaml` now uses `strict-casts` and `strict-inference` (Dart 3 style). SDK constraint aligned with `flutter_lints ^4.0.0` (`>=3.4.0`).
- **Documentation**: Rewrote README with complete usage patterns and full API reference (all 67 properties in categorized tables, `OnProcessButtonStatus` enum, `OnProcessButtonDefaultValues`, `OnProcessButtonThemeData`, `copyWith()`, etc.). Added `AGENTS.md` for AI tooling.
- **Example**: Rewrote example app without GetX dependency. 9 clean single-feature examples demonstrating all button styles.
