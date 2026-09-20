---
name: using-on-process-button
description: How to correctly use the OnProcessButtonWidget package in app code — the onTap true/false/null return contract, error handling, the rule against styling Text/Icon children directly, per-widget vs theme vs global defaults, and the behaviors that surprise people (delayed onDone, dropped taps while running, expanded defaulting to true). Use this whenever writing or reviewing code that builds an OnProcessButtonWidget, adds a loading/submit/async button, or configures OnProcessButtonDefaultValues or OnProcessButtonTheme — including in the example app. Not for auditing or modifying the package itself; use audit-resolution-chain for that.
---

# Using OnProcessButtonWidget in app code

`OnProcessButtonWidget` is an async button: you hand it an `async` callback and it owns the loading spinner, the success/error icon, self-disabling while running, and the animation between those states. Use it where a tap starts work that can succeed or fail. For instant synchronous actions a plain `ElevatedButton` is a better fit — the async lifecycle is the entire point of this widget.

The full consumer guide is [`README.md`](../../../README.md) — styling recipes, the complete property reference, the "Behavior Worth Knowing" table and the testing section. Read it when you need detail beyond what's here. The essentials:

## The return contract

`onTap` is `Future<bool?>? Function()?` and its return value drives everything:

- `true` → success icon for `statusShowingDuration` (default 2s), then `onDone(true)`
- `false` → error icon for the same duration, then `onDone(false)`
- `null` → no status shown, straight back to idle, `onDone(null)` immediately
- throwing → same as `null` visually, but the error is **rethrown** after the button recovers, so it surfaces as an uncaught async error and fails widget tests

Because of that last point, handle failures inside `onTap` and return `false` rather than letting exceptions escape — that's also what shows the error icon:

```dart
onTap: () async {
  try {
    await api.submit(data);
    return true;
  } catch (e) {
    return false;
  }
},
```

## Never style Text/Icon children directly

The button styles its whole subtree and recolors it as the status changes, so a `color:`/`style:` on a child fights it. Set `fontColor`, `iconColor`, `fontWeight`, or `textStyle` on the button instead. `textStyle` is a full override — if you pass it, `fontColor`/`fontWeight` stop applying, so fold the color into the `TextStyle`.

The exception is a widget you supply for a status slot (`onRunningWidget`, `onSuccessWidget`, `onErrorWidget`) — those are yours to style.

## Where to put defaults

Resolution stops at the first non-null: **widget parameter → `OnProcessButtonTheme` (scoped) → `OnProcessButtonDefaultValues` (global) → built-in**. Set globals before `runApp()`; use `OnProcessButtonThemeProvider` for a subtree.

`OnProcessButtonDefaultValues` is global mutable state with no `reset()`, so anything a test sets leaks into later tests in the same run — clear it in `tearDown`. Never put a `FocusNode` in the theme or globals; it's stateful and must belong to one widget.

## Behaviors that surprise people

- Taps while running or showing a status are **silently dropped** — that's the built-in concurrency guard, so don't add your own "submitting" flag.
- `onDone` fires **after** `statusShowingDuration`, not when `onTap` resolves.
- `isRunning: true` forces the loading visual but never calls `onTap`.
- `enable: false` disables every press callback (2.1.0+), but applies no disabled styling — set your own colors for that.
- `expanded` defaults to **`true`** (fills width); pass `expanded: false` for intrinsic width.
- `autofocus` defaults to `false` as of 2.1.0 (it was `true`, which stole focus from autofocused text fields).
- `onStatusChange` can hand you a `null` `BuildContext` if the widget is gone — null-check before using it.

## Testing app code that uses it

Shorten `statusShowingDuration` in tests, `pump()` once to assert the spinner, then `pumpAndSettle()` to run through to idle. If the code under test lets `onTap` throw, the rethrow fails the test and `tester.takeException()` won't catch it — wrap the interaction in `runZonedGuarded`, or better, catch inside `onTap`.
