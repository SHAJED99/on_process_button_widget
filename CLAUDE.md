# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

`AGENTS.md` in this repo holds the exhaustive property reference (every widget property, its type, default and resolution path) and the color-system table. Read it before adding, renaming or changing a property. This file covers the parts that only emerge from reading several source files at once.

`doc/auditing.md` is the method for auditing this package for real bugs — the seven patterns that have produced confirmed bugs here, and how to verify each one by running code rather than reading it. Read it before an audit or a release. (Claude Code also has it as an auto-triggering skill under `.claude/skills/audit-resolution-chain/`.)

## Commands

The project pins Flutter 3.27.3 via FVM (`.fvmrc`, `.vscode/settings.json` points Dart at `.fvm/versions/3.27.3`). Prefix commands with `fvm` when the global Flutter differs from that.

```bash
flutter pub get
flutter analyze                       # flutter_lints + strict-casts + strict-inference
flutter test
flutter test --plain-name "shows loading indicator"   # single test by name
cd example && flutter run             # the example app is the main manual test surface
```

## Architecture

A zero-dependency, single-widget package. `lib/on_process_button_widget.dart` is the only real library file — the four files under `lib/src/` are `part of` it and share its imports and namespace. Adding a source file means adding both a `part` directive there and `part of '../on_process_button_widget.dart';` at the top of the new file.

### The 3-tier resolution chain

Every user-facing property is resolved, not read directly. This is the single most important invariant:

```
widget.<prop> ?? OnProcessButtonTheme.of(context)?.<prop> ?? OnProcessButtonDefaultValues.<prop> ?? hardcoded
```

Adding one property therefore means touching **four** places in lockstep:
1. `OnProcessButtonWidget` constructor + field (`on_process_button_widget.dart`)
2. `OnProcessButtonThemeData` constructor + field + the `copyWith` at `on_process_button_theme.dart:273`
3. `OnProcessButtonDefaultValues` static field (`on_process_button_model.dart`)
4. The resolution line in `_OnProcessButtonWidgetState`

Where the resolution line goes depends on whether the final fallback needs `BuildContext`:
- `____setValues(context)` (~line 647) — context-independent fallbacks. Called from `didChangeDependencies` and `didUpdateWidget`.
- `___setNotFinalVariables(context)` (~line 832) — `backgroundColor`, `iconColor`, `fontColor`, whose last fallback is `Theme.of(context).colorScheme.*`. Called from `didChangeDependencies`, `didUpdateWidget` **and every `build()`**, so a live `ThemeData` swap re-colors the button.

### State machine

`isRunning` is a field of type `OnProcessButtonStatus` (`stable | running | success | error`) — the name is a historical artifact, not a bool. The tap handler in `build()` drives it: `stable → running → success|error → (statusShowingDuration) → stable`, firing `onStatusChange` at each transition and `onDone(result)` at the end. A `null` from `onTap` skips the status icon and returns straight to `stable`. If `onTap` throws, it's caught, treated the same as a `null` result (state resets to `stable`, `onDone(null)` still fires), and the original error is rethrown afterwards via `Error.throwWithStackTrace` so it isn't silently swallowed — but the button always recovers first. A tap while `isRunning != stable` is dropped — that is the concurrency guard, so don't "fix" it.

Setting `widget.isRunning = true` from outside forces the running visual but never invokes `onTap`; `didUpdateWidget` syncs it.

### Conventions specific to this codebase

- Multi-underscore method names (`____setValues`, `___setNotFinalVariables`, `_____padding`, `_____buttonConstraints`, `____contentHeight`) are deliberate and order the private surface — keep the style when adding neighbours.
- Resolved state fields are `late` and use the narrowest type (`late bool expanded`, never `late bool?`), since resolution guarantees non-null.
- `OnProcessButtonDefaultValues` is process-global mutable state with no `reset()`. Any test that sets it leaks into later tests in the same run; clear the field manually in `tearDown`.
- Children must not carry their own `color:`/`style:` — the button styles its subtree via `iconColor`/`fontColor`/`textStyle`. See the color table in `AGENTS.md`.
- Public API is documented with `///` on every member (pub.dev score); keep new public members documented.

## Release

`pubspec.yaml` version, `CHANGELOG.md` and the README are updated together; commits follow `chore: bump version to X.Y.Z` / `docs: …` / `fix: …`.
