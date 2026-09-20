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

## 2.1.0

- **Bug Fix**: An exception thrown from `onTap` no longer leaves the button stuck in the running state permanently — it's now caught, the button resets to `stable` (firing `onDone(null)` like a `null` result), and the original error is rethrown afterward so it still surfaces instead of being silently swallowed.
- **Bug Fix**: `constraints` set via `OnProcessButtonThemeData` or `OnProcessButtonDefaultValues` is now honored — previously only a `constraints` value passed directly to the widget constructor had any effect.
- **Type Safety**: `OnProcessButtonThemeData.copyWith()`'s `onTap` parameter type now matches its constructor/field type (`Future<bool?>? Function()?`), so callbacks that can return a nullable `Future` are no longer rejected.
- **Changed (default)**: `autofocus` now defaults to `false` instead of `true`, matching Flutter's own buttons. Previously every button silently requested autofocus, which took focus away from an autofocused `TextField` in the same scope (breaking forms — no soft keyboard on mobile, focus ring stuck on the button on web/desktop) and made multiple buttons compete for focus. Pass `autofocus: true` explicitly to restore the old behavior on a given button.
- **Bug Fix**: `onDone` no longer receives a stale result from a previous tap. `result` was an instance field, so tapping a button whose resolved `onTap` is `null` reported the previous tap's value (e.g. `true`) even though no operation ran; it is now a local and correctly reports `null`.
- **Behavior**: `enable: false` now disables every tap/press callback (`onLongPress`, `onDoubleTap`, `onTapDown`/`Up`/`Cancel`, `onHighlightChanged`, and the secondary-tap callbacks), not just `onTap`. Hover and focus callbacks still fire, since those aren't activations.
- **Bug Fix**: Corrected the content-height calculation. `TextStyle.height` is a multiple of the font size, not a pixel value, so it was being passed through `TextScaler` and subtracted from the font size; the line height is now computed as `scaledFontSize * height`. Mostly affects status-icon sizing at large accessibility text scales.
- **Documentation**: Noted that a `FocusNode` set on `OnProcessButtonThemeData` or `OnProcessButtonDefaultValues` is shared by every button under it and will misbehave with two mounted at once — prefer setting `focusNode` per widget.
- **Infra**: Adopted `super.key` (and `super.child` for `OnProcessButtonTheme`) to clear `use_super_parameters` lint infos.
