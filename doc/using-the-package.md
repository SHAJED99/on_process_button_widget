# Using `on_process_button_widget` — a guide for AI agents

This is for agents **building an app that uses this package**. If you're auditing or modifying the package itself, read [`auditing.md`](auditing.md) instead.

`OnProcessButtonWidget` replaces a normal button for anything asynchronous. You give it an `async` callback; it handles the loading spinner, the success/error icon, disabling itself while running, and animating between those states. Reach for it wherever a tap kicks off work that can succeed or fail — form submits, saves, deletes, network calls. If a tap does something instant and synchronous, a plain `ElevatedButton` is the better choice; this widget's whole value is the async lifecycle.

Applies to **2.1.0+**. Some defaults changed in 2.1.0 — they're flagged below.

```yaml
dependencies:
  on_process_button_widget: ^2.1.0
```

## The core contract: what you return from `onTap`

Everything about the widget's behavior follows from the return value. `onTap` is `Future<bool?>? Function()?`, and the three return values mean three different things:

| You return | What the user sees | When `onDone` fires |
|---|---|---|
| `true` | Success icon (`Icons.done`) for `statusShowingDuration` | after that delay, with `true` |
| `false` | Error icon (`Icons.error`) for `statusShowingDuration` | after that delay, with `false` |
| `null` | Nothing — straight back to idle | immediately, with `null` |
| *(it throws)* | Nothing — straight back to idle | immediately, with `null` |

```dart
OnProcessButtonWidget(
  onTap: () async {
    final ok = await api.submitForm(data);
    return ok; // true → check mark, false → error icon
  },
  child: const Text('Submit'),
)
```

**Handle your own errors inside `onTap`.** If `onTap` throws, the button recovers correctly, but the error is then rethrown so it isn't silently swallowed — which means it surfaces as an uncaught async error in your app (and will fail your widget tests). If a failure should show the error icon rather than blow up, catch it and return `false`:

```dart
onTap: () async {
  try {
    await api.submitForm(data);
    return true;
  } catch (e) {
    logger.warning('submit failed', e);
    return false; // shows the error icon
  }
},
```

Return `null` when you don't want any status feedback — a refresh button, or a tap that navigates away.

## The one rule that trips everyone up: don't style children

The button owns the color and text style of its whole subtree. Setting `color:` or `style:` directly on a `Text` or `Icon` child fights the button's own styling and breaks the status states, which recolor the subtree as they animate.

```dart
// Wrong — the child overrides the button's color system
child: const Text('Save', style: TextStyle(color: Colors.white)),

// Right — tell the button, not the child
fontColor: Colors.white,
child: const Text('Save'),
```

Use `fontColor` for text, `iconColor` for icons (this also colors the spinner and status icons), `textStyle` to replace the text style wholesale, and `fontWeight` for weight alone. Note `textStyle` is a full override: if you pass it, `fontColor` and `fontWeight` no longer apply, so put the color inside the `TextStyle`.

### Three styling recipes

```dart
// Filled (the default — no color properties needed)
OnProcessButtonWidget(
  onTap: () async => true,
  child: const Text('Submit'),
)

// Outlined
OnProcessButtonWidget(
  expanded: false,
  backgroundColor: Colors.transparent,
  border: Border.all(color: Theme.of(context).colorScheme.outline),
  iconColor: Theme.of(context).colorScheme.onSurface,
  fontColor: Theme.of(context).colorScheme.onSurface,
  fontWeight: FontWeight.normal,
  onTap: () async => true,
  child: const Text('Refresh'),
)

// Destructive / colored action
OnProcessButtonWidget(
  expanded: false,
  backgroundColor: Colors.red.withValues(alpha: 0.1),
  border: Border.all(color: Colors.red),
  iconColor: Colors.red,
  fontColor: Colors.red,
  fontWeight: FontWeight.normal,
  onTap: () async => await deleteItem(),
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(Icons.delete_outline, size: 18),
      SizedBox(width: 8),
      Text('Delete'),
    ],
  ),
)
```

## Setting defaults app-wide

Every property resolves in this order, stopping at the first non-null:

```
the widget's own parameter → OnProcessButtonTheme (scoped) → OnProcessButtonDefaultValues (global) → built-in default
```

Pick the level that matches the scope you mean:

```dart
// Global — set before runApp(). Applies everywhere.
void main() {
  OnProcessButtonDefaultValues.borderRadius = BorderRadius.circular(12);
  OnProcessButtonDefaultValues.roundBorderWhenRunning = false;
  runApp(const MyApp());
}

// Scoped — applies to a subtree, and overrides the globals for it.
OnProcessButtonThemeProvider(
  data: const OnProcessButtonThemeData(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    expanded: false,
  ),
  child: const CheckoutForm(),
)
```

`OnProcessButtonDefaultValues` is plain global mutable state with **no `reset()`** — values live for the process. Two consequences: set it once before `runApp()`, and in tests, anything you set leaks into later tests in the same run, so clear it in `tearDown`.

Don't put a `FocusNode` in either the theme or the global defaults. A `FocusNode` is stateful and must belong to one widget; shared across buttons it misbehaves as soon as two are mounted. Pass `focusNode` per widget.

## Behavior worth knowing before you're surprised by it

| Behavior | What to expect |
|---|---|
| **Taps during a run are dropped** | While the button is running/showing a status, further taps are ignored. This is the concurrency guard — you don't need your own "already submitting" flag. |
| **`onDone` is delayed** | On a `true`/`false` result it fires *after* `statusShowingDuration` (default **2s**), not when `onTap` resolves. Don't use it for anything latency-sensitive; use it to chain follow-up work. |
| **`isRunning: true` doesn't call `onTap`** | It forces the loading visual only. Use it when something *else* drives the loading state. |
| **`enable: false` disables all press callbacks** | Since 2.1.0 this covers long-press, double-tap, tap up/down/cancel and secondary taps — not just `onTap`. Hover and focus callbacks still fire. It applies no "disabled" styling, so set your own colors if you want it to look disabled. |
| **`expanded` defaults to `true`** | The button fills the available width. Set `expanded: false` for an intrinsic-width button. |
| **`autofocus` defaults to `false`** | Changed in 2.1.0 — it used to be `true` and would steal focus from an autofocused `TextField`. If you relied on the old behavior, pass `autofocus: true` explicitly. |
| **`onStatusChange` may hand you a `null` context** | It fires on every transition (`running → success/error → stable`), but passes `null` for the `BuildContext` if the widget is gone. Null-check before using it — see the dialog pattern below. |

### Chaining work after the status shows

```dart
OnProcessButtonWidget(
  onTap: () async => await saveDraft(),
  onDone: (bool? isSuccess) {
    if (isSuccess == true) Navigator.of(context).pop();
  },
  child: const Text('Save'),
)
```

### Reacting to every transition

```dart
OnProcessButtonDefaultValues.onStatusChange = (BuildContext? context, OnProcessButtonStatus status) {
  if (context == null) return; // the widget may already be gone
  if (status == OnProcessButtonStatus.running) {
    showDialog(context: context, barrierDismissible: false, builder: (_) => const BlockingSpinner());
  } else if (status == OnProcessButtonStatus.stable) {
    Navigator.of(context).pop();
  }
};
```

### Custom status widgets

Replace any of the three states. These widgets are yours, so you *do* style them yourself:

```dart
OnProcessButtonWidget(
  onRunningWidget: const Text('Saving…'),
  onSuccessWidget: const Icon(Icons.cloud_done),
  onErrorWidget: const Icon(Icons.warning_rounded),
  onTap: () async => await save(),
  child: const Text('Save'),
)
```

Set `showRunningStatusWidget: false` to keep the label visible while running instead of swapping in a spinner.

## Testing app code that uses this button

The status delay is real time in tests, so a bare `pump()` won't get you to the end state. Shorten the duration and settle:

```dart
await tester.pumpWidget(MaterialApp(
  home: Scaffold(
    body: OnProcessButtonWidget(
      statusShowingDuration: const Duration(milliseconds: 10),
      onTap: () async => true,
      child: const Text('Submit'),
    ),
  ),
));

await tester.tap(find.text('Submit'));
await tester.pump();                      // spinner is now showing
expect(find.byType(CircularProgressIndicator), findsOneWidget);
await tester.pumpAndSettle();             // runs through success → stable
```

If the code under test has an `onTap` that throws, the rethrown error reaches the zone and fails the test outright — `tester.takeException()` won't catch it. Wrap the interaction:

```dart
final caught = <Object>[];
await runZonedGuarded(() async {
  await tester.tap(find.text('Submit'));
  await tester.pump();
}, (Object error, StackTrace stack) => caught.add(error));
```

Better still, catch inside `onTap` and return `false` so this doesn't come up.

## Full reference

This guide covers the parts that are easy to get wrong. For the exhaustive list of all ~67 properties with types and defaults, see [`../README.md`](../README.md) and [`../AGENTS.md`](../AGENTS.md). Working examples of every style live in [`../example/lib/main.dart`](../example/lib/main.dart).
