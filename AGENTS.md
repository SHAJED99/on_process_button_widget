# AGENTS.md — OnProcessButtonWidget

## Build & Test Commands

```bash
# Install dependencies
flutter pub get

# Static analysis
flutter analyze

# Run all tests
flutter test

# Run specific test
flutter test --name="success"

# Run example
cd example && flutter run
```

---

## Project Structure

```
lib/
  on_process_button_widget.dart     # Library entry point (imports + part directives)
  src/
    status_enum.dart                # OnProcessButtonStatus enum
    on_process_button_model.dart    # OnProcessButtonDefaultValues (static global config)
    on_process_button_theme.dart    # OnProcessButtonThemeData, OnProcessButtonTheme, OnProcessButtonThemeProvider
    on_process_button_widget.dart   # OnProcessButtonWidget + _OnProcessButtonWidgetState
test/
  on_process_button_widget_test.dart
example/
  lib/main.dart
```

The library uses `part`/`part of` — all 4 source files share `on_process_button_widget.dart`'s namespace and imports.

---

## Package Identity

- **Package name**: `on_process_button_widget`
- **Import**: `import 'package:on_process_button_widget/on_process_button_widget.dart';`
- **Main widget**: `OnProcessButtonWidget`
- **No other dependencies** — pure Flutter (zero third-party packages)

---

## Architecture

### Resolution Chain

Every property resolves through a 3-tier fallback:

```
widget property → OnProcessButtonThemeData (inherited) → OnProcessButtonDefaultValues (static global) → hardcoded default
```

Example for `borderRadius`:
```dart
borderRadius = widget.borderRadius ??
    themeData?.borderRadius ??
    OnProcessButtonDefaultValues.borderRadius ??
    const BorderRadius.all(Radius.circular(8));
```

Three properties (`backgroundColor`, `iconColor`, `fontColor`) use runtime theme values as their final fallback. These are resolved in `___setNotFinalVariables()` because they depend on `Theme.of(context)` which can change:
```dart
backgroundColor = widget.backgroundColor ??
    themeData?.backgroundColor ??
    OnProcessButtonDefaultValues.backgroundColor ??
    Theme.of(context).colorScheme.primary;  // runtime context-dependent
```

All other properties are resolved in `____setValues()`.

### Resolution timing

- `initState()` — initializes `isRunning` only
- `didChangeDependencies()` — calls `____setValues()` + `___setNotFinalVariables()`
- `didUpdateWidget()` — updates `isRunning` if `widget.isRunning` changed, then re-resolves all properties
- `build()` — calls `___setNotFinalVariables()` again (ensures theme-dependent values are current)

### State Machine

The `isRunning` field (type `OnProcessButtonStatus`) drives the UI:

```
stable → (tap) → running → (result=true) → success → (delay) → stable
                        → (result=false) → error  → (delay) → stable
                        → (result=null)  → stable (skip)
```

- `stable`: show `child`
- `running`: show `onRunningWidget` (default `CircularProgressIndicator`) if `showRunningStatusWidget` is true
- `success`: show `onSuccessWidget` (default `Icon(Icons.done)`)
- `error`: show `onErrorWidget` (default `Icon(Icons.error)`)

---

## Complete Property Reference

### Core Callbacks

| Property | Type | Default | Resolution |
|---|---|---|---|
| `onTap` | `Future<bool?>? Function()?` | `null` | widget → theme → defaults |
| `onDone` | `void Function(bool?)?` | `null` | widget → theme → defaults |
| `onStatusChange` | `void Function(BuildContext?, OnProcessButtonStatus)?` | `null` | widget → theme → defaults |

### Interaction Callbacks

| Property | Type | Default |
|---|---|---|
| `onLongPress` | `void Function()?` | `null` |
| `onTapUp` | `void Function(TapUpDetails)?` | `null` |
| `onTapDown` | `void Function(TapDownDetails)?` | `null` |
| `onTapCancel` | `void Function()?` | `null` |
| `onDoubleTap` | `void Function()?` | `null` |
| `onSecondaryTap` | `void Function()?` | `null` |
| `onSecondaryTapUp` | `void Function(TapUpDetails)?` | `null` |
| `onSecondaryTapDown` | `void Function(TapDownDetails)?` | `null` |
| `onSecondaryTapCancel` | `void Function()?` | `null` |

### Mouse / Focus / Highlight

| Property | Type | Default |
|---|---|---|
| `onHover` | `void Function(bool isEnter)?` | `null` |
| `onHovering` | `void Function(PointerHoverEvent)?` | `null` |
| `onFocusChange` | `void Function(bool isFocused)?` | `null` |
| `onHighlightChanged` | `void Function(bool isHighlighted)?` | `null` |
| `mouseCursor` | `MouseCursor?` | `null` |
| `focusNode` | `FocusNode?` | `null` |

### Appearance

| Property | Type | Default | Notes |
|---|---|---|---|
| `backgroundColor` | `Color?` | `Theme.primary` | Runtime theme fallback |
| `iconColor` | `Color?` | `Theme.onPrimary` | Runtime theme fallback; controls child icons too |
| `fontColor` | `Color?` | `Theme.onPrimary` | Runtime theme fallback |
| `fontWeight` | `FontWeight?` | `bold` | |
| `textStyle` | `TextStyle?` | `titleMedium` | Full override; if null, builds from fontColor + fontWeight |
| `border` | `BoxBorder?` | `null` | |
| `borderRadius` | `BorderRadius?` | `Radius.circular(8)` | |
| `boxShadow` | `List<BoxShadow>?` | `null` | When set, background becomes `surface` color |
| `focusColor` | `Color?` | `null` | |
| `splashColor` | `Color?` | `null` | |
| `highlightColor` | `Color?` | `null` | |
| `hoverColor` | `Color?` | `null` | |
| `useMaterial3` | `bool?` | `true` | Controls which theme colors are used |

### Layout

| Property | Type | Default | Notes |
|---|---|---|---|
| `expanded` | `bool` | `true` | Fills width when true |
| `expandedIcon` | `bool?` | `null` | Status icon fills width; falls back to `expanded` |
| `enable` | `bool?` | `true` | Disabled = `onTap` becomes `null` |
| `enableFeedback` | `bool?` | `true` | |
| `autofocus` | `bool?` | `true` | |
| `width` | `double?` | `null` | Fixed width; prefer constraints |
| `height` | `double?` | `null` | Fixed height; prefer constraints |
| `constraints` | `BoxConstraints?` | theme button height | Min height derived from `Theme.buttonTheme.height` minus border widths |
| `contentPadding` | `EdgeInsetsGeometry?` | `horiz:12, vert:4` | |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin |
| `alignment` | `AlignmentGeometry?` | `Alignment.center` | Content alignment |
| `iconHeight` | `double?` | content-based | |

### Animation

| Property | Type | Default |
|---|---|---|
| `animationDuration` | `Duration?` | `500ms` |
| `animationAlignment` | `AlignmentGeometry?` | `Alignment.center` |
| `statusShowingDuration` | `Duration?` | `2s` |
| `roundBorderWhenRunning` | `bool?` | `true` |

### Status Widgets

| Property | Type | Default |
|---|---|---|
| `onRunningWidget` | `Widget?` | `CircularProgressIndicator` (themed) |
| `onSuccessWidget` | `Widget?` | `Icon(Icons.done)` (themed) |
| `onErrorWidget` | `Widget?` | `Icon(Icons.error)` (themed) |
| `showRunningStatusWidget` | `bool?` | `true` |

### Text Styling

| Property | Type | Default |
|---|---|---|
| `textAlign` | `TextAlign?` | `TextAlign.center` |
| `textOverflow` | `TextOverflow?` | `TextOverflow.clip` |
| `textHeightBehavior` | `TextHeightBehavior?` | `null` |
| `textMaxLines` | `int?` | `null` |
| `textWrap` | `bool?` | `true` |
| `textWidthBasis` | `TextWidthBasis?` | `TextWidthBasis.parent` |

### Misc

| Property | Type | Default |
|---|---|---|
| `isRunning` | `bool` | `false` |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` |
| `child` | `Widget?` | `SizedBox()` |

---

## OnProcessButtonDefaultValues

Static class with nullable fields matching every `OnProcessButtonWidget` property. Set before `runApp()`:

```dart
OnProcessButtonDefaultValues.borderRadius = BorderRadius.circular(12);
OnProcessButtonDefaultValues.expandedIcon = true;
OnProcessButtonDefaultValues.roundBorderWhenRunning = false;
OnProcessButtonDefaultValues.onStatusChange = (context, status) { ... };
```

There is **no** `reset()` method — values persist for the app lifetime.

---

## OnProcessButtonTheme / OnProcessButtonThemeProvider

Inherited widget pattern for scoped defaults:

```dart
OnProcessButtonThemeProvider(
  data: const OnProcessButtonThemeData(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    iconColor: Colors.white,
  ),
  child: MyWidget(),
)
```

Resolution order: `widget param → OnProcessButtonTheme.of(context) → OnProcessButtonDefaultValues → default`

---

## OnProcessButtonStatus Enum

```dart
enum OnProcessButtonStatus { stable, running, success, error }
```

---

## Color System Rules

**Never** set `color:` or `style:` directly on `Text()` or `Icon()` children. The button controls all child styling.

| Style | backgroundColor | border | iconColor | fontColor |
|---|---|---|---|---|
| Filled | (theme primary) | (none) | (theme onPrimary) | (theme onPrimary) |
| Outlined | `Colors.transparent` | `Border.all(...)` | `onSurface` | `onSurface` |
| Colored action | `color.withAlpha(25)` | `Border.all(color)` | same `color` | same `color` |

---

## Behavior Notes

- **Double-tap guard**: If `isRunning != stable`, `onTap` is skipped (prevents concurrent operations).
- **Null return**: If `onTap` returns `null`, status display is skipped — goes directly back to `stable` with no icon shown.
- **Exception in onTap**: If `onTap` throws, `result` stays `null` (no icon shown), `onDone(null)` is called, then resets to `stable`.
- **onDone timing**: Called *after* `statusShowingDuration` delay if a result was shown, or immediately after `onTap` if result was `null`.
- **Manual isRunning**: Setting `widget.isRunning = true` forces the running state but does **not** call `onTap`.
- **BoxShadow effects**: When `boxShadow` is set, `boxDecoration` uses `Theme.colorScheme.surface` as the background color (Material elevation behavior).

---

## Code Conventions

- All source files use `part of` the single library file
- The `_OnProcessButtonWidgetState` uses `late` fields for all resolved properties
- Method naming uses underscore prefixes: `____setValues`, `___setNotFinalVariables`, `_____padding`, `_____buttonConstraints`, `____contentHeight`
- Narrowest possible types in state fields (e.g. `late bool expanded`, not `late bool?`)
- The `isRunning` field is typed `OnProcessButtonStatus` despite the misleading name (historical artifact)
